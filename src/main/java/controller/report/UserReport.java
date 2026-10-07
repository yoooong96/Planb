package controller.report;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDto;

import service.report.ReportService;
import service.report.ReportServiceImpl;

import util.JsonResponse;

@WebServlet("/report/user")
public class UserReport extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final ReportService reportService = new ReportServiceImpl();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		/*
		 * ===================================== 로그인 확인
		 * ======================================
		 */

		HttpSession session = request.getSession(false);

		UserDto loginUser = session == null ? null : (UserDto) session.getAttribute("user");

		if (loginUser == null || loginUser.getUserId() <= 0) {

			JsonResponse.writeFailure(response, HttpServletResponse.SC_UNAUTHORIZED, "로그인이 필요합니다.");

			return;
		}

		try {

			/*
			 * ===================================== 신고 대상 번호
			 * ======================================
			 */

			String targetIdParam = request.getParameter("targetId");

			if (targetIdParam == null || targetIdParam.trim().isEmpty()) {

				throw new IllegalArgumentException("신고 대상이 없습니다.");
			}

			long targetUserId;

			try {

				targetUserId = Long.parseLong(targetIdParam.trim());

			} catch (NumberFormatException e) {

				throw new IllegalArgumentException("올바른 신고 대상이 아닙니다.");
			}

			if (targetUserId <= 0) {

				throw new IllegalArgumentException("올바른 신고 대상이 아닙니다.");
			}

			/*
			 * ===================================== 신고 사유
			 * ======================================
			 */

			String reasonCode = request.getParameter("profileReportReason");

			if (reasonCode == null || reasonCode.trim().isEmpty()) {

				throw new IllegalArgumentException("신고 사유를 선택해 주세요.");
			}

			reasonCode = reasonCode.trim();

			/*
			 * ===================================== 상세 내용
			 * ======================================
			 */

			String detail = request.getParameter("detail");

			/*
			 * ===================================== 신고 Service 호출
			 * 
			 * 여기서는 targetType을 브라우저에서 받지 않는다.
			 * 
			 * Service가 USER라고 직접 결정함. ======================================
			 */

			reportService.reportUser(loginUser.getUserId(), targetUserId, reasonCode, detail);

			/*
			 * ===================================== 성공 응답
			 * ======================================
			 */

			Map<String, Object> result = new HashMap<>();

			result.put("success", true);

			result.put("message", "신고가 접수되었습니다.");

			JsonResponse.writeJson(response, result);

			/*
			 * ========================================= 중복 신고
			 * =========================================
			 */

		} catch (IllegalStateException e) {

			JsonResponse.writeFailure(response, HttpServletResponse.SC_CONFLICT, e.getMessage());

			/*
			 * ========================================= 잘못된 요청
			 * =========================================
			 */

		} catch (IllegalArgumentException e) {

			JsonResponse.writeFailure(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());

			/*
			 * ========================================= 권한 문제
			 * =========================================
			 */

		} catch (SecurityException e) {

			JsonResponse.writeFailure(response, HttpServletResponse.SC_FORBIDDEN, e.getMessage());

			/*
			 * ========================================= 서버 오류
			 * =========================================
			 */

		} catch (Exception e) {

			getServletContext().log("사용자 프로필 신고 중 오류 발생", e);

			JsonResponse.writeFailure(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "신고 처리 중 오류가 발생했습니다.");
		}
	}
}