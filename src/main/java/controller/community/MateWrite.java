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

import dto.community.MateDto;
import dto.community.MateMediaDto;
import dto.member.UserDto;
import service.community.MateMediaService;
import service.community.MateMediaServiceImpl;
import service.community.MateService;
import service.community.MateServiceImpl;
import util.image.SharedImageStorage;

@WebServlet("/mateWrite")
@MultipartConfig(
	maxFileSize = 1024 * 1024 * 10,
	maxRequestSize = 1024 * 1024 * 50
)
public class MateWrite extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private MateService mateService = new MateServiceImpl();
	private MateMediaService mateMediaService = new MateMediaServiceImpl();

	public MateWrite() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/view/mates/mateWrite.jsp").forward(request, response);
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
		String country = request.getParameter("country");
		String content = request.getParameter("content");

		int recruitCount = 1;

		try {
			recruitCount = Integer.parseInt(request.getParameter("recruitCount"));
		} catch (NumberFormatException e) {
			recruitCount = 1;
		}

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
					SharedImageStorage.Category.MATE
				);

			imageUrls.add(imageUrl);
		}

		// ========================================
		// 5. 첫 번째 사진을 대표 이미지로 지정
		// ========================================
		String img = null;

		if (!imageUrls.isEmpty()) {
			img = imageUrls.get(0);
		}

		// ========================================
		// 6. 게시글 DTO 생성
		// ========================================
		MateDto mateDto = new MateDto();

		mateDto.setUserId(user.getUserId());
		mateDto.setTitle(title);
		mateDto.setContent(content);
		mateDto.setImg(img);
		mateDto.setCountry(country);
		mateDto.setRecruitCount(recruitCount);
		mateDto.setVisibility("PUBLIC");
		mateDto.setStatus("ACTIVE");
		mateDto.setRecruitStatus("OPEN");

		// ========================================
		// 7. TB_MATE에 게시글 등록
		// ========================================
		int result = mateService.insertMate(mateDto);

		System.out.println("Mate 등록 결과 result = " + result);

		// ========================================
		// 8. 게시글 등록 성공
		// ========================================
		if (result > 0) {

			int sortOrder = 1;

			// 선택한 이미지 모두 TB_MATE_MEDIA에 저장
			for (String imageUrl : imageUrls) {

				MateMediaDto mediaDto = new MateMediaDto();

				// 방금 생성된 게시글 번호
				mediaDto.setMateId(mateDto.getMateId());
				mediaDto.setMediaType("IMAGE");
				mediaDto.setMediaUrl(imageUrl);
				mediaDto.setSortOrder(sortOrder);

				mateMediaService.insertMateMedia(mediaDto);

				sortOrder++;
			}

			// 등록 완료 → 여행 메이트 목록
			response.sendRedirect(request.getContextPath() + "/mates");

		} else {

			request.setAttribute("errorMessage", "여행 메이트 등록에 실패했습니다.");
			request.getRequestDispatcher("/view/mates/mateWrite.jsp").forward(request, response);
		}
	}
}