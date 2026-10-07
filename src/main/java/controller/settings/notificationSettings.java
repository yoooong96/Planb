package controller.settings;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDto;

import service.member.NotificationSettingServiceImpl;
import service.member.NotificationSettingService;

@WebServlet("/settings/notificationSettings")

public class notificationSettings extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final NotificationSettingService service = new NotificationSettingServiceImpl();

	/*
	 * ========================================================= GET
	 * 
	 * 현재 알림 설정 조회 =========================================================
	 */

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		UserDto user = session == null ? null : (UserDto) session.getAttribute("user");

		if (user == null) {

			response.sendRedirect(request.getContextPath() + "/view/auth/login.jsp");

			return;
		}

		try {

			Map<String, Object> setting = service.getNotificationSetting(user.getUserId());

			boolean notifyLike = toBoolean(setting.get("notifyLike"));

			boolean notifyComment = toBoolean(setting.get("notifyComment"));

			request.setAttribute("notifyLike", notifyLike);

			request.setAttribute("notifyComment", notifyComment);

			request.getRequestDispatcher("/view/settings/notificationSettings.jsp").forward(request, response);

		} catch (Exception e) {

			getServletContext().log("알림 설정 조회 오류", e);

			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

		}

	}

	/*
	 * ========================================================= POST
	 * 
	 * 토글 하나를 즉시 변경 =========================================================
	 */

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		response.setContentType("application/json; charset=UTF-8");

		HttpSession session = request.getSession(false);

		UserDto user = session == null ? null : (UserDto) session.getAttribute("user");

		if (user == null) {

			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

			writeJson(response, false, "로그인이 필요합니다.");

			return;
		}

		String type = request.getParameter("type");

		String enabledValue = request.getParameter("enabled");

		boolean enabled = "1".equals(enabledValue);

		try {

			/*
			 * ================================================= 좋아요
			 * =================================================
			 */

			if ("LIKE".equals(type)) {

				service.updateLikeNotification(user.getUserId(), enabled);

				/*
				 * ================================================= 댓글
				 * =================================================
				 */

			} else if ("COMMENT".equals(type)) {

				service.updateCommentNotification(user.getUserId(), enabled);

			} else {

				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

				writeJson(response, false, "올바르지 않은 알림 유형입니다.");

				return;
			}

			writeJson(response, true, "저장되었습니다.");

		} catch (Exception e) {

			getServletContext().log("알림 설정 변경 오류", e);

			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

			writeJson(response, false, "알림 설정 저장에 실패했습니다.");

		}

	}

	/*
	 * ========================================================= boolean 변환
	 * =========================================================
	 */

	private boolean toBoolean(Object value) {

		if (value == null) {

			return false;
		}

		if (value instanceof Boolean) {

			return (Boolean) value;
		}

		if (value instanceof Number) {

			return ((Number) value).intValue() == 1;
		}

		return "1".equals(String.valueOf(value));

	}

	/*
	 * ========================================================= JSON 응답
	 * =========================================================
	 */

	private void writeJson(HttpServletResponse response, boolean success, String message) throws IOException {

		PrintWriter out = response.getWriter();

		String safeMessage = message == null ? ""
				: message.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");

		out.print("{" + "\"success\":" + success + "," + "\"message\":\"" + safeMessage + "\"" + "}");

		out.flush();

	}

}