package controller.travel;

import java.io.IOException;
import java.util.List;

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

/**
 * Servlet implementation class ScheduleList
 */
@WebServlet("/schedules")
public class ScheduleList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScheduleList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 기존 세션만 가져오기
			HttpSession session = request.getSession(false);
			UserDto loginUser = null;
			if (session != null) {
				loginUser = (UserDto) session.getAttribute("user");
			}
			
			// 	비로그인이면 null
			Long loginUserId = null;
			if (loginUser != null) {
				loginUserId = loginUser.getUserId();
			}
			
			ItineraryService service = new ItineraryServiceImpl();
			
			// Service를 통해 목록 조회
            List<ItineraryDto> scheduleList = service.getScheduleList(loginUserId);

            // JSP에 전달
            request.setAttribute("scheduleList",scheduleList);

			// 화면 출력
			request.getRequestDispatcher("/view/travel/scheduleList.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
