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
 * 회원 탈퇴
 *
 * LOCAL / GOOGLE 공통 이메일 인증 방식
 */
@WebServlet("/auth/withdraw")
public class withdraw extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private UserService service = new UserServiceImpl();

	public withdraw() {

		super();

	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/view/auth/withdraw.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		/*
		 * ===================================================== 로그인 확인
		 * ======================================================
		 */

		HttpSession session = request.getSession(false);

		if (session == null) {

			response.sendRedirect(request.getContextPath() + "/view/auth/login.jsp");

			return;
		}

		UserDto user = (UserDto) session.getAttribute("user");

		if (user == null) {

			response.sendRedirect(request.getContextPath() + "/view/auth/login.jsp");

			return;
		}

		try {

			/*
			 * ================================================= 탈퇴 동의 확인
			 * ==================================================
			 */

			String withdrawAgree = request.getParameter("withdrawAgree");

			if (!"Y".equals(withdrawAgree)) {

				throw new Exception("회원 탈퇴에 동의해주세요.");
			}

			/*
			 * ================================================= 탈퇴용 이메일 인증 확인
			 * ==================================================
			 */

			Boolean emailVerified = (Boolean) session.getAttribute("withdrawEmailVerified");

			String verifiedEmail = (String) session.getAttribute("withdrawVerifiedEmail");

			if (!Boolean.TRUE.equals(emailVerified)) {

				throw new Exception("이메일 인증을 완료해주세요.");
			}

			if (verifiedEmail == null || verifiedEmail.trim().isEmpty()) {

				throw new Exception("이메일 인증 정보를 확인할 수 없습니다.");
			}

			/*
			 * ================================================= 현재 사용자 이메일
			 * ==================================================
			 */

			String userEmail = user.getEmail();

			if (userEmail == null || userEmail.trim().isEmpty()) {

				throw new Exception("회원 이메일 정보를 확인할 수 없습니다.");
			}

			/*
			 * ================================================= 인증 이메일 비교
			 * ==================================================
			 */

			if (!userEmail.trim().equalsIgnoreCase(verifiedEmail.trim())) {

				throw new Exception("현재 계정의 이메일과 인증한 이메일이 일치하지 않습니다.");
			}

			/*
			 * ================================================= 실제 탈퇴
			 * ==================================================
			 */

			service.withdraw(user.getUserId());

			/*
			 * ================================================= 세션 제거
			 * ==================================================
			 */

			session.invalidate();

			/*
			 * ================================================= 로그인 페이지 이동
			 * ==================================================
			 */

			response.sendRedirect(request.getContextPath() + "/view/auth/login.jsp" + "?withdraw=success");

		} catch (Exception e) {

			e.printStackTrace();

			request.setAttribute("errorMessage", e.getMessage());

			request.getRequestDispatcher("/view/auth/withdraw.jsp").forward(request, response);
		}
	}
}