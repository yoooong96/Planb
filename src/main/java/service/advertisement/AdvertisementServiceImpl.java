package service.advertisement;

import java.net.URI;
import java.time.LocalDate;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;

import dao.advertisement.AdvertisementDao;
import dao.advertisement.AdvertisementDaoImpl;

import dto.advertisement.AdvertisementDto;

public class AdvertisementServiceImpl implements AdvertisementService {

	private final AdvertisementDao advertisementDao = new AdvertisementDaoImpl();

	@Override
	public long submitAdvertisement(AdvertisementDto advertisement) throws Exception {

		if (advertisement == null) {
			throw new IllegalArgumentException("광고 신청 정보를 확인해주세요.");
		}

		/*
		 * ===================================================== 업체명
		 * ======================================================
		 */

		String businessName = normalize(advertisement.getBusinessName());

		if (businessName.isEmpty()) {
			throw new IllegalArgumentException("회사 또는 브랜드명을 입력해주세요.");
		}

		if (businessName.length() > 100) {
			throw new IllegalArgumentException("회사 또는 브랜드명은 100자 이하로 입력해주세요.");
		}

		/*
		 * ===================================================== 담당자명
		 * ======================================================
		 */

		String managerName = normalize(advertisement.getManagerName());

		if (managerName.isEmpty()) {
			throw new IllegalArgumentException("담당자명을 입력해주세요.");
		}

		if (managerName.length() > 100) {
			throw new IllegalArgumentException("담당자명은 100자 이하로 입력해주세요.");
		}

		/*
		 * ===================================================== 전화번호
		 * ======================================================
		 */

		String phone = normalize(advertisement.getContactPhone());

		if (phone.isEmpty()) {
			throw new IllegalArgumentException("연락처를 입력해주세요.");
		}

		if (phone.length() > 30) {
			throw new IllegalArgumentException("연락처를 확인해주세요.");
		}

		/*
		 * ===================================================== 이메일
		 * ======================================================
		 */

		String email = normalize(advertisement.getContactEmail());

		if (email.isEmpty()) {
			throw new IllegalArgumentException("이메일을 입력해주세요.");
		}

		if (email.length() > 150) {
			throw new IllegalArgumentException("이메일은 150자 이하로 입력해주세요.");
		}

		if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
			throw new IllegalArgumentException("올바른 이메일 형식이 아닙니다.");
		}

		/*
		 * ===================================================== 광고 위치
		 * ======================================================
		 */

		String adPosition = normalize(advertisement.getAdPosition());

		if (!"MAIN_BANNER".equals(adPosition) && !"TRIP_CARD".equals(adPosition)) {
			throw new IllegalArgumentException("올바른 광고 영역을 선택해주세요.");
		}

		/*
		 * ===================================================== 날짜
		 * ======================================================
		 */

		if (advertisement.getStartDate() == null || advertisement.getEndDate() == null) {
			throw new IllegalArgumentException("광고 기간을 선택해주세요.");
		}

		LocalDate startDate = advertisement.getStartDate().toLocalDate();

		LocalDate endDate = advertisement.getEndDate().toLocalDate();

		if (startDate.isBefore(LocalDate.now())) {
			throw new IllegalArgumentException("광고 시작일은 오늘 이후로 선택해주세요.");
		}

		if (endDate.isBefore(startDate)) {
			throw new IllegalArgumentException("광고 종료일은 시작일 이후여야 합니다.");
		}

		/*
		 * ===================================================== 광고 내용
		 * ======================================================
		 */

		String adContent = normalize(advertisement.getAdContent());

		if (adContent.isEmpty()) {
			throw new IllegalArgumentException("광고 내용을 입력해주세요.");
		}

		if (adContent.length() > 3000) {
			throw new IllegalArgumentException("광고 내용은 최대 3000자까지 입력할 수 있습니다.");
		}

		/*
		 * ===================================================== 이미지
		 * ======================================================
		 */

		String imageUrl = normalize(advertisement.getImageUrl());

		if (imageUrl.isEmpty()) {
			throw new IllegalArgumentException("광고 이미지를 등록해주세요.");
		}

		if (imageUrl.length() > 500) {
			throw new IllegalArgumentException("광고 이미지 경로가 너무 깁니다.");
		}

		/*
		 * ===================================================== 링크
		 * ======================================================
		 */

		String linkUrl = normalize(advertisement.getLinkUrl());

		if (!linkUrl.isEmpty()) {
			if (linkUrl.length() > 500) {
				throw new IllegalArgumentException("광고 연결 주소는 500자 이하로 입력해주세요.");
			}

			try {
				URI uri = new URI(linkUrl);
				String scheme = uri.getScheme();
				if (scheme == null || (!"http".equalsIgnoreCase(scheme) && !"https".equalsIgnoreCase(scheme))) {
					throw new IllegalArgumentException("광고 연결 주소는 http 또는 https 주소만 사용할 수 있습니다.");
				}

			} catch (IllegalArgumentException e) {
				throw e;

			} catch (Exception e) {
				throw new IllegalArgumentException("올바른 광고 연결 주소를 입력해주세요.");
			}
		}

		/*
		 * ===================================================== 정리된 값 다시 DTO에 저장
		 * ======================================================
		 */

		advertisement.setBusinessName(businessName);
		advertisement.setManagerName(managerName);
		advertisement.setContactPhone(phone);
		advertisement.setContactEmail(email);
		advertisement.setAdContent(adContent);
		advertisement.setAdPosition(adPosition);
		advertisement.setImageUrl(imageUrl);
		advertisement.setLinkUrl(linkUrl.isEmpty() ? null : linkUrl);

		/*
		 * 사용자가 상태를 결정하면 안 됨
		 */
		advertisement.setStatus("PENDING_APPROVAL");

		/*
		 * ===================================================== 광고 + 접수 이력을 하나의 트랜잭션으로
		 * 저장 ======================================================
		 */

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false)) {
			try {
				int adResult = advertisementDao.insertAdvertisement(sqlSession, advertisement);
				if (adResult != 1 || advertisement.getAdId() <= 0) {
					throw new IllegalStateException("광고 문의 등록에 실패했습니다.");
				}
				int historyResult = advertisementDao.insertSubmittedHistory(sqlSession, advertisement.getAdId(),
						advertisement.getContactEmail());
				if (historyResult != 1) {
					throw new IllegalStateException("광고 접수 이력 저장에 실패했습니다.");
				}

				sqlSession.commit();

				return advertisement.getAdId();

			} catch (Exception e) {
				sqlSession.rollback();
				throw e;
			}
		}
	}

	private String normalize(String value) {
		return value == null ? "" : value.trim();
	}
}