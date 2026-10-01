package controller.auth;

import java.io.IOException;
import java.security.SecureRandom;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.email.EmailService;
import service.member.UserService;
import service.member.UserServiceImpl;

/**
 * Servlet implementation class emailSend
 */
@WebServlet("/auth/emailSend")
public class emailSend extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private UserService userService = new UserServiceImpl();

	private EmailService emailService = new EmailService();

	private SecureRandom random = new SecureRandom();

	public emailSend() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");

		if (email == null || email.trim().isEmpty()) {

			sendJson(response, false, "이메일을 입력해주세요.");

			return;

		}

		email = email.trim().toLowerCase();

		/*
		 * 기본 이메일 형식 확인
		 */
		if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {

			sendJson(response, false, "올바른 이메일 형식이 아닙니다.");

			return;

		}

		try {

			/*
			 * 이미 가입된 이메일인지 재확인
			 */
			if (!userService.isEmailAvailable(email)) {

				sendJson(response, false, "이미 가입된 이메일입니다.");

				return;

			}

			HttpSession session = request.getSession();

			/*
			 * 너무 연속으로 보내는 것을 방지
			 */
			Long lastSentAt = (Long) session.getAttribute("emailVerificationSentAt");

			long now = System.currentTimeMillis();

			if (lastSentAt != null && now - lastSentAt < 60000) {

				sendJson(response, false, "인증번호는 1분 후 다시 요청할 수 있습니다.");

				return;

			}

			/*
			 * 6자리 인증번호 생성
			 */
			String code = String.format("%06d", random.nextInt(1000000));

			/*
			 * 실제 이메일 발송
			 */
			emailService.sendVerificationCode(email, code);

			/*
			 * 이메일 전송 성공 후 세션에 인증정보 저장
			 */
			session.setAttribute("emailVerificationEmail", email);

			session.setAttribute("emailVerificationCode", code);

			/*
			 * 5분
			 */
			session.setAttribute("emailVerificationExpiresAt", now + (5 * 60 * 1000));

			session.setAttribute("emailVerificationSentAt", now);

			/*
			 * 새 인증번호를 발급했으므로 기존 인증 완료 상태 초기화
			 */
			session.setAttribute("emailVerified", false);

			session.removeAttribute("verifiedEmail");

			session.setAttribute("emailVerificationFailCount", 0);

			sendJson(response, true, "인증번호를 발송했습니다. 이메일을 확인해주세요.");

		} catch (Exception e) {

			e.printStackTrace();

			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

			sendJson(response, false, "인증번호 발송 중 오류가 발생했습니다.");

		}

	}

	private void sendJson(HttpServletResponse response, boolean success, String message) throws IOException {

		/*
		 * 현재 사용하는 메시지는 서버에서 고정된 문자열이라 간단하게 JSON으로 응답
		 */
		response.getWriter().print(

				"{" + "\"success\":" + success + "," + "\"message\":\"" + message + "\"" + "}"

		);

	}

}
