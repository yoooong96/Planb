package controller.settings;

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

@WebServlet("/settings/passwordChange")
public class PasswordChange extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private UserService service = new UserServiceImpl();

	public PasswordChange() {

		super();

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
			 * ================================================= Google / Social 로그인 회원 차단
			 * ==================================================
			 */

			if (user.getProvider() != null && !"LOCAL".equalsIgnoreCase(user.getProvider())) {

				throw new Exception("소셜 로그인 계정은 비밀번호를 변경할 수 없습니다.");

			}

			/*
			 * ================================================= 입력값
			 * ==================================================
			 */

			String currentPassword = request.getParameter("currentPassword");

			String newPassword = request.getParameter("newPassword");

			String confirmPassword = request.getParameter("confirmPassword");

			/*
			 * ================================================= 빈 값 확인
			 * ==================================================
			 */

			if (currentPassword == null || currentPassword.isEmpty()) {

				throw new Exception("현재 비밀번호를 입력해주세요.");

			}

			if (newPassword == null || newPassword.isEmpty()) {

				throw new Exception("새 비밀번호를 입력해주세요.");

			}

			if (confirmPassword == null || confirmPassword.isEmpty()) {

				throw new Exception("새 비밀번호 확인을 입력해주세요.");

			}

			/*
			 * ================================================= 새 비밀번호 / 확인
			 * ==================================================
			 */

			if (!newPassword.equals(confirmPassword)) {

				throw new Exception("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");

			}

			/*
			 * ================================================= 비밀번호 규칙
			 * 
			 * 영문 숫자 특수문자 8자 이상 ==================================================
			 */

			String passwordPattern = "^(?=.*[A-Za-z])" + "(?=.*\\d)" + "(?=.*[^A-Za-z0-9\\s])" + ".{8,}$";

			if (!newPassword.matches(passwordPattern)) {

				throw new Exception("비밀번호는 영문, 숫자, 특수문자를 포함하여 8자 이상 입력해주세요.");

			}

			/*
			 * ================================================= 현재 비밀번호와 새 비밀번호 동일 여부
			 * ==================================================
			 */

			if (currentPassword.equals(newPassword)) {

				throw new Exception("새 비밀번호는 현재 비밀번호와 다르게 설정해주세요.");

			}

			/*
			 * ================================================= Service
			 * 
			 * 여기서 DB 현재 비밀번호 검사 ==================================================
			 */

			service.changePassword(user.getUserId(), currentPassword, newPassword);

			/*
			 * ================================================= 성공
			 * ==================================================
			 */

			response.sendRedirect(request.getContextPath() + "/view/settings/passwordChange.jsp" + "?success=true");

		} catch (Exception e) {

			e.printStackTrace();

			/*
			 * ================================================= 실패 메시지
			 * 
			 * JSP에서 이 값이 있으면 자동으로 실패 모달이 열림
			 * ==================================================
			 */

			request.setAttribute("errorMessage", e.getMessage());

			request.getRequestDispatcher("/view/settings/passwordChange.jsp").forward(request, response);

		}

	}

}