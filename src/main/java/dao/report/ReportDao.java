package dao.report;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.report.ReportDto;

public interface ReportDao {

	/*
	 * ===================================================== 기존 신고 접수
	 * ======================================================
	 */

	int insertReport(SqlSession sqlSession, ReportDto reportDto) throws Exception;

	int countUserReport(SqlSession sqlSession, long reporterUserId, long targetUserId) throws Exception;

	/*
	 * ===================================================== 관리자 신고 관리
	 * ======================================================
	 */

	/* 전체 신고 조회 */
	List<ReportDto> selectAllReports(SqlSession sqlSession) throws Exception;

	/* 신고 1건 조회 */
	ReportDto selectReportById(SqlSession sqlSession, long reportId) throws Exception;

	/* 문제 없음 처리 */
	int rejectReport(SqlSession sqlSession, long reportId, long adminUserId) throws Exception;

	/* 신고 삭제 처리 완료 */
	int resolveDeleteReport(SqlSession sqlSession, long reportId, long adminUserId) throws Exception;

	/* 회원 정지 처리 완료 */
	int resolveSuspendReport(SqlSession sqlSession, long reportId, long adminUserId) throws Exception;

	/*
	 * ===================================================== 실제 콘텐츠 삭제
	 * ======================================================
	 */

	int deleteItinerary(SqlSession sqlSession, long targetId, long adminUserId) throws Exception;

	int deleteTip(SqlSession sqlSession, long targetId, long adminUserId) throws Exception;

	int deleteMate(SqlSession sqlSession, long targetId, long adminUserId) throws Exception;

	int deleteTipComment(SqlSession sqlSession, long targetId) throws Exception;

	int deleteMateComment(SqlSession sqlSession, long targetId) throws Exception;

	int deleteItineraryComment(SqlSession sqlSession, long targetId) throws Exception;

	/*
	 * ===================================================== 회원 정지
	 * ======================================================
	 */

	int suspendUser(SqlSession sqlSession, long userId) throws Exception;

	/*
	 * ===================================================== 관리자 조치 로그
	 * ======================================================
	 */

	int insertAdminActionLog(SqlSession sqlSession, long adminUserId, String actionType, String targetType,
			long targetId, long reportId, String memo) throws Exception;
}