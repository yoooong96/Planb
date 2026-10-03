package controller.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.community.TipDto;
import dto.member.UserDto;
import service.community.TipService;
import service.community.TipServiceImpl;
import javax.servlet.annotation.MultipartConfig;

import java.io.File;
import java.util.UUID;

import javax.servlet.http.Part;

/**
 * Servlet implementation class TipWrite
 */
@WebServlet("/tipWrite")
@MultipartConfig(
	fileSizeThreshold = 1024 * 1024,
	maxFileSize = 10 * 1024 * 1024,
	maxRequestSize = 50 * 1024 * 1024
)
public class TipWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TipWrite() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/view/tips/tipWrite.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// 작성한 값 받기
		String title = request.getParameter("title");
		String hashtag = request.getParameter("hashtag");
		String content = request.getParameter("content");

		// System.out.println("title = " + title);
		// System.out.println("hashtag = " + hashtag);
		// System.out.println("content = " + content);
		
		// 대표 이미지
		String thumbnailImg = null;
		// 업로드 폴더 실제 경로
		String uploadPath = request.getServletContext().getRealPath("/view/assets/images/tips/upload");

		File uploadDir = new File(uploadPath);

		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}
		// 첨부된 파일 중 첫 번째 이미지 저장
		for (Part part : request.getParts()) {
			if (!"images".equals(part.getName()) || part.getSize() == 0) {
				continue;
			}
			String originalName = part.getSubmittedFileName();
			if (originalName == null || originalName.isEmpty()) {
				continue;
			}
			// 확장자 추출
			String extension = "";

			int dotIndex = originalName.lastIndexOf(".");
			if (dotIndex != -1) {
				extension = originalName.substring(dotIndex);
			}
			// 파일명 중복 방지
			String savedName = UUID.randomUUID().toString() + extension;
			// 실제 파일 저장
			part.write(uploadPath + File.separator + savedName);
			// DB에 저장할 웹 경로
			thumbnailImg = "/view/assets/images/tips/upload/" + savedName;
			// 첫 번째 사진만 대표 이미지로 사용
			break;
		}

		// 로그인 사용자 가져오기
		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}

		UserDto user = (UserDto) session.getAttribute("user");

		// DTO 생성
		TipDto tipDto = new TipDto();
		tipDto.setUserId(user.getUserId());
		tipDto.setTitle(title);
		tipDto.setHashtag(hashtag);
		tipDto.setContent(content);
		tipDto.setThumbnailImg(thumbnailImg);

		// DB 등록
		TipService tipService = new TipServiceImpl();
		int result = tipService.insertTip(tipDto);

		if (result > 0) {
			response.sendRedirect(request.getContextPath() + "/tips");
		} else {
			request.setAttribute("errorMessage", "여행꿀팁 등록에 실패했습니다.");
			request.getRequestDispatcher("/view/tips/tipWrite.jsp").forward(request, response);
		}
	}

}
