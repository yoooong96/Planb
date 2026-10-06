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
import service.exchange.ExchangeRateService;
import service.exchange.ExchangeRateServiceImpl;
import service.itinerary.ItineraryCartService;
import service.itinerary.ItineraryCartServiceImpl;
import service.itinerary.ItineraryService;
import service.itinerary.ItineraryServiceImpl;

@WebServlet("/modifyplan")
public class ModifyPlanServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ItineraryService itineraryService;
    private ItineraryCartService itineraryCartService;
    private ExchangeRateService exchangeRateService;
    private Gson gson;

    public ModifyPlanServlet() {
        itineraryService = new ItineraryServiceImpl();
        itineraryCartService = new ItineraryCartServiceImpl();
        exchangeRateService = new ExchangeRateServiceImpl();
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

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        UserDto loginUser = (UserDto) session.getAttribute("user");
        String itineraryIdParam = request.getParameter("itineraryId");

        if (itineraryIdParam == null || itineraryIdParam.trim().isEmpty()) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "수정할 일정 번호가 없습니다."
            );
            return;
        }

        try {
            Long itineraryId = Long.valueOf(itineraryIdParam);
            ItineraryDto editItinerary = itineraryService.getItinerary(itineraryId);

            if (editItinerary == null) {
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "일정을 찾을 수 없습니다."
                );
                return;
            }

            /*
             * 본인이 작성한 일정만 수정 화면에 진입할 수 있다.
             * 다른 사용자의 일정이면 수정 화면을 노출하지 않고
             * 신규 작성 화면으로 이동한다.
             */
            if (editItinerary.getUserId() == null
                    || editItinerary.getUserId().longValue() != loginUser.getUserId()) {

                response.sendRedirect(
                        request.getContextPath() + "/writeplan"
                );
                return;
            }

            List<ItineraryDto> importList =
                    itineraryCartService.getCartItineraries(loginUser.getUserId());

            if (importList == null) {
                importList = Collections.emptyList();
            }

            request.setAttribute("importListJson", gson.toJson(importList));
            request.setAttribute(
                    "exchangeRatesJson",
                    gson.toJson(exchangeRateService.getExchangeRates())
            );
            request.setAttribute("editItinerary", editItinerary);
            request.setAttribute("editItineraryJson", gson.toJson(editItinerary));

            request.getRequestDispatcher(
                    "/view/itinerary/planeditor.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "잘못된 일정 번호입니다."
            );
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(
                    "일정 수정 페이지를 불러오는 중 오류가 발생했습니다.",
                    e
            );
        }
    }
}
