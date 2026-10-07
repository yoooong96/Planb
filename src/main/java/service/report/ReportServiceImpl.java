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

	@Override
	public List<ReportReasonDto> getContentReportReasons() throws Exception {

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return reportReasonDao.selectContentReportReasons(sqlSession);
		}
	}

	@Override
	public long submitItineraryReport(Long itineraryId, Long loginUserId, Integer reasonId, String detail)
			throws Exception {
		if (loginUserId == null || loginUserId <= 0) {
			throw new SecurityException("로그인 후 이용할 수 있습니다.");
		}

		if (itineraryId == null || itineraryId <= 0) {
			throw new IllegalArgumentException("올바른 일정 번호가 아닙니다.");
		}

		if (reasonId == null || reasonId <= 0) {
			throw new IllegalArgumentException("신고 사유를 선택해주세요.");
		}

		String normalizedDetail = detail == null ? "" : detail.strip();

		if (normalizedDetail.codePointCount(0, normalizedDetail.length()) > 300) {

			throw new IllegalArgumentException("상세 내용은 최대 300자까지 입력할 수 있습니다.");
		}

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false)) {

			try {
				// 신고 접수 중 일정 상태 변경을 막기 위해 조회 및 잠금
				ItineraryDto itinerary = itineraryBookmarkDao.selectBookmarkTargetForUpdate(sqlSession, itineraryId);

				if (itinerary == null || !"ACTIVE".equals(itinerary.getStatus())) {

					throw new IllegalArgumentException("일정을 찾을 수 없습니다.");
				}

				if (loginUserId.equals(itinerary.getUserId())) {
					throw new SecurityException("본인이 작성한 일정은 신고할 수 없습니다.");
				}

				if (!"PUBLIC".equals(itinerary.getVisibility())) {
					throw new SecurityException("공개된 일정만 신고할 수 있습니다.");
				}

				// 비활성 사유나 사용자 전용 사유 제출 차단
				ReportReasonDto reason = reportReasonDao.selectContentReportReason(sqlSession, reasonId);

				if (reason == null) {
					throw new IllegalArgumentException("사용할 수 없는 신고 사유입니다.");
				}

				ReportDto report = new ReportDto();

				report.setReporterUserId(loginUserId);
				report.setTargetType("ITINERARY");
				report.setTargetId(itineraryId);

				// 브라우저에서 받지 않고 조회한 작성자 ID 사용
				report.setTargetUserId(itinerary.getUserId());

				report.setReasonId(reasonId);
				report.setDetail(normalizedDetail.isEmpty() ? null : normalizedDetail);

				report.setStatus("PENDING");
				report.setActionType("NONE");

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
}