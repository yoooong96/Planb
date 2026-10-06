package controller.profile;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDto;
import dto.profile.ProfileFeedDto;
import service.profile.ProfileFeedService;
import service.profile.ProfileFeedServiceImpl;

/**
 * Servlet implementation class myProfile
 */
@WebServlet("/profile/myProfile")
public class myProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public myProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

    	ProfileFeedService profileFeedService = new ProfileFeedServiceImpl();
    	
    	HttpSession session = request.getSession(false);
    	if(session == null) {
    		response.sendRedirect(request.getContextPath()+"/auth/login");
    		return;
    	}
    	
    	UserDto user = (UserDto) session.getAttribute("user");
    	if(user==null) {
    		response.sendRedirect(request.getContextPath()+"/auth/login");
    		return;
    	}
    	
    	long userId = user.getUserId();
    	try {
    		List<ProfileFeedDto> myItineraries = profileFeedService.getMyItineraries(userId);
    		List<ProfileFeedDto> bookmarkedItineraries = profileFeedService.getBookmarkedItineraries(userId);
    		List<ProfileFeedDto> likedItineraries = profileFeedService.getLikedItineraries(userId);

    		request.setAttribute("myItineraries", myItineraries);
    		request.setAttribute("bookmarkedItineraries", bookmarkedItineraries);
    		request.setAttribute("likedItineraries", likedItineraries);
    		request.setAttribute("postCount", myItineraries.size());
    		request.getRequestDispatcher("/view/profile/myProfile.jsp").forward(request, response);
    	} catch(Exception e) {
    		throw new ServletException(e);
    	}
	}

}
