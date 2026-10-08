package controller.admin.report;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDto;
import service.report.ReportService;
import service.report.ReportServiceImpl;

@WebServlet("/admin/reports/process")
public class ReportProcess extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final ReportService reportService = new ReportServiceImpl();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession(false);

		/*
		 * ========================================= 로그인 검사
		 * ==========================================
		 */

		if (session == null) {

			response.sendRedirect(request.getContextPath() + "/view/auth/login.jsp");

			return;
		}

		UserDto admin = (UserDto) session.getAttribute("user");

		if (admin == null) {

			response.sendRedirect(request.getContextPath() + "/view/auth/login.jsp");

			return;
		}

		/*
		 * ========================================= 관리자 권한 검사
		 * ==========================================
		 */

		if (!"ADMIN".equals(admin.getRole())) {

			response.sendError(HttpServletResponse.SC_FORBIDDEN);

			return;
		}

		/*
		 * ========================================= 파라미터
		 * ==========================================
		 */

		String reportIdValue = request.getParameter("reportId");

		String action = request.getParameter("action");

		if (reportIdValue == null || reportIdValue.trim().isEmpty() || action == null || action.trim().isEmpty()) {

			response.sendRedirect(request.getContextPath() + "/admin/reports" + "?result=fail");

			return;
		}

		try {

			long reportId = Long.parseLong(reportIdValue);

			long adminUserId = admin.getUserId();

			/*
			 * ===================================== 문제 없음
			 * ======================================
			 */

			if ("REJECT".equals(action)) {

				reportService.rejectReport(reportId, adminUserId);

				/*
				 * ===================================== 콘텐츠 삭제
				 * ======================================
				 */

			} else if ("DELETE".equals(action)) {

				reportService.deleteReportedContent(reportId, adminUserId);

				/*
				 * ===================================== 회원 계정 정지
				 * ======================================
				 */

			} else if ("SUSPEND".equals(action)) {

				reportService.suspendReportedUser(reportId, adminUserId);

			} else {

				throw new IllegalArgumentException("지원하지 않는 신고 처리 방식입니다.");
			}

			response.sendRedirect(request.getContextPath() + "/admin/reports" + "?result=success");

		} catch (Exception e) {

			e.printStackTrace();

			response.sendRedirect(request.getContextPath() + "/admin/reports" + "?result=fail");
		}
	}
}