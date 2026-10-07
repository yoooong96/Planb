package controller.settings;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDto;
import service.member.UserService;
import service.member.UserServiceImpl;

/**
 * Servlet implementation class privacySettings
 */
@WebServlet(
		urlPatterns = {"/settings/privacySettings",
					"/settings/privacy/profile",
					"/settings/privacy/like",
					"/settings/privacy/bookmark"
					
		})
public class privacySettings extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private UserService userService = new UserServiceImpl();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public privacySettings() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/view/settings/privacySettings.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		if(session == null || session.getAttribute("user") == null) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			
			response.getWriter().write("{\"success\":false," + "\"message\":\"로그인이 필요합니다.\"}" );
			return;
		}
		
		UserDto user = (UserDto) session.getAttribute("user");
		long userId= user.getUserId();
		try {
			String path = request.getServletPath();
			
			if("/settings/privacy/profile".equals(path)) {
				String value = request.getParameter("profileVisibility");
				userService.updateProfileVisibility(userId, value);
			}
			
			else if("/settings/privacy/like".equals(path)) {
				boolean show = Boolean.parseBoolean(request.getParameter("showLikedItinerary"));
				userService.updateShowLikedItinerary(userId, show);
			}
			
			else if("/settings/privacy/bookmark".equals(path)) {
				boolean show = Boolean.parseBoolean(request.getParameter("showBookmarkedItinerary"));
				userService.updateShowBookmarkedItinerary(userId, show);
			}
			
			else {
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				response.getWriter().write("{\"success\":false,"+"\"message\":\"잘못된 요청입니다.\"}");
				return;
			}
			
			/*
             * DB에서 최신 회원정보 다시 조회
             *
             * 세션에 옛날 값이 남는 문제 방지
             */
            UserDto refreshedUser =
                    userService.getUserById(
                            userId
                    );


            if (refreshedUser != null) {

                session.setAttribute(
                        "user",
                        refreshedUser
                );
            }


            response.getWriter().write(
                "{\"success\":true}"
            );


        } catch (IllegalArgumentException e) {

            response.setStatus(
                    HttpServletResponse.SC_BAD_REQUEST
            );

            response.getWriter().write(
                "{\"success\":false}"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.setStatus(
                    HttpServletResponse
                        .SC_INTERNAL_SERVER_ERROR
            );

            response.getWriter().write(
                "{\"success\":false}"
            );
        }
	}
}
