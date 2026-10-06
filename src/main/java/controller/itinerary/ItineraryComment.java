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
import service.itinerary.ItineraryService;
import service.itinerary.ItineraryServiceImpl;
import util.JsonResponse;

/**
 * Servlet implementation class ItineraryComment
 */
@WebServlet({ "/itinerary/comment/write", "/itinerary/comment/delete" })
public class ItineraryComment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ItineraryComment() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession(false);

		UserDto loginUser = session == null ? null : (UserDto) session.getAttribute("user");

		if (loginUser == null || loginUser.getUserId() <= 0) {

			JsonResponse.writeFailure(response, HttpServletResponse.SC_UNAUTHORIZED, "로그인 후 이용할 수 있습니다.");
			return;
		}

		try {
			Long itineraryId = readPositiveId(request.getParameter("itineraryId"), "일정");

			ItineraryService service = new ItineraryServiceImpl();

			Map<String, Object> result;

			String path = request.getServletPath();

			if ("/itinerary/comment/write".equals(path)) {

				result = service.writeItineraryComment(itineraryId, loginUser.getUserId(),
						request.getParameter("content"));

			} else if ("/itinerary/comment/delete".equals(path)) {

				Long commentId = readPositiveId(request.getParameter("commentId"), "댓글");

				result = service.deleteItineraryComment(itineraryId, commentId, loginUser.getUserId());

			} else {
				JsonResponse.writeFailure(response, HttpServletResponse.SC_NOT_FOUND, "올바르지 않은 요청입니다.");
				return;
			}

			result.put("success", true);

			JsonResponse.writeJson(response, result);

		} catch (SecurityException e) {

			JsonResponse.writeFailure(response, HttpServletResponse.SC_FORBIDDEN, e.getMessage());

		} catch (IllegalArgumentException e) {

			JsonResponse.writeFailure(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());

		} catch (Exception e) {

			getServletContext().log("댓글 처리 중 오류 발생", e);

			JsonResponse.writeFailure(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "댓글 처리 중 오류가 발생했습니다.");
		}
	}

	private Long readPositiveId(String value, String label) {

		if (value == null || value.trim().isEmpty()) {
			throw new IllegalArgumentException("올바른 " + label + " 번호가 아닙니다.");
		}

		try {
			long id = Long.parseLong(value.trim());

			if (id <= 0) {
				throw new IllegalArgumentException("올바른 " + label + " 번호가 아닙니다.");
			}

			return id;

		} catch (NumberFormatException e) {
			throw new IllegalArgumentException("올바른 " + label + " 번호가 아닙니다.");
		}
	}
}
