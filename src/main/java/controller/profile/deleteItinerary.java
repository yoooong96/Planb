package controller.profile;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDto;
import service.profile.ProfileFeedService;
import service.profile.ProfileFeedServiceImpl;

/**
 * Servlet implementation class deleteItinerary
 */
@WebServlet("/profile/itinerary/delete")
public class deleteItinerary extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProfileFeedService profileFeedService = new ProfileFeedServiceImpl();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteItinerary() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		if(session == null) {
			response.sendRedirect(request.getContextPath()+"/view/auth/login.jsp");
			return;
		}
		
		UserDto user = (UserDto)session.getAttribute("user");
		if(user == null) {
			response.sendRedirect(request.getContextPath()+"/view/auth/login.jsp");
			return;
		}
		
		try {
			String itineraryIdParam = request.getParameter("itineraryId");
			if(itineraryIdParam == null || itineraryIdParam.trim().isEmpty()) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "일정 번호가 없습니다.");
				return;
			}
			
			long itineraryId = Long.parseLong(itineraryIdParam);
			long userId = user.getUserId();
			
			profileFeedService.deleteItinerary(itineraryId, userId);
			
			response.sendRedirect(request.getContextPath()+"/profile/myProfile");
		} catch(Exception e) {
			e.printStackTrace();
			throw new ServletException("일정 삭제 중 오류가 발생했습니다.", e);  
				
			}
		}
	}

