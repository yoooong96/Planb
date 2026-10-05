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

import com.google.gson.Gson;

import dto.member.UserDto;
import service.itinerary.ItineraryService;
import service.itinerary.ItineraryServiceImpl;

/**
 * Servlet implementation class ItineraryLike
 */
@WebServlet("/itinerary/like")
public class ItineraryLike extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ItineraryLike() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		HttpSession session = request.getSession(false);

		UserDto loginUser = session == null ? null : (UserDto) session.getAttribute("user");

		// 로그인 확인
		if (loginUser == null || loginUser.getUserId() <= 0) {

			writeFailure(response, HttpServletResponse.SC_UNAUTHORIZED, "로그인 후 이용할 수 있습니다.");
			return;
		}

		// 일정 번호 확인
		Long itineraryId;

		try {
			String id = request.getParameter("itineraryId");

			if (id == null || id.trim().isEmpty()) {
				throw new IllegalArgumentException();
			}

			itineraryId = Long.valueOf(id.trim());

			if (itineraryId <= 0) {
				throw new IllegalArgumentException();
			}

		} catch (IllegalArgumentException e) {
			writeFailure(response, HttpServletResponse.SC_BAD_REQUEST, "올바른 일정 번호가 아닙니다.");
			return;
		}

		try {
			ItineraryService service = new ItineraryServiceImpl();

			Map<String, Object> result = service.toggleLike(itineraryId, loginUser.getUserId());

			result.put("success", true);

			response.getWriter().write(new Gson().toJson(result));

		} catch (SecurityException e) {
			writeFailure(response, HttpServletResponse.SC_FORBIDDEN, e.getMessage());

		} catch (IllegalArgumentException e) {
			writeFailure(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());

		} catch (Exception e) {
			getServletContext().log("좋아요 처리 중 오류 발생", e);

			writeFailure(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "좋아요 처리 중 오류가 발생했습니다.");
		}
	}

	private void writeFailure(HttpServletResponse response, int status, String message) throws IOException {

		response.setStatus(status);

		Map<String, Object> result = new HashMap<>();
		result.put("success", false);
		result.put("message", message);

		response.getWriter().write(new Gson().toJson(result));
	}
}
