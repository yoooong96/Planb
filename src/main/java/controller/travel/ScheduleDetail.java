package controller.travel;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.itinerary.ItineraryDto;
import dto.member.UserDto;
import service.itinerary.ItineraryService;
import service.itinerary.ItineraryServiceImpl;
import service.report.ReportService;
import service.report.ReportServiceImpl;

/**
 * Servlet implementation class ScheduleDetail
 */
@WebServlet("/schedules/detail")
public class ScheduleDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ScheduleDetail() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String id = request.getParameter("id");

			if (id == null || id.trim().isEmpty()) {
				throw new IllegalArgumentException("일정 번호가 필요합니다.");
			}

			Long itineraryId = Long.valueOf(id.trim());

			if (itineraryId <= 0) {
				throw new IllegalArgumentException("올바른 일정 번호가 아닙니다.");
			}

			HttpSession session = request.getSession(false);
			Long loginUserId = null;

			if (session != null) {
				UserDto user = (UserDto) session.getAttribute("user");

				if (user != null) {
					loginUserId = user.getUserId();
				}
			}

			ItineraryService service = new ItineraryServiceImpl();

			ItineraryDto itinerary = service.getScheduleDetail(itineraryId, loginUserId);

			if (itinerary == null) {
				response.sendError(HttpServletResponse.SC_NOT_FOUND, "일정을 찾을 수 없습니다.");
				return;
			}

			request.setAttribute("itinerary", itinerary);

			request.setAttribute("comments", service.getItineraryComments(itineraryId, loginUserId));

			// 신고 팝업에 표시할 활성 신고 사유 조회
			ReportService reportService = new ReportServiceImpl();

			request.setAttribute("reportReasons", reportService.getContentReportReasons());

			request.getRequestDispatcher("/view/travel/scheduleDetail.jsp").forward(request, response);

		} catch (IllegalArgumentException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "올바른 일정 번호가 필요합니다.");

		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
}
