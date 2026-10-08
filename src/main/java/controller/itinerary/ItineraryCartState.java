package controller.itinerary;

import java.io.IOException;
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
 * Servlet implementation class ItineraryCartState
 */
@WebServlet("/itinerary/cart/state")
public class ItineraryCartState extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ItineraryCartState() {
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
			long itineraryId = readPositiveId(request.getParameter("itineraryId"), "일정 번호");

			Long loginUserId = loginUser == null || loginUser.getUserId() <= 0 ? null : loginUser.getUserId();

			ItineraryCartService service = new ItineraryCartServiceImpl();

			Map<String, Object> result = service.getCartState(loginUserId, itineraryId);

			result.put("success", true);

			JsonResponse.writeJson(response, result);

		} catch (SecurityException e) {

			JsonResponse.writeFailure(response, HttpServletResponse.SC_FORBIDDEN, e.getMessage());

		} catch (IllegalArgumentException e) {

			JsonResponse.writeFailure(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());

		} catch (Exception e) {

			getServletContext().log("장바구니 상태 조회 중 오류 발생", e);

			JsonResponse.writeFailure(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "장바구니 상태를 불러오지 못했습니다.");
		}
	}

	private long readPositiveId(String value, String name) {

		if (value == null || value.trim().isEmpty()) {
			throw new IllegalArgumentException(name + "를 확인해주세요.");
		}

		try {
			long id = Long.parseLong(value.trim());

			if (id <= 0) {
				throw new IllegalArgumentException(name + "는 양수여야 합니다.");
			}

			return id;

		} catch (NumberFormatException e) {
			throw new IllegalArgumentException("올바른 " + name + "가 아닙니다.");
		}
	}

}
