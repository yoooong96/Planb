package controller.support;

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

import dto.advertisement.AdvertisementDto;
import dto.member.UserDto;

import service.advertisement.AdvertisementService;
import service.advertisement.AdvertisementServiceImpl;

@WebServlet("/support/adInquiry")

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 7 * 1024 * 1024)

public class adInquiry extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final AdvertisementService service = new AdvertisementServiceImpl();

	public adInquiry() {

		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/view/support/adInquiry.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		Path savedImagePath = null;

		/*
		 * 오류가 났을 때 기존 입력값을 다시 JSP에 보여주기 위해 밖에서 선언
		 */

		String businessName = null;

		String managerName = null;

		String phone = null;

		String email = null;

		String content = null;

		String linkUrl = null;

		String adPosition = null;

		String startDateValue = null;

		String endDateValue = null;

		try {

			/*
			 * ================================================= 로그인 사용자
			 * =================================================
			 */

			HttpSession session = request.getSession(false);

			UserDto user = session == null ? null : (UserDto) session.getAttribute("user");

			Long applicantUserId = user == null ? null : user.getUserId();

			/*
			 * ================================================= 입력값
			 * 
			 * @MultipartConfig가 있어야 multipart/form-data에서도 getParameter가 정상 동작함
			 * =================================================
			 */

			businessName = request.getParameter("businessName");

			managerName = request.getParameter("managerName");

			phone = request.getParameter("phone");

			email = request.getParameter("email");

			content = request.getParameter("content");

			linkUrl = request.getParameter("linkUrl");

			adPosition = request.getParameter("adPosition");

			startDateValue = request.getParameter("startDate");

			endDateValue = request.getParameter("endDate");

			/*
			 * ================================================= 날짜
			 * =================================================
			 */

			Date startDate = parseDate(startDateValue, "광고 시작일");

			Date endDate = parseDate(endDateValue, "광고 종료일");

			/*
			 * ================================================= 이미지
			 * =================================================
			 */

			Part imagePart = request.getPart("image");

			if (imagePart == null || imagePart.getSize() <= 0) {

				throw new IllegalArgumentException("광고 이미지를 등록해주세요.");
			}

			if (imagePart.getSize() > 5L * 1024L * 1024L) {

				throw new IllegalArgumentException("광고 이미지는 최대 5MB까지 등록할 수 있습니다.");
			}

			String contentType = imagePart.getContentType();

			String extension;

			if ("image/jpeg".equalsIgnoreCase(contentType)) {

				extension = ".jpg";

			} else if ("image/png".equalsIgnoreCase(contentType)) {

				extension = ".png";

			} else if ("image/webp".equalsIgnoreCase(contentType)) {

				extension = ".webp";

			} else {

				throw new IllegalArgumentException("JPG, PNG, WEBP 이미지만 등록할 수 있습니다.");
			}

			/*
			 * ================================================= 파일명
			 * =================================================
			 */

			String storedFileName = UUID.randomUUID().toString().replace("-", "") + extension;

			/*
			 * ================================================= 저장 폴더
			 * =================================================
			 */

			String uploadRealPath = getServletContext().getRealPath("/uploads/ads");

			if (uploadRealPath == null) {

				throw new IllegalStateException("광고 이미지 저장 경로를 찾을 수 없습니다.");
			}

			Path uploadDirectory = Paths.get(uploadRealPath);

			Files.createDirectories(uploadDirectory);

			savedImagePath = uploadDirectory.resolve(storedFileName);

			try (InputStream inputStream = imagePart.getInputStream()) {

				Files.copy(inputStream, savedImagePath, StandardCopyOption.REPLACE_EXISTING);
			}

			String imageUrl = "/uploads/ads/" + storedFileName;

			/*
			 * ================================================= DTO
			 * =================================================
			 */

			AdvertisementDto advertisement = new AdvertisementDto();

			advertisement.setApplicantUserId(applicantUserId);

			advertisement.setBusinessName(businessName);

			advertisement.setManagerName(managerName);

			advertisement.setContactPhone(phone);

			advertisement.setContactEmail(email);

			advertisement.setAdContent(content);

			advertisement.setImageUrl(imageUrl);

			advertisement.setLinkUrl(linkUrl);

			advertisement.setAdPosition(adPosition);

			advertisement.setStartDate(startDate);

			advertisement.setEndDate(endDate);

			/*
			 * ================================================= DB
			 * =================================================
			 */

			long adId = service.submitAdvertisement(advertisement);

			System.out.println("광고 문의 접수 완료 adId = " + adId);

			/*
			 * ================================================= 성공
			 * =================================================
			 */

			response.sendRedirect(request.getContextPath() + "/view/support/adInquiry.jsp" + "?success=1");

		} catch (IllegalArgumentException e) {

			deleteSavedFile(savedImagePath);

			/*
			 * 입력값 유지
			 */
			preserveFormValues(request, businessName, managerName, phone, email, content, linkUrl, adPosition,
					startDateValue, endDateValue);

			request.setAttribute("errorMessage", e.getMessage());

			request.getRequestDispatcher("/view/support/adInquiry.jsp").forward(request, response);

		} catch (IllegalStateException e) {

			deleteSavedFile(savedImagePath);

			preserveFormValues(request, businessName, managerName, phone, email, content, linkUrl, adPosition,
					startDateValue, endDateValue);

			getServletContext().log("광고 문의 처리 오류", e);

			request.setAttribute("errorMessage", "광고 문의 접수 중 오류가 발생했습니다.");

			request.getRequestDispatcher("/view/support/adInquiry.jsp").forward(request, response);

		} catch (Exception e) {

			deleteSavedFile(savedImagePath);

			preserveFormValues(request, businessName, managerName, phone, email, content, linkUrl, adPosition,
					startDateValue, endDateValue);

			getServletContext().log("광고 문의 처리 중 오류 발생", e);

			request.setAttribute("errorMessage", "광고 문의 접수 중 오류가 발생했습니다.");

			request.getRequestDispatcher("/view/support/adInquiry.jsp").forward(request, response);
		}
	}

	/*
	 * ========================================================= 오류 발생 시 입력값 유지
	 * =========================================================
	 */

	private void preserveFormValues(HttpServletRequest request, String businessName, String managerName, String phone,
			String email, String content, String linkUrl, String adPosition, String startDate, String endDate) {

		request.setAttribute("businessName", businessName);

		request.setAttribute("managerName", managerName);

		request.setAttribute("phone", phone);

		request.setAttribute("email", email);

		request.setAttribute("content", content);

		request.setAttribute("linkUrl", linkUrl);

		request.setAttribute("adPosition", adPosition);

		request.setAttribute("startDate", startDate);

		request.setAttribute("endDate", endDate);
	}

	/*
	 * ========================================================= 날짜
	 * =========================================================
	 */

	private Date parseDate(String value, String fieldName) {

		if (value == null || value.trim().isEmpty()) {

			throw new IllegalArgumentException(fieldName + "을 선택해주세요.");
		}

		try {

			return Date.valueOf(value.trim());

		} catch (IllegalArgumentException e) {

			throw new IllegalArgumentException("올바른 " + fieldName + "을 선택해주세요.");
		}
	}

	/*
	 * ========================================================= 실패 시 이미지 삭제
	 * =========================================================
	 */

	private void deleteSavedFile(Path savedImagePath) {

		if (savedImagePath == null) {

			return;
		}

		try {

			Files.deleteIfExists(savedImagePath);

		} catch (IOException e) {

			getServletContext().log("광고 이미지 임시 파일 삭제 실패", e);
		}
	}
}