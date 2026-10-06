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
 * Servlet implementation class findPassword
 */
@WebServlet("/auth/findPassword")
public class findPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private UserService service = new UserServiceImpl();

	public findPassword() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/view/auth/findPassword.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String loginId = request.getParameter("loginId");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");

		try {

			Long userId = service.findPasswordUser(loginId, name, email, phone);

			/*
			 * URL이나 hidden input에 userId를 넣지 않고 세션에 저장
			 */
			HttpSession session = request.getSession();

			session.setAttribute("passwordResetUserId", userId);

			response.sendRedirect(request.getContextPath() + "/view/auth/resetPassword.jsp");

		} catch (Exception e) {

			request.setAttribute("errorMessage", e.getMessage());

			request.getRequestDispatcher("/view/auth/findPassword.jsp").forward(request, response);

		}

	}

}
