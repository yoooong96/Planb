package controller.community;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.community.MateCommentDto;
import dto.member.UserDto;
import service.community.MateCommentService;
import service.community.MateCommentServiceImpl;

@WebServlet("/mateCommentDelete")
public class MateCommentDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MateCommentService mateCommentService = new MateCommentServiceImpl();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");

		PrintWriter out = response.getWriter();

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			out.print("{\"success\":false}");
			return;
		}

		UserDto loginUser = (UserDto) session.getAttribute("user");

		String commentIdParam = request.getParameter("commentId");

		if (commentIdParam == null) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			out.print("{\"success\":false}");
			return;
		}

		Long commentId;

		try {
			commentId = Long.parseLong(commentIdParam);
		} catch (NumberFormatException e) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			out.print("{\"success\":false}");
			return;
		}

		MateCommentDto existingComment = mateCommentService.selectMateComment(commentId);

		if (existingComment == null) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			out.print("{\"success\":false}");
			return;
		}

		if (loginUser.getUserId() != existingComment.getUserId()) {
			response.setStatus(HttpServletResponse.SC_FORBIDDEN);
			out.print("{\"success\":false}");
			return;
		}

		MateCommentDto mateCommentDto = new MateCommentDto();
		mateCommentDto.setCommentId(commentId);
		mateCommentDto.setUserId(loginUser.getUserId());

		int result = mateCommentService.deleteMateComment(mateCommentDto);

		out.print("{\"success\":" + (result > 0) + "}");
	}
}