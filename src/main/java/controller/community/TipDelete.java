package controller.community;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.community.TipDto;
import dto.community.TipMediaDto;
import dto.member.UserDto;
import service.community.TipMediaService;
import service.community.TipMediaServiceImpl;
import service.community.TipService;
import service.community.TipServiceImpl;
import util.image.SharedImageStorage;

@WebServlet("/tipDelete")
public class TipDelete extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		// ========================================
		// 1. 로그인 확인
		// ========================================
		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {

			response.setStatus(
				HttpServletResponse.SC_UNAUTHORIZED
			);

			response.getWriter().write(
				"{\"success\":false,\"loginRequired\":true}"
			);

			return;
		}

		UserDto user =
			(UserDto) session.getAttribute("user");

		// ========================================
		// 2. tipId 확인
		// ========================================
		String tipIdParam =
			request.getParameter("tipId");

		if (
			tipIdParam == null
			|| tipIdParam.trim().isEmpty()
		) {

			response.setStatus(
				HttpServletResponse.SC_BAD_REQUEST
			);

			response.getWriter().write(
				"{\"success\":false}"
			);

			return;
		}

		try {

			long tipId =
				Long.parseLong(tipIdParam);

			TipService tipService =
				new TipServiceImpl();

			TipMediaService tipMediaService =
				new TipMediaServiceImpl();

			// ========================================
			// 3. 게시글 조회
			// ========================================
			TipDto tip =
				tipService.selectTipDetail(tipId);

			if (tip == null) {

				response.setStatus(
					HttpServletResponse.SC_NOT_FOUND
				);

				response.getWriter().write(
					"{\"success\":false}"
				);

				return;
			}

			// ========================================
			// 4. 작성자 확인
			// ========================================
			if (tip.getUserId() != user.getUserId()) {

				response.setStatus(
					HttpServletResponse.SC_FORBIDDEN
				);

				response.getWriter().write(
					"{\"success\":false}"
				);

				return;
			}

			// ========================================
			// 5. 삭제 전에 이미지 목록 조회
			// ========================================
			List<TipMediaDto> mediaList =
				tipMediaService.selectTipMediaList(
					tipId
				);

			// ========================================
			// 6. 게시글 삭제
			// ========================================
			int result =
				tipService.deleteTip(
					tipId,
					user.getUserId()
				);

			if (result <= 0) {

				response.setStatus(
					HttpServletResponse.SC_FORBIDDEN
				);

				response.getWriter().write(
					"{\"success\":false}"
				);

				return;
			}

			// ========================================
			// 7. TB_TIP_MEDIA 삭제
			// ========================================
			tipMediaService.deleteTipMediaByTipId(
				tipId
			);

			// ========================================
			// 8. 공유폴더 실제 이미지 삭제
			// ========================================
			for (TipMediaDto media : mediaList) {

				if (!"IMAGE".equals(media.getMediaType())) {
					continue;
				}

				String mediaUrl =
					media.getMediaUrl();

				if (
					mediaUrl == null
					|| mediaUrl.trim().isEmpty()
				) {
					continue;
				}

				SharedImageStorage.deleteByWebUrl(
					mediaUrl
				);
			}

			// ========================================
			// 9. 삭제 성공 응답
			// ========================================
			response.getWriter().write(
				"{\"success\":true}"
			);

		} catch (NumberFormatException e) {

			response.setStatus(
				HttpServletResponse.SC_BAD_REQUEST
			);

			response.getWriter().write(
				"{\"success\":false}"
			);

		} catch (Exception e) {

			e.printStackTrace();

			response.setStatus(
				HttpServletResponse.SC_INTERNAL_SERVER_ERROR
			);

			response.getWriter().write(
				"{\"success\":false}"
			);
		}
	}
}