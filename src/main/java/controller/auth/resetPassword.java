package controller.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.member.UserService;
import service.member.UserServiceImpl;

/**
 * Servlet implementation class resetPassword
 */
@WebServlet("/auth/resetPassword")
public class resetPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService service = new UserServiceImpl();

	public resetPassword() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		HttpSession session = request.getSession(false);
		if (session == null) {
			response.sendRedirect(request.getContextPath() + "/view/auth/findPassword.jsp");
			return;
		}

		Long userId = (Long) session.getAttribute("passwordResetUserId");

		if (userId == null) {
			response.sendRedirect(request.getContextPath() + "/view/auth/findPassword.jsp");
			return;

		}

		String password = request.getParameter("password");
		String passwordConfirm = request.getParameter("passwordConfirm");

		if (password == null || !password.equals(passwordConfirm)) {
			request.setAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
			request.getRequestDispatcher("/view/auth/resetPassword.jsp").forward(request, response);
			return;
		}

		try {

			service.resetPassword(userId, password);
			/*
			 * 재설정 권한 제거
			 */
			session.removeAttribute("passwordResetUserId");
			response.sendRedirect(request.getContextPath() + "/view/auth/login.jsp?reset=success");
		} catch (Exception e) {
			request.setAttribute("errorMessage", e.getMessage());
			request.getRequestDispatcher("/view/auth/resetPassword.jsp").forward(request, response);

		}
	}

}
