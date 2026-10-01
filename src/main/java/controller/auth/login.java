package controller.auth;

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
 * Servlet implementation class login
 */
@WebServlet("/auth/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/view/auth/login.jsp").forward(request, response);
	}
	
	@Override
	protected void doPost(
	        HttpServletRequest request,
	        HttpServletResponse response)
	        throws ServletException, IOException {

	    String id = request.getParameter("loginId");
	    String password = request.getParameter("password");

	    UserService service = new UserServiceImpl();
	    UserDto user;

	    try {
	        user = service.login(id, password);
	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("err", e.getMessage());
	        request.getRequestDispatcher("/view/auth/login.jsp").forward(request, response);
	        return;
	    }

	    HttpSession session = request.getSession();
	    session.setAttribute("user", user);
	    response.sendRedirect(request.getContextPath() + "/view/home/home.jsp");
	}

}
