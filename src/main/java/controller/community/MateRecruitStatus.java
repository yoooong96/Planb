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

@WebServlet("/mateRecruitStatus")
public class MateRecruitStatus extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private MateService mateService = new MateServiceImpl();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");

		PrintWriter out = response.getWriter();

		// 로그인 확인
		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {

			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			out.print("{\"success\":false}");

			return;
		}

		UserDto loginUser = (UserDto) session.getAttribute("user");

		try {

			// mateId
			long mateId = Long.parseLong(request.getParameter("mateId"));

			// 현재 게시글 조회
			MateDto mate = mateService.selectMate(mateId);

			if (mate == null) {

				response.setStatus(HttpServletResponse.SC_NOT_FOUND);
				out.print("{\"success\":false}");

				return;
			}

			// 작성자 확인
			if (loginUser.getUserId() != mate.getUserId()) {

				response.setStatus(HttpServletResponse.SC_FORBIDDEN);
				out.print("{\"success\":false}");

				return;
			}

			// 현재 상태 확인 후 반대로 변경
			String newStatus;

			if ("OPEN".equals(mate.getRecruitStatus())) {
				newStatus = "CLOSED";
			} else {
				newStatus = "OPEN";
			}

			int result = mateService.updateRecruitStatus(
				mateId,
				loginUser.getUserId(),
				newStatus
			);

			if (result == 0) {

				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				out.print("{\"success\":false}");

				return;
			}

			out.print(
				"{\"success\":true,\"recruitStatus\":\""
				+ newStatus
				+ "\"}"
			);

		} catch (NumberFormatException e) {

			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			out.print("{\"success\":false}");

		} catch (Exception e) {

			e.printStackTrace();

			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			out.print("{\"success\":false}");
		}
	}
}