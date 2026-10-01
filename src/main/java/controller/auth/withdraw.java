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
 * Servlet implementation class withdraw
 */
@WebServlet("/auth/withdraw")
public class withdraw extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private UserService service = new UserServiceImpl();
    
    public withdraw() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath()+ "/view/auth/login.jsp");
            return;
        }

        UserDto user =(UserDto) session.getAttribute("user");

        if (user == null) {response.sendRedirect(request.getContextPath()+ "/view/auth/login.jsp");
            return;
        }

        String password = request.getParameter( "password");

        try {
            service.withdraw(user.getUserId(),password);
            /*
             * 탈퇴 완료 후 로그인 세션 제거
             */
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/view/auth/login.jsp?withdraw=success");
        } catch (Exception e) {
            request.setAttribute( "errorMessage", e.getMessage() );
            request.getRequestDispatcher("/view/auth/withdraw.jsp").forward( request,response );
        }

    }

}
