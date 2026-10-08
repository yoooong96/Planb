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
 * Servlet implementation class ItineraryCartToggle
 */
@WebServlet("/itinerary/cart/toggle")
public class ItineraryCartToggle extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ItineraryCartToggle() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-store");

		HttpSession session = request.getSession(false);

		UserDto loginUser = session == null ? null : (UserDto) session.getAttribute("user");

		if (loginUser == null || loginUser.getUserId() <= 0) {

			JsonResponse.writeFailure(response, HttpServletResponse.SC_UNAUTHORIZED, "로그인 후 이용할 수 있습니다.");

			return;
		}

		try {
			long itineraryId = readPositiveId(request.getParameter("itineraryId"), "일정 번호");

			long targetId = readPositiveId(request.getParameter("targetId"), "장바구니 대상 번호");

			String itemType = request.getParameter("itemType");

			if (itemType == null || itemType.trim().isEmpty()) {
				throw new IllegalArgumentException("장바구니 유형이 필요합니다.");
			}

			ItineraryCartService service = new ItineraryCartServiceImpl();

			Map<String, Object> result = service.toggleCart(loginUser.getUserId(), itineraryId, itemType.trim(),
					targetId);

			result.put("success", true);

			JsonResponse.writeJson(response, result);

		} catch (SecurityException e) {

			JsonResponse.writeFailure(response, HttpServletResponse.SC_FORBIDDEN, e.getMessage());

		} catch (IllegalArgumentException e) {

			JsonResponse.writeFailure(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());

		} catch (Exception e) {

			getServletContext().log("장바구니 담기·해제 중 오류 발생", e);

			JsonResponse.writeFailure(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "장바구니 처리 중 오류가 발생했습니다.");
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
