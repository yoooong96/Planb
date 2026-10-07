package service.report;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;

import dao.itinerary.ItineraryBookmarkDao;
import dao.itinerary.ItineraryBookmarkDaoImpl;

import dao.report.ReportDao;
import dao.report.ReportDaoImpl;

import dao.report.ReportReasonDao;
import dao.report.ReportReasonDaoImpl;

import dto.itinerary.ItineraryDto;

import dto.report.ReportDto;
import dto.report.ReportReasonDto;

public class ReportServiceImpl implements ReportService {

	private final ReportDao reportDao = new ReportDaoImpl();

	private final ReportReasonDao reportReasonDao = new ReportReasonDaoImpl();

	private final ItineraryBookmarkDao itineraryBookmarkDao = new ItineraryBookmarkDaoImpl();

	/*
	 * ========================================================= 일정 / 게시물용 신고 사유 목록
	 * =========================================================
	 */

	@Override
	public List<ReportReasonDto> getContentReportReasons() throws Exception {

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {

			return reportReasonDao.selectContentReportReasons(sqlSession);
		}
	}

	/*
	 * ========================================================= 여행 일정 신고
	 * =========================================================
	 */

	@Override
	public long submitItineraryReport(Long itineraryId, Long loginUserId, Integer reasonId, String detail)
			throws Exception {

		/*
		 * ===================================== 로그인 검사
		 * ======================================
		 */

		if (loginUserId == null || loginUserId <= 0) {

			throw new SecurityException("로그인 후 이용할 수 있습니다.");
		}

		/*
		 * ===================================== 일정 번호 검사
		 * ======================================
		 */

		if (itineraryId == null || itineraryId <= 0) {

			throw new IllegalArgumentException("올바른 일정 번호가 아닙니다.");
		}

		/*
		 * ===================================== 신고 사유 검사
		 * ======================================
		 */

		if (reasonId == null || reasonId <= 0) {

			throw new IllegalArgumentException("신고 사유를 선택해주세요.");
		}

		/*
		 * ===================================== 상세 내용 정리
		 * ======================================
		 */

		String normalizedDetail = detail == null ? "" : detail.strip();

		if (normalizedDetail.codePointCount(0, normalizedDetail.length()) > 300) {

			throw new IllegalArgumentException("상세 내용은 최대 300자까지 입력할 수 있습니다.");
		}

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false)) {

			try {

				/*
				 * ===================================== 일정 조회
				 * ======================================
				 */

				ItineraryDto itinerary = itineraryBookmarkDao.selectBookmarkTargetForUpdate(sqlSession, itineraryId);

				if (itinerary == null || !"ACTIVE".equals(itinerary.getStatus())) {

					throw new IllegalArgumentException("일정을 찾을 수 없습니다.");
				}

				/*
				 * ===================================== 자기 일정 신고 방지
				 * ======================================
				 */

				if (loginUserId.equals(itinerary.getUserId())) {

					throw new SecurityException("본인이 작성한 일정은 신고할 수 없습니다.");
				}

				/*
				 * ===================================== 공개 일정만 신고 가능
				 * ======================================
				 */

				if (!"PUBLIC".equals(itinerary.getVisibility())) {

					throw new SecurityException("공개된 일정만 신고할 수 있습니다.");
				}

				/*
				 * ===================================== CONTENT 신고 사유 확인
				 * ======================================
				 */

				ReportReasonDto reason = reportReasonDao.selectContentReportReason(sqlSession, reasonId);

				if (reason == null) {

					throw new IllegalArgumentException("사용할 수 없는 신고 사유입니다.");
				}

				/*
				 * ===================================== 신고 DTO
				 * ======================================
				 */

				ReportDto report = new ReportDto();

				report.setReporterUserId(loginUserId);

				/*
				 * 중요
				 *
				 * 일정 신고이므로 ITINERARY
				 */
				report.setTargetType("ITINERARY");

				/*
				 * 신고 대상 ID
				 *
				 * 여기서는 일정 번호
				 */
				report.setTargetId(itineraryId);

				/*
				 * 신고 당한 사용자
				 *
				 * 일정 작성자 ID
				 */
				report.setTargetUserId(itinerary.getUserId());

				/*
				 * 일정 신고이므로 특정 프로필 필드 없음
				 */
				report.setTargetField(null);

				report.setReasonId(reasonId);

				report.setDetail(normalizedDetail.isEmpty() ? null : normalizedDetail);

				report.setStatus("PENDING");

				report.setActionType("NONE");

				/*
				 * ===================================== INSERT
				 * ======================================
				 */

				int insertedRows = reportDao.insertReport(sqlSession, report);

				if (insertedRows != 1 || report.getReportId() <= 0) {

					throw new IllegalStateException("신고 접수에 실패했습니다.");
				}

				sqlSession.commit();

				return report.getReportId();

			} catch (Exception e) {

				sqlSession.rollback();

				throw e;
			}
		}
	}

	/*
	 * ========================================================= 사용자 프로필 신고
	 * =========================================================
	 */

	@Override
	public void reportUser(long reporterUserId, long targetUserId, String reasonCode, String detail) throws Exception {

		/*
		 * ===================================== 기본값 검사
		 * ======================================
		 */

		if (reporterUserId <= 0) {

			throw new SecurityException("로그인 후 이용할 수 있습니다.");
		}

		if (targetUserId <= 0) {

			throw new IllegalArgumentException("올바른 신고 대상이 아닙니다.");
		}

		if (reasonCode == null || reasonCode.trim().isEmpty()) {

			throw new IllegalArgumentException("신고 사유를 선택해 주세요.");
		}

		/*
		 * ===================================== 자기 자신 신고 방지
		 * ======================================
		 */

		if (reporterUserId == targetUserId) {

			throw new IllegalArgumentException("본인 계정은 신고할 수 없습니다.");
		}

		/*
		 * ===================================== 상세 내용 정리
		 * ======================================
		 */

		String normalizedDetail = detail == null ? "" : detail.strip();

		if (normalizedDetail.codePointCount(0, normalizedDetail.length()) > 300) {

			throw new IllegalArgumentException("상세 내용은 최대 300자까지 입력할 수 있습니다.");
		}

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false)) {

			try {

				/*
				 * ===================================== 중복 신고 확인
				 * ======================================
				 */

				int duplicateCount = reportDao.countUserReport(sqlSession, reporterUserId, targetUserId);

				if (duplicateCount > 0) {

					throw new IllegalStateException("이미 신고한 계정입니다.");
				}

				/*
				 * ===================================== USER 신고 사유 확인
				 * ======================================
				 */

				ReportReasonDto reason = reportReasonDao.selectUserReportReasonByCode(sqlSession, reasonCode);

				if (reason == null) {

					throw new IllegalArgumentException("올바르지 않은 신고 사유입니다.");
				}

				/*
				 * ===================================== 신고 DTO
				 * ======================================
				 */

				ReportDto report = new ReportDto();

				report.setReporterUserId(reporterUserId);

				/*
				 * ★ 중요 ★
				 *
				 * 프로필 신고이므로 무조건 USER
				 */
				report.setTargetType("USER");

				/*
				 * 사용자 신고에서는 targetId = 신고 당하는 user_id
				 */
				report.setTargetId(targetUserId);

				report.setTargetUserId(targetUserId);

				report.setReasonId(reason.getReasonId());

				report.setDetail(normalizedDetail.isEmpty() ? null : normalizedDetail);

				/*
				 * ===================================== 신고 대상 필드
				 * ======================================
				 */

				if ("NICKNAME".equals(reasonCode)) {

					report.setTargetField("NICKNAME");

				} else if ("PROFILE_IMAGE".equals(reasonCode)) {

					report.setTargetField("PROFILE_IMAGE");

				} else {

					/*
					 * SPAM IMPERSONATION PRIVACY ETC CONTENT 등
					 *
					 * 특정 필드가 아니라 사용자 자체 신고
					 */
					report.setTargetField(null);
				}

				report.setStatus("PENDING");

				report.setActionType("NONE");

				/*
				 * ===================================== INSERT
				 * ======================================
				 */

				int result = reportDao.insertReport(sqlSession, report);

				if (result != 1 || report.getReportId() <= 0) {

					throw new IllegalStateException("신고 등록에 실패했습니다.");
				}

				/*
				 * ===================================== COMMIT
				 * ======================================
				 */

				sqlSession.commit();

			} catch (Exception e) {

				sqlSession.rollback();

				throw e;
			}
		}
	}
}