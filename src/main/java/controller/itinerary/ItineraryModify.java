package controller.itinerary;

import java.io.IOException;
import java.lang.reflect.Type;
import java.sql.Date;
import java.sql.Time;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;

import dto.itinerary.ItineraryDto;
import dto.member.UserDto;
import service.itinerary.ItineraryService;
import service.itinerary.ItineraryServiceImpl;

@WebServlet("/itinerary/modify")
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 100,
        fileSizeThreshold = 1024 * 1024
)
public class ItineraryModify extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ItineraryService itineraryService;
    private Gson gson;

    public ItineraryModify() {
        itineraryService = new ItineraryServiceImpl();
        gson = createGson();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/auth/login"
            );
            return;
        }

        UserDto loginUser =
                (UserDto) session.getAttribute("user");

        List<File> uploadedFiles =
                new ArrayList<File>();

        try {

            String json =
                    request.getParameter("itineraryJson");

            if (json == null || json.trim().isEmpty()) {
                throw new IllegalArgumentException(
                        "수정할 일정 데이터가 없습니다."
                );
            }

            ItineraryDto itineraryDto =
                    gson.fromJson(
                            json,
                            ItineraryDto.class
                    );

            validateRequiredFields(itineraryDto);

            if (itineraryDto.getItineraryId() == null) {
                throw new IllegalArgumentException(
                        "수정할 일정 번호가 없습니다."
                );
            }

            /*
             * 수정 대상이 실제 로그인 사용자의 일정인지 확인한다.
             */
            ItineraryDto savedItinerary =
                    itineraryService.getItinerary(
                            itineraryDto.getItineraryId()
                    );

            if (savedItinerary == null) {
                throw new IllegalArgumentException(
                        "수정할 일정을 찾을 수 없습니다."
                );
            }

            if (savedItinerary.getUserId() == null
                    || savedItinerary.getUserId().longValue()
                    != loginUser.getUserId()) {

                response.sendError(
                        HttpServletResponse.SC_FORBIDDEN,
                        "수정 권한이 없습니다."
                );

                return;
            }

            /*
             * 클라이언트의 userId는 무시한다.
             */
            itineraryDto.setUserId(
                    loginUser.getUserId()
            );

            /*
             * 새로 선택한 사진만 실제 파일로 저장하고
             * ImageDto.imageUrl을 채운다.
             *
             * 기존 사진은 기존 imageUrl을 그대로 사용.
             */
            uploadedFiles =
                    ItineraryImageUploadUtil
                            .bindUploadedImages(
                                    request,
                                    itineraryDto
                            );

            String thumbnailImageKey =
                    request.getParameter(
                            "thumbnailImageKey"
                    );

            itineraryDto.setThumbnailImg(
                    ItineraryImageUploadUtil
                            .resolveThumbnailImageUrl(
                                    itineraryDto,
                                    thumbnailImageKey
                            )
            );

            validatePublishFields(itineraryDto);

            itineraryService.modifyItinerary(
                    itineraryDto
            );

            /*
             * DB 수정 성공 후에만
             * 화면에서 제거된 기존 이미지의 실제 파일을 삭제한다.
             */
            ItineraryImageUploadUtil
                    .deleteRemovedImages(
                            request.getServletContext(),
                            savedItinerary,
                            itineraryDto
                    );

            /*
             * 기능명세서:
             * 수정 성공 -> 일정 상세페이지 이동
             */
            response.sendRedirect(
                    request.getContextPath()
                    + "/view/travel/scheduleDetail.jsp?id="
                    + itineraryDto.getItineraryId()
            );

        } catch (IllegalArgumentException e) {

            ItineraryImageUploadUtil
                    .deleteCreatedFiles(
                            uploadedFiles
                    );

            request.setAttribute(
                    "err",
                    e.getMessage()
            );

            request.getRequestDispatcher(
                    "/view/itinerary/planner.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            ItineraryImageUploadUtil
                    .deleteCreatedFiles(
                            uploadedFiles
                    );

            e.printStackTrace();

            throw new ServletException(
                    "일정 수정 중 오류가 발생했습니다.",
                    e
            );
        }
    }


    private void validateRequiredFields(
            ItineraryDto itineraryDto) {

        if (itineraryDto == null) {
            throw new IllegalArgumentException(
                    "일정 데이터가 없습니다."
            );
        }

        if (itineraryDto.getTitle() == null
                || itineraryDto.getTitle()
                        .trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "여행 제목은 필수입니다."
            );
        }

        if (itineraryDto.getCountry() == null
                || itineraryDto.getCountry()
                        .trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "국가는 필수입니다."
            );
        }

        if (itineraryDto.getTravelerCount() != null
                && itineraryDto.getTravelerCount() < 1) {

            throw new IllegalArgumentException(
                    "여행 인원은 1명 이상이어야 합니다."
            );
        }

        if (itineraryDto.getStartDate() != null
                && itineraryDto.getEndDate() != null
                && itineraryDto.getEndDate()
                        .before(itineraryDto.getStartDate())) {

            throw new IllegalArgumentException(
                    "종료일은 시작일보다 빠를 수 없습니다."
            );
        }
    }


    private void validatePublishFields(
            ItineraryDto itineraryDto) {

        if (itineraryDto.getSummary() == null
                || itineraryDto.getSummary()
                        .trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "일정 소개를 작성해 주세요."
            );
        }

        if (itineraryDto.getThumbnailImg() == null
                || itineraryDto.getThumbnailImg()
                        .trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "대표 이미지를 선택해 주세요."
            );
        }
    }


    private Gson createGson() {

        GsonBuilder builder =
                new GsonBuilder();

        builder.registerTypeAdapter(
                Date.class,
                new JsonDeserializer<Date>() {

                    @Override
                    public Date deserialize(
                            JsonElement json,
                            Type typeOfT,
                            JsonDeserializationContext context)
                            throws JsonParseException {

                        if (json == null
                                || json.isJsonNull()
                                || json.getAsString().trim().isEmpty()) {
                            return null;
                        }

                        return Date.valueOf(
                                json.getAsString()
                        );
                    }
                }
        );

        builder.registerTypeAdapter(
                Time.class,
                new JsonDeserializer<Time>() {

                    @Override
                    public Time deserialize(
                            JsonElement json,
                            Type typeOfT,
                            JsonDeserializationContext context)
                            throws JsonParseException {

                        if (json == null
                                || json.isJsonNull()
                                || json.getAsString().trim().isEmpty()) {
                            return null;
                        }

                        String value =
                                json.getAsString();

                        if (value.length() == 5) {
                            value += ":00";
                        }

                        return Time.valueOf(value);
                    }
                }
        );

        return builder.create();
    }
}
