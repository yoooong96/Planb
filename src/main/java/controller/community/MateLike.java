package controller.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDto;
import service.community.MateLikeService;
import service.community.MateLikeServiceImpl;

@WebServlet("/mateLike")
public class MateLike extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MateLikeService mateLikeService = new MateLikeServiceImpl();

	public MateLike() {
		super();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			response.getWriter().write("{\"success\":false}");
			return;
		}

		try {
			UserDto user = (UserDto) session.getAttribute("user");

			Long mateId = Long.parseLong(request.getParameter("mateId"));
			Long userId = user.getUserId();

			boolean liked = mateLikeService.toggleMateLike(mateId, userId);
			int likeCount = mateLikeService.countMateLike(mateId);

			response.getWriter().write(
				"{\"success\":true,\"liked\":" + liked + ",\"likeCount\":" + likeCount + "}"
			);

		} catch (Exception e) {
			e.printStackTrace();

			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write("{\"success\":false}");
		}
	}
}