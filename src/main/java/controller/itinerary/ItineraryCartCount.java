package controller.itinerary;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDto;
import service.itinerary.ItineraryCartService;
import service.itinerary.ItineraryCartServiceImpl;
import util.JsonResponse;

/**
 * Servlet implementation class ItineraryCartCount
 */
@WebServlet("/itinerary/cart/count")
public class ItineraryCartCount extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ItineraryCartCount() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setHeader("Cache-Control", "no-store");

		HttpSession session = request.getSession(false);

		UserDto loginUser = session == null ? null : (UserDto) session.getAttribute("user");

		try {
			int cartCount = 0;

			if (loginUser != null && loginUser.getUserId() > 0) {

				ItineraryCartService service = new ItineraryCartServiceImpl();

				cartCount = service.getCartCount(loginUser.getUserId());
			}

			Map<String, Object> result = new HashMap<>();

			result.put("success", true);
			result.put("cartCount", cartCount);

			JsonResponse.writeJson(response, result);

		} catch (Exception e) {

			getServletContext().log("장바구니 개수 조회 중 오류 발생", e);

			JsonResponse.writeFailure(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "장바구니 개수를 불러오지 못했습니다.");
		}
	}

}
