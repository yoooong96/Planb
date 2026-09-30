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

	    try {

	        UserDto user = service.login(id, password);

	        if (user == null) {
	            throw new Exception("아이디 또는 비밀번호가 올바르지 않습니다.");
	        }

	        HttpSession session = request.getSession();

	        // 로그인 회원 정보 전체를 세션에 저장
	        session.setAttribute("user", user);

	        // 로그인 성공 후 홈으로 이동
	        response.sendRedirect(
	            request.getContextPath()
	            + "/view/home/home.jsp"
	        );

	    } catch (Exception e) {

	        e.printStackTrace();

	        request.setAttribute(
	            "err",
	            e.getMessage()
	        );

	        request.getRequestDispatcher(
	            "/view/auth/login.jsp"
	        ).forward(request, response);
	    }
	}

}
