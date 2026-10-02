package controller.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.member.UserService;
import service.member.UserServiceImpl;

/**
 * Servlet implementation class checkDuplicate
 */
@WebServlet("/auth/check-duplicate")
public class checkDuplicate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService service = new UserServiceImpl();

	public checkDuplicate() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String type = request.getParameter("type");
		String value = request.getParameter("value");
		boolean available = false;

		if (value != null && !value.trim().isEmpty()) {
			if ("loginId".equals(type)) {
				available = service.isLoginIdAvailable(value);
			} else if ("nickname".equals(type)) {
				available = service.isNicknameAvailable(value);
			} else if ("email".equals(type)) {
				available = service.isEmailAvailable(value);
			}
		}
		response.getWriter().print("{\"available\":" + available + "}");
	}

}
