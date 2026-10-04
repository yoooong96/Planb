package controller.community;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDto;
import dto.community.TipDto;
import service.community.TipService;
import service.community.TipServiceImpl;

@WebServlet("/tipWriteList")
public class TipWriteList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TipService tipService;
	@Override
	public void init() throws ServletException {
		tipService = new TipServiceImpl();
	}
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// 로그인 세션 확인
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		// 현재 로그인 사용자
		UserDto user = (UserDto) session.getAttribute("user");
		long userId = user.getUserId();

		try {
			// 현재 사용자가 작성한 글 조회
			List<TipDto> tipList = tipService.selectMyTipList(userId);
			// JSP로 전달
			request.setAttribute("tipList", tipList);
			request.getRequestDispatcher("/view/tips/tipWriteList.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
	}
}