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

@WebServlet("/writeplan")
public class WritePlanServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ItineraryCartService itineraryCartService;
    private ExchangeRateService exchangeRateService;
    private Gson gson;

    public WritePlanServlet() {
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

        try {
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

            request.getRequestDispatcher(
                    "/view/itinerary/planner.jsp"
            ).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(
                    "일정 작성 페이지를 불러오는 중 오류가 발생했습니다.",
                    e
            );
        }
    }
}
