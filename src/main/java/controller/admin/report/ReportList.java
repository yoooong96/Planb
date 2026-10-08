package controller.admin.report;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDto;
import dto.report.ReportDto;
import service.report.ReportService;
import service.report.ReportServiceImpl;

@WebServlet("/admin/reports")
public class ReportList extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final ReportService reportService = new ReportServiceImpl();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		/*
		 * ========================================= 로그인 확인
		 * ==========================================
		 */

		if (session == null) {

			response.sendRedirect(request.getContextPath() + "/view/auth/login.jsp");

			return;
		}

		UserDto user = (UserDto) session.getAttribute("user");

		if (user == null) {

			response.sendRedirect(request.getContextPath() + "/view/auth/login.jsp");

			return;
		}

		/*
		 * ========================================= 관리자 권한 확인
		 * ==========================================
		 */

		if (!"ADMIN".equals(user.getRole())) {

			response.sendError(HttpServletResponse.SC_FORBIDDEN);

			return;
		}

		try {

			/*
			 * ===================================== 전체 신고 조회
			 * ======================================
			 */

			List<ReportDto> allReports = reportService.getAllReports();

			if (allReports == null) {

				allReports = new ArrayList<ReportDto>();
			}

			/*
			 * ===================================== 각 상태 개수
			 * ======================================
			 */

			int pendingCount = 0;
			int deletedCount = 0;
			int rejectedCount = 0;

			for (ReportDto report : allReports) {

				if ("PENDING".equals(report.getStatus())) {

					pendingCount++;

				} else if ("RESOLVED".equals(report.getStatus()) && "CONTENT_DELETE".equals(report.getActionType())) {

					deletedCount++;

				} else if ("REJECTED".equals(report.getStatus())) {

					rejectedCount++;
				}
			}

			/*
			 * ===================================== 현재 탭
			 * ======================================
			 */

			String tab = request.getParameter("tab");

			if (tab == null || tab.trim().isEmpty()) {

				tab = "PENDING";
			}

			/*
			 * 허용되지 않은 값으로 접근하면 PENDING으로 처리
			 */
			if (!"PENDING".equals(tab) && !"DELETED".equals(tab) && !"REJECTED".equals(tab) && !"ALL".equals(tab)) {

				tab = "PENDING";
			}

			/*
			 * ===================================== 화면에 보여줄 목록 필터링
			 * ======================================
			 */

			List<ReportDto> reports = new ArrayList<ReportDto>();

			for (ReportDto report : allReports) {

				if ("ALL".equals(tab)) {

					reports.add(report);

				} else if ("PENDING".equals(tab) && "PENDING".equals(report.getStatus())) {

					reports.add(report);

				} else if ("DELETED".equals(tab) && "RESOLVED".equals(report.getStatus())
						&& "CONTENT_DELETE".equals(report.getActionType())) {

					reports.add(report);

				} else if ("REJECTED".equals(tab) && "REJECTED".equals(report.getStatus())) {

					reports.add(report);
				}
			}

			/*
			 * ===================================== JSP 전달
			 * ======================================
			 */

			request.setAttribute("reports", reports);

			request.setAttribute("currentTab", tab);

			request.setAttribute("pendingCount", pendingCount);

			request.setAttribute("deletedCount", deletedCount);

			request.setAttribute("rejectedCount", rejectedCount);

			request.setAttribute("totalCount", allReports.size());

			request.getRequestDispatcher("/view/admin/reports/adminReports.jsp").forward(request, response);

		} catch (Exception e) {

			e.printStackTrace();

			throw new ServletException("신고 목록을 불러오는 중 오류가 발생했습니다.", e);
		}
	}
}