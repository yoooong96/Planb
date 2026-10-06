package controller.settings;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dto.member.UserDto;
import service.member.UserService;
import service.member.UserServiceImpl;

/**
 * 회원 프로필 수정
 */
@WebServlet("/profile/edit")

@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024, fileSizeThreshold = 1024 * 1024)

public class ProfileEdit extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private UserService service = new UserServiceImpl();

	public ProfileEdit() {
		super();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/view/settings/settings.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		/*
		 * ========================================================= 로그인 세션 확인
		 * =========================================================
		 */

		HttpSession session = request.getSession(false);

		if (session == null) {

			response.sendRedirect(request.getContextPath() + "/view/auth/login.jsp");

			return;
		}

		UserDto loginUser = (UserDto) session.getAttribute("user");

		if (loginUser == null) {

			response.sendRedirect(request.getContextPath() + "/view/auth/login.jsp");

			return;
		}

		/*
		 * ========================================================= 입력값
		 * =========================================================
		 */

		String name = request.getParameter("name");

		String nickname = request.getParameter("nickname");

		String birthDate = request.getParameter("birthDate");

		String phone = request.getParameter("phone");

		String region = request.getParameter("region");

		String postcode = request.getParameter("postcode");

		String address = request.getParameter("address");

		String addressDetail = request.getParameter("addressDetail");

		String bio = request.getParameter("bio");

		/*
		 * DB 저장 실패 시 새로 저장된 파일을 지우기 위한 변수
		 */
		Path newlySavedFile = null;

		try {

			/*
			 * ===================================================== 기본 Validation
			 * =====================================================
			 */

			if (name == null || name.trim().isEmpty()) {

				throw new Exception("이름을 입력해주세요.");
			}

			if (nickname == null || nickname.trim().length() < 2) {

				throw new Exception("닉네임을 올바르게 입력해주세요.");
			}

			if (phone == null || !phone.matches("^01[016789]-\\d{3,4}-\\d{4}$")) {

				throw new Exception("전화번호를 올바르게 입력해주세요.");
			}

			if (postcode == null || postcode.trim().isEmpty() || address == null || address.trim().isEmpty()) {

				throw new Exception("주소를 입력해주세요.");
			}

			/*
			 * ===================================================== 닉네임 변경 시 중복 확인
			 * =====================================================
			 */

			String trimmedNickname = nickname.trim();

			if (loginUser.getNickName() == null || !trimmedNickname.equals(loginUser.getNickName())) {

				if (!service.isNicknameAvailable(trimmedNickname)) {

					throw new Exception("이미 사용 중인 닉네임입니다.");
				}
			}

			/*
			 * ===================================================== 수정할 UserDto
			 * =====================================================
			 */

			UserDto updateUser = new UserDto();

			updateUser.setUserId(loginUser.getUserId());

			updateUser.setName(name.trim());

			updateUser.setNickName(trimmedNickname);

			updateUser.setPhone(phone.trim());

			updateUser.setRegion(emptyToNull(region));

			updateUser.setPostcode(emptyToNull(postcode));

			updateUser.setAddress(emptyToNull(address));

			updateUser.setAddressDetail(emptyToNull(addressDetail));

			updateUser.setBio(emptyToNull(bio));

			/*
			 * ===================================================== 생년월일
			 * =====================================================
			 */

			if (birthDate != null && !birthDate.trim().isEmpty()) {

				updateUser.setBirthDate(Date.valueOf(birthDate.trim()));

			} else {

				updateUser.setBirthDate(null);
			}

			/*
			 * ===================================================== 프로필 이미지
			 * 
			 * 기본값: 기존 이미지 파일명 유지 =====================================================
			 */

			String profileFileName = loginUser.getProfileImg();

			Part profileImage = request.getPart("profileImage");

			/*
			 * ===================================================== 새 사진을 선택한 경우에만 저장
			 * =====================================================
			 */

			if (profileImage != null && profileImage.getSize() > 0) {

				/*
				 * ------------------------------------------------- 이미지 MIME 확인
				 * -------------------------------------------------
				 */

				String contentType = profileImage.getContentType();

				if (contentType == null || !contentType.startsWith("image/")) {

					throw new Exception("이미지 파일만 업로드할 수 있습니다.");
				}

				/*
				 * ------------------------------------------------- 확장자
				 * -------------------------------------------------
				 */

				String extension = getImageExtension(contentType);

				/*
				 * ------------------------------------------------- 새 파일명
				 * -------------------------------------------------
				 */

				profileFileName = "profile_" + UUID.randomUUID().toString().replace("-", "") + extension;

				/*
				 * ================================================= 중요
				 * 
				 * 회원가입과 동일한 profilePath 사용
				 * 
				 * signup.java:
				 * 
				 * String uploadPath = (String) request.getServletContext()
				 * .getAttribute("profilePath");
				 * 
				 * String realPath = request.getServletContext() .getRealPath(uploadPath);
				 * =================================================
				 */

				String uploadPath = (String) request.getServletContext().getAttribute("profilePath");

				/*
				 * CommonFilter 등에서 profilePath를 지정하지 못한 경우
				 */
				if (uploadPath == null || uploadPath.trim().isEmpty()) {

					uploadPath = "/profiles";
				}

				String realPath = request.getServletContext().getRealPath(uploadPath);

				if (realPath == null || realPath.trim().isEmpty()) {

					throw new Exception("프로필 이미지 실제 저장 경로를 찾지 못했습니다.");
				}

				/*
				 * ------------------------------------------------- 저장 폴더
				 * -------------------------------------------------
				 */

				Path directory = Paths.get(realPath).toAbsolutePath().normalize();

				Files.createDirectories(directory);

				/*
				 * ------------------------------------------------- 실제 저장 파일
				 * -------------------------------------------------
				 */

				Path savePath = directory.resolve(profileFileName).normalize();

				/*
				 * 혹시 모를 경로 조작 방지
				 */
				if (!savePath.startsWith(directory)) {

					throw new Exception("잘못된 프로필 이미지 저장 경로입니다.");
				}

				/*
				 * ------------------------------------------------- 이미지 파일 저장
				 * -------------------------------------------------
				 */

				try (InputStream input = profileImage.getInputStream()) {

					Files.copy(input, savePath, StandardCopyOption.REPLACE_EXISTING);
				}

				newlySavedFile = savePath;

				/*
				 * ------------------------------------------------- 디버깅
				 * 
				 * 여기 출력값 중요함. -------------------------------------------------
				 */

				System.out.println("======================================");

				System.out.println("[프로필 이미지 수정]");

				System.out.println("profilePath(URL) = " + uploadPath);

				System.out.println("realPath = " + realPath);

				System.out.println("fileName = " + profileFileName);

				System.out.println("savePath = " + savePath.toAbsolutePath());

				System.out.println("file exists = " + Files.exists(savePath));

				System.out.println("file size = " + Files.size(savePath));

				System.out.println("browser URL = " + request.getContextPath() + uploadPath + "/" + profileFileName);

				System.out.println("======================================");
			}

			/*
			 * ===================================================== DTO에 프로필 파일명 설정
			 * 
			 * 새 사진 있음 → profile_xxxxx.jpg
			 * 
			 * 새 사진 없음 → 기존 파일명 =====================================================
			 */

			updateUser.setProfileImg(profileFileName);

			/*
			 * ===================================================== DB UPDATE
			 * =====================================================
			 */

			service.updateUser(updateUser);

			/*
			 * ===================================================== DB에서 최신 사용자 다시 조회
			 * =====================================================
			 */

			UserDto refreshedUser = service.selectUser(loginUser.getLoginId());

			if (refreshedUser == null) {

				throw new Exception("수정된 회원정보를 불러오지 못했습니다.");
			}

			/*
			 * ===================================================== 확인용 로그
			 * =====================================================
			 */

			System.out.println("수정 후 DB profileImg = " + refreshedUser.getProfileImg());

			/*
			 * ===================================================== 세션의 사용자 정보 갱신
			 * 
			 * DB만 수정하고 세션을 갱신하지 않으면 header / myProfile 등이 이전 정보를 계속 사용할 수 있음.
			 * =====================================================
			 */

			session.setAttribute("user", refreshedUser);

			/*
			 * ===================================================== 수정 완료 → 내 프로필
			 * =====================================================
			 */

			response.sendRedirect(request.getContextPath() + "/view/profile/myProfile.jsp" + "?updated=success");

		} catch (Exception e) {

			e.printStackTrace();

			/*
			 * 파일 저장까지 성공했는데 DB UPDATE가 실패했다면 새 파일만 남지 않도록 삭제
			 */
			if (newlySavedFile != null && Files.exists(newlySavedFile)) {

				try {

					Files.deleteIfExists(newlySavedFile);

				} catch (Exception deleteException) {

					deleteException.printStackTrace();
				}
			}

			request.setAttribute("errorMessage", e.getMessage());

			request.getRequestDispatcher("/view/profile/myProfile.jsp").forward(request, response);
		}
	}

	/*
	 * ============================================================ 빈 문자열 → null
	 * ============================================================
	 */

	private String emptyToNull(String value) {

		if (value == null) {
			return null;
		}

		value = value.trim();

		if (value.isEmpty()) {
			return null;
		}

		return value;
	}

	/*
	 * ============================================================ 이미지 MIME 타입 →
	 * 확장자 ============================================================
	 */

	private String getImageExtension(String contentType) throws Exception {

		if ("image/jpeg".equalsIgnoreCase(contentType)) {

			return ".jpg";
		}

		if ("image/png".equalsIgnoreCase(contentType)) {

			return ".png";
		}

		if ("image/webp".equalsIgnoreCase(contentType)) {

			return ".webp";
		}

		if ("image/gif".equalsIgnoreCase(contentType)) {

			return ".gif";
		}

		throw new Exception("지원하지 않는 이미지 형식입니다.");
	}

}