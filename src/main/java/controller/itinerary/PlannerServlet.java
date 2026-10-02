package controller.itinerary;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dto.itinerary.ItineraryDto;
import dto.member.UserDto;
import service.itinerary.ItineraryCartService;
import service.itinerary.ItineraryCartServiceImpl;
import service.itinerary.ItineraryService;
import service.itinerary.ItineraryServiceImpl;

@WebServlet("/planner")
public class PlannerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ItineraryService itineraryService;
    private ItineraryCartService itineraryCartService;
    private Gson gson;

    public PlannerServlet() {
        itineraryService = new ItineraryServiceImpl();
        itineraryCartService = new ItineraryCartServiceImpl();
        gson = new Gson();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("user") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/auth/login"
            );

            return;
        }

        UserDto loginUser =
                (UserDto) session.getAttribute("user");

        String itineraryIdParam =
                request.getParameter("itineraryId");

        try {

            /*
             * planner 좌측 일정 가져오기.
             *
             * 카트 화면과 동일한 Service 결과:
             * List<ItineraryDto>
             */
            List<ItineraryDto> importList =
                    itineraryCartService.getCartItineraries(
                            loginUser.getUserId()
                    );

            if (importList == null) {
                importList = Collections.emptyList();
            }

            /*
             * JSP에서 JS 렌더링에 사용.
             * Gson 기본 HTML escaping으로 <, > 등의
             * 스크립트 삽입 위험도 같이 줄인다.
             */
            request.setAttribute(
                    "importListJson",
                    gson.toJson(importList)
            );


            /*
             * itineraryId가 있으면 수정 모드.
             */
            if (itineraryIdParam != null
                    && !itineraryIdParam.trim().isEmpty()) {

                Long itineraryId =
                        Long.valueOf(itineraryIdParam);

                ItineraryDto editItinerary =
                        itineraryService.getItinerary(
                                itineraryId
                        );

                if (editItinerary == null) {

                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "일정을 찾을 수 없습니다."
                    );

                    return;
                }

                /*
                 * 본인 일정만 수정 가능.
                 */
                if (editItinerary.getUserId() == null
                        || editItinerary.getUserId().longValue()
                        != loginUser.getUserId()) {

                    response.sendError(
                            HttpServletResponse.SC_FORBIDDEN,
                            "수정 권한이 없습니다."
                    );

                    return;
                }

                request.setAttribute(
                        "editItinerary",
                        editItinerary
                );

                request.setAttribute(
                        "editItineraryJson",
                        gson.toJson(editItinerary)
                );
            }

            request.getRequestDispatcher(
                    "/view/itinerary/planner.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "잘못된 일정 번호입니다."
            );

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(
                    "일정 작성 페이지를 불러오는 중 오류가 발생했습니다.",
                    e
            );
        }
    }
}
