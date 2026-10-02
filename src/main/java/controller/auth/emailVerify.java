package controller.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class emailVerify
 */
@WebServlet("/auth/emailVerify")
public class emailVerify extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public emailVerify() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		response.setContentType("application/json; charset=UTF-8");

		String email = request.getParameter("email");

		String inputCode = request.getParameter("code");

		if (email == null || email.trim().isEmpty() || inputCode == null || inputCode.trim().isEmpty()) {

			sendJson(response, false, "이메일과 인증번호를 확인해주세요.");

			return;

		}

		email = email.trim().toLowerCase();

		inputCode = inputCode.trim();

		HttpSession session = request.getSession(false);

		if (session == null) {

			sendJson(response, false, "인증정보가 없습니다. 인증번호를 다시 발급해주세요.");

			return;

		}

		String savedEmail = (String) session.getAttribute("emailVerificationEmail");

		String savedCode = (String) session.getAttribute("emailVerificationCode");

		Long expiresAt = (Long) session.getAttribute("emailVerificationExpiresAt");

		Integer failCount = (Integer) session.getAttribute("emailVerificationFailCount");

		if (failCount == null) {

			failCount = 0;

		}

		/*
		 * 인증번호 5회 이상 실패
		 */
		if (failCount >= 5) {

			clearVerification(session);

			sendJson(response, false, "인증번호 입력 횟수를 초과했습니다. 인증번호를 다시 발급해주세요.");

			return;

		}

		/*
		 * 인증 데이터가 없는 경우
		 */
		if (savedEmail == null || savedCode == null || expiresAt == null) {

			sendJson(response, false, "인증번호를 먼저 발급해주세요.");

			return;

		}

		/*
		 * 이메일이 변경된 경우
		 */
		if (!savedEmail.equalsIgnoreCase(email)) {

			sendJson(response, false, "인증번호를 발급받은 이메일과 일치하지 않습니다.");

			return;

		}

		/*
		 * 만료 확인
		 */
		if (System.currentTimeMillis() > expiresAt) {

			clearVerification(session);

			sendJson(response, false, "인증번호가 만료되었습니다. 다시 발급해주세요.");

			return;

		}

		/*
		 * 인증번호 불일치
		 */
		if (!savedCode.equals(inputCode)) {

			failCount++;

			session.setAttribute("emailVerificationFailCount", failCount);

			sendJson(response, false, "인증번호가 일치하지 않습니다.");

			return;

		}

		/*
		 * ===================================== 인증 성공
		 * =====================================
		 */

		session.setAttribute("emailVerified", true);

		session.setAttribute("verifiedEmail", email);

		/*
		 * 인증 완료했으니 인증번호는 더 이상 필요 없음
		 */
		session.removeAttribute("emailVerificationCode");

		session.removeAttribute("emailVerificationExpiresAt");

		session.removeAttribute("emailVerificationFailCount");

		sendJson(response, true, "이메일 인증이 완료되었습니다.");

	}

	private void clearVerification(HttpSession session) {

		session.removeAttribute("emailVerificationCode");

		session.removeAttribute("emailVerificationExpiresAt");

		session.removeAttribute("emailVerificationFailCount");

		session.setAttribute("emailVerified", false);

		session.removeAttribute("verifiedEmail");

	}

	private void sendJson(HttpServletResponse response, boolean success, String message) throws IOException {

		response.getWriter().print(

				"{" + "\"success\":" + success + "," + "\"message\":\"" + message + "\"" + "}"

		);

	}

}
