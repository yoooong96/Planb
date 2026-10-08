package controller.community;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.community.MateDto;
import dto.member.UserDto;
import service.community.MateService;
import service.community.MateServiceImpl;

@WebServlet("/mateDelete")
public class MateDelete extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private MateService mateService = new MateServiceImpl();

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

		String mateIdParam = request.getParameter("mateId");

		if (mateIdParam == null || mateIdParam.trim().isEmpty()) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			out.print("{\"success\":false}");
			return;
		}

		long mateId;

		try {
			mateId = Long.parseLong(mateIdParam);
		} catch (NumberFormatException e) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			out.print("{\"success\":false}");
			return;
		}

		MateDto mate = mateService.selectMate(mateId);

		if (mate == null) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			out.print("{\"success\":false}");
			return;
		}

		if (loginUser.getUserId() != mate.getUserId()) {
			response.setStatus(HttpServletResponse.SC_FORBIDDEN);
			out.print("{\"success\":false}");
			return;
		}

		int result = mateService.deleteMate(mateId, loginUser.getUserId());

		out.print("{\"success\":" + (result > 0) + "}");
	}
}