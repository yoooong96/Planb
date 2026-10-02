package controller.auth;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class GoogleAuth
 */
@WebServlet("/auth/google")
public class GoogleAuth extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GoogleAuth() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String clientId= System.getenv("GOOGLE_CLIENT_ID");
		String redirectUri = System.getenv("GOOGLE_REDIRECT_URI");
		if(clientId == null || redirectUri == null) {
			throw new ServletException("Google OAuth 환경변수가 설정되지 않았습니다.");
		}
		
		SecureRandom random = new SecureRandom();
		byte[] bytes = new byte[32];
		
		random.nextBytes(bytes);
		
		String state = Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
		HttpSession session= request.getSession();
		session.setAttribute("googleOAuthState", state);
		
		String scope = "openid email profile";
		
		String googleUrl = "https://accounts.google.com/o/oauth2/v2/auth"
							+ "?client_id="
							+ encode(clientId)
							
							+ "&redirect_uri="
			                + encode(redirectUri)

			                + "&response_type=code"

			                + "&scope="
			                + encode(scope)

			                + "&state="
			                + encode(state);
		
				response.sendRedirect(googleUrl);
	}
						
	private String encode(String value) {
		return URLEncoder.encode(value,StandardCharsets.UTF_8);
	}
		

}
