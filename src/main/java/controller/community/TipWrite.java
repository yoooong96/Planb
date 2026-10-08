package controller.community;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dto.community.TipDto;
import dto.community.TipMediaDto;
import dto.member.UserDto;
import service.community.TipMediaService;
import service.community.TipMediaServiceImpl;
import service.community.TipService;
import service.community.TipServiceImpl;
import util.image.SharedImageStorage;

@WebServlet("/tipWrite")
@MultipartConfig(
	fileSizeThreshold = 1024 * 1024,
	maxFileSize = 10 * 1024 * 1024,
	maxRequestSize = 50 * 1024 * 1024
)
public class TipWrite extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public TipWrite() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/view/tips/tipWrite.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		// ========================================
		// 1. 로그인 사용자 확인
		// ========================================
		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}

		UserDto user = (UserDto) session.getAttribute("user");

		// ========================================
		// 2. 작성한 값 받기
		// ========================================
		String title = request.getParameter("title");
		String hashtag = request.getParameter("hashtag");
		String content = request.getParameter("content");

		// ========================================
		// 3. 저장된 이미지 URL 리스트
		// ========================================
		List<String> imageUrls = new ArrayList<>();

		// ========================================
		// 4. 첨부 이미지 최대 5장 저장
		// ========================================
		for (Part part : request.getParts()) {

			if (!"images".equals(part.getName())) {
				continue;
			}

			System.out.println("파일명 = " + part.getSubmittedFileName());
			System.out.println("파일크기 = " + part.getSize());

			if (part.getSize() == 0) {
				continue;
			}

			if (imageUrls.size() >= 5) {
				break;
			}

			String originalName = part.getSubmittedFileName();

			if (originalName == null || originalName.trim().isEmpty()) {
				continue;
			}

			String contentType = part.getContentType();

			if (contentType == null || !contentType.startsWith("image/")) {
				continue;
			}

			String imageUrl =
				SharedImageStorage.saveImage(
					part,
					SharedImageStorage.Category.TIP
				);

			imageUrls.add(imageUrl);
		}

		// ========================================
		// 5. 첫 번째 사진을 대표 이미지로 지정
		// ========================================
		String thumbnailImg = null;

		if (!imageUrls.isEmpty()) {
			thumbnailImg = imageUrls.get(0);
		}

		// ========================================
		// 6. 게시글 DTO 생성
		// ========================================
		TipDto tipDto = new TipDto();

		tipDto.setUserId(user.getUserId());
		tipDto.setTitle(title);
		tipDto.setHashtag(hashtag);
		tipDto.setContent(content);
		tipDto.setThumbnailImg(thumbnailImg);

		// ========================================
		// 7. TB_TIP에 게시글 등록
		// ========================================
		TipService tipService = new TipServiceImpl();

		int result = tipService.insertTip(tipDto);

		// ========================================
		// 8. 게시글 등록 성공
		// ========================================
		if (result > 0) {

			TipMediaService tipMediaService =
				new TipMediaServiceImpl();

			int sortOrder = 1;

			// 선택한 이미지 모두 TB_TIP_MEDIA에 저장
			for (String imageUrl : imageUrls) {

				TipMediaDto mediaDto =
					new TipMediaDto();

				mediaDto.setTipId(tipDto.getTipId());
				mediaDto.setMediaType("IMAGE");
				mediaDto.setMediaUrl(imageUrl);
				mediaDto.setSortOrder(sortOrder);

				tipMediaService.insertTipMedia(mediaDto);

				sortOrder++;
			}

			// 등록 완료 → 여행꿀팁 목록
			response.sendRedirect(
				request.getContextPath() + "/tips"
			);

		} else {

			request.setAttribute(
				"errorMessage",
				"여행꿀팁 등록에 실패했습니다."
			);

			request.getRequestDispatcher(
				"/view/tips/tipWrite.jsp"
			).forward(request, response);
		}
	}
}