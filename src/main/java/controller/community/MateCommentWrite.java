package controller.community;

import java.io.IOException;

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

@WebServlet("/mateCommentWrite")
public class MateCommentWrite extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public MateCommentWrite() {
		super();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			response.getWriter().write("{\"success\":false,\"loginRequired\":true}");
			return;
		}

		UserDto user = (UserDto) session.getAttribute("user");

		String mateIdParam = request.getParameter("mateId");
		String content = request.getParameter("content");

		if (mateIdParam == null || mateIdParam.trim().isEmpty() || content == null || content.trim().isEmpty()) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			response.getWriter().write("{\"success\":false}");
			return;
		}

		try {
			long mateId = Long.parseLong(mateIdParam);

			MateCommentDto mateCommentDto = new MateCommentDto();

			mateCommentDto.setMateId(mateId);
			mateCommentDto.setUserId(user.getUserId());
			mateCommentDto.setContent(content.trim());

			MateCommentService mateCommentService = new MateCommentServiceImpl();

			int result = mateCommentService.insertMateComment(mateCommentDto);

			if (result > 0) {
				response.getWriter().write(
					"{\"success\":true,\"commentId\":" + mateCommentDto.getCommentId() + "}"
				);
			} else {
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write("{\"success\":false}");
			}

		} catch (NumberFormatException e) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			response.getWriter().write("{\"success\":false}");
		}
	}
}