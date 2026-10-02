package controller.auth;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.time.Duration;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDto;
import service.member.UserService;
import service.member.UserServiceImpl;

/**
 * Google 신규 회원 추가정보 입력 완료 처리
 */
@WebServlet("/auth/google/complete")
public class GoogleSignupComplete extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private UserService service = new UserServiceImpl();

	public GoogleSignupComplete() {
		super();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession(false);

		/*
		 * ========================================================= 1. Google 인증 세션 확인
		 * =========================================================
		 */

		if (session == null) {

			response.sendRedirect(request.getContextPath() + "/view/auth/login.jsp");

			return;
		}

		Boolean googleVerified = (Boolean) session.getAttribute("googleSignupVerified");

		String googleSub = (String) session.getAttribute("googleSignupSub");

		String googleEmail = (String) session.getAttribute("googleSignupEmail");

		String googleName = (String) session.getAttribute("googleSignupName");

		String googlePicture = (String) session.getAttribute("googleSignupPicture");

		if (!Boolean.TRUE.equals(googleVerified) || googleSub == null || googleEmail == null) {

			response.sendRedirect(request.getContextPath() + "/view/auth/login.jsp");

			return;
		}

		/*
		 * ========================================================= 2. 추가정보 입력값
		 * =========================================================
		 */

		String nickname = request.getParameter("nickname");

		String phone = request.getParameter("phone");

		String postcode = request.getParameter("postcode");

		String address = request.getParameter("address");

		String addressDetail = request.getParameter("addressDetail");

		/*
		 * ========================================================= 3. 공백 제거
		 * =========================================================
		 */

		if (nickname != null) {
			nickname = nickname.trim();
		}

		if (phone != null) {
			phone = phone.trim();
		}

		if (postcode != null) {
			postcode = postcode.trim();
		}

		if (address != null) {
			address = address.trim();
		}

		if (addressDetail != null) {
			addressDetail = addressDetail.trim();
		}

		/*
		 * ========================================================= 4. 서버 Validation
		 * =========================================================
		 */

		if (nickname == null || nickname.length() < 2) {

			forwardError(request, response, "닉네임을 올바르게 입력해주세요.");

			return;
		}

		if (phone == null || !phone.matches("^01[016789]-\\d{3,4}-\\d{4}$")) {

			forwardError(request, response, "전화번호를 올바르게 입력해주세요.");

			return;
		}

		if (postcode == null || postcode.isEmpty() || address == null || address.isEmpty()) {

			forwardError(request, response, "주소를 입력해주세요.");

			return;
		}

		try {

			/*
			 * ===================================================== 5. 이미 가입된 Google 회원인지
			 * 재확인 =====================================================
			 */

			UserDto existing = service.findSocialUser("GOOGLE", googleSub);

			if (existing != null) {

				session.setAttribute("user", existing);

				clearGoogleSignupSession(session);

				response.sendRedirect(request.getContextPath() + "/view/home/home.jsp");

				return;
			}

			/*
			 * ===================================================== 6. 닉네임 중복 재확인
			 * =====================================================
			 */

			if (!service.isNicknameAvailable(nickname)) {

				forwardError(request, response, "이미 사용 중인 닉네임입니다.");

				return;
			}

			/*
			 * ===================================================== 7. 이메일 중복 확인
			 * =====================================================
			 */

			if (!service.isEmailAvailable(googleEmail)) {

				forwardError(request, response, "이미 가입된 이메일입니다. 기존 로그인 방식으로 로그인해주세요.");

				return;
			}

			/*
			 * ===================================================== 8. Google 회원용 내부
			 * login_id 생성 =====================================================
			 */

			String loginId = createGoogleLoginId(googleSub);

			/*
			 * ===================================================== 9. Google 프로필 이미지 다운로드
			 * =====================================================
			 */

			String savedProfileImage = null;

			if (googlePicture != null && !googlePicture.trim().isEmpty()) {

				try {

					savedProfileImage = downloadGoogleProfileImage(googlePicture);

					System.out.println("Google 프로필 이미지 저장 완료: " + savedProfileImage);

				} catch (Exception imageException) {

					/*
					 * 이미지 다운로드 실패가 회원가입 자체를 막지는 않도록 함
					 */
					imageException.printStackTrace();

					System.out.println("Google 프로필 이미지 다운로드 실패");

					savedProfileImage = null;
				}
			}

			/*
			 * ===================================================== 10. UserDto 생성
			 * =====================================================
			 */

			UserDto user = new UserDto();

			user.setLoginId(loginId);

			/*
			 * Google 사용자는 사이트 비밀번호를 사용하지 않음
			 */
			user.setPassword(null);

			user.setName(googleName == null || googleName.trim().isEmpty() ? "Google 사용자" : googleName);

			user.setNickName(nickname);

			user.setEmail(googleEmail);

			user.setPhone(phone);

			/*
			 * 중요
			 *
			 * 기존에는 googlePicture URL을 그대로 넣었음.
			 *
			 * 이제는:
			 *
			 * google_xxxxxxxxx.jpg
			 *
			 * 같은 파일명만 DB에 저장.
			 */
			user.setProfileImg(savedProfileImage);

			user.setPostcode(postcode);

			user.setAddress(address);

			user.setAddressDetail(addressDetail);

			user.setProvider("GOOGLE");

			user.setProviderUserId(googleSub);

			/*
			 * ===================================================== 11. Google 회원가입
			 * =====================================================
			 */

			service.signupGoogle(user);

			/*
			 * ===================================================== 12. INSERT 이후 회원 다시 조회
			 * =====================================================
			 */

			UserDto loginUser = service.findSocialUser("GOOGLE", googleSub);

			if (loginUser == null) {

				throw new Exception("Google 회원가입 후 회원정보를 불러오지 못했습니다.");
			}

			/*
			 * ===================================================== 13. 자동 로그인
			 * =====================================================
			 */

			session.setAttribute("user", loginUser);

			/*
			 * ===================================================== 14. Google 가입 임시 세션 제거
			 * =====================================================
			 */

			clearGoogleSignupSession(session);

			/*
			 * ===================================================== 15. 홈으로 이동
			 * =====================================================
			 */

			response.sendRedirect(request.getContextPath() + "/view/home/home.jsp");

		} catch (Exception e) {

			e.printStackTrace();

			forwardError(request, response, "회원가입 처리 중 오류가 발생했습니다.");
		}

	}

	/*
	 * ============================================================ Google 프로필 이미지
	 * 다운로드
	 * 
	 * Google https://lh3.googleusercontent.com/... ↓ 서버에서 다운로드 ↓
	 * /profiles/google_xxxxx.jpg ↓ DB에는 google_xxxxx.jpg 만 저장
	 * ============================================================
	 */

	private String downloadGoogleProfileImage(String imageUrl) throws Exception {

		if (imageUrl == null || imageUrl.trim().isEmpty()) {

			return null;
		}

		URI uri = URI.create(imageUrl.trim());

		String host = uri.getHost();

		/*
		 * 임의의 외부 URL을 서버가 다운로드하는 것을 막기 위해 Google 이미지 도메인만 허용
		 */
		if (host == null || !(host.equals("googleusercontent.com") || host.endsWith(".googleusercontent.com"))) {

			throw new Exception("허용되지 않은 Google 프로필 이미지 주소입니다.");
		}

		/*
		 * ======================================================== HttpClient 생성
		 * ========================================================
		 */

		HttpClient client = HttpClient.newBuilder().followRedirects(HttpClient.Redirect.NORMAL)
				.connectTimeout(Duration.ofSeconds(5)).build();

		/*
		 * ======================================================== Google 이미지 요청
		 * ========================================================
		 */

		HttpRequest imageRequest = HttpRequest.newBuilder().uri(uri).timeout(Duration.ofSeconds(10))
				.header("User-Agent", "Planb").GET().build();

		HttpResponse<byte[]> imageResponse = client.send(imageRequest, HttpResponse.BodyHandlers.ofByteArray());

		/*
		 * ======================================================== HTTP 상태 확인
		 * ========================================================
		 */

		if (imageResponse.statusCode() != 200) {

			throw new Exception("Google 프로필 이미지를 다운로드하지 못했습니다. HTTP " + imageResponse.statusCode());
		}

		/*
		 * ======================================================== Content-Type 확인
		 * ========================================================
		 */

		String contentType = imageResponse.headers().firstValue("Content-Type").orElse("").toLowerCase();

		if (!contentType.startsWith("image/")) {

			throw new Exception("Google 프로필 응답이 이미지가 아닙니다.");
		}

		/*
		 * ======================================================== 이미지 데이터
		 * ========================================================
		 */

		byte[] imageBytes = imageResponse.body();

		if (imageBytes == null || imageBytes.length == 0) {

			throw new Exception("Google 프로필 이미지 데이터가 비어 있습니다.");
		}

		/*
		 * 최대 5MB 제한
		 */
		if (imageBytes.length > 5 * 1024 * 1024) {

			throw new Exception("Google 프로필 이미지 크기가 너무 큽니다.");
		}

		/*
		 * ======================================================== 확장자 결정
		 * ========================================================
		 */

		String extension = ".jpg";

		if (contentType.contains("png")) {

			extension = ".png";

		} else if (contentType.contains("webp")) {

			extension = ".webp";

		} else if (contentType.contains("gif")) {

			extension = ".gif";

		} else if (contentType.contains("jpeg") || contentType.contains("jpg")) {

			extension = ".jpg";
		}

		/*
		 * ======================================================== 파일명 생성
		 * ========================================================
		 */

		String fileName = "google_" + UUID.randomUUID().toString().replace("-", "") + extension;

		/*
		 * ======================================================== /profiles 실제 서버 저장
		 * 경로 ========================================================
		 */

		String profilesRealPath = getServletContext().getRealPath("/profiles");

		if (profilesRealPath == null) {

			throw new Exception("프로필 이미지 저장 경로를 찾을 수 없습니다.");
		}

		Path profileDirectory = Paths.get(profilesRealPath);

		/*
		 * profiles 폴더가 없으면 생성
		 */
		Files.createDirectories(profileDirectory);

		Path savePath = profileDirectory.resolve(fileName);

		/*
		 * ======================================================== 파일 저장
		 * ========================================================
		 */

		Files.write(savePath, imageBytes);

		System.out.println("Google 프로필 이미지 실제 저장 위치: " + savePath.toAbsolutePath());

		/*
		 * DB에는 절대경로가 아니라 파일명만 저장
		 */
		return fileName;
	}

	/*
	 * ============================================================ Google 회원 내부
	 * LOGIN ID 생성 ============================================================
	 */

	private String createGoogleLoginId(String googleSub) throws Exception {

		MessageDigest digest = MessageDigest.getInstance("SHA-256");

		byte[] hash = digest.digest(googleSub.getBytes(StandardCharsets.UTF_8));

		StringBuilder builder = new StringBuilder();

		/*
		 * 10 byte = 20자리 hex 문자열
		 */
		for (int i = 0; i < 10; i++) {

			builder.append(String.format("%02x", hash[i]));
		}

		return "google_" + builder.toString();
	}

	/*
	 * ============================================================ 오류 발생 시 추가정보
	 * 페이지로 이동 ============================================================
	 */

	private void forwardError(HttpServletRequest request, HttpServletResponse response, String message)
			throws ServletException, IOException {

		request.setAttribute("errorMessage", message);

		request.getRequestDispatcher("/view/auth/googleAdditionalInfo.jsp").forward(request, response);
	}

	/*
	 * ============================================================ Google 가입 임시 세션
	 * 제거 ============================================================
	 */

	private void clearGoogleSignupSession(HttpSession session) {

		session.removeAttribute("googleSignupVerified");

		session.removeAttribute("googleSignupSub");

		session.removeAttribute("googleSignupEmail");

		session.removeAttribute("googleSignupName");

		session.removeAttribute("googleSignupPicture");
	}

}