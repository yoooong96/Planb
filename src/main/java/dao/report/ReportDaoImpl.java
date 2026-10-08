package dao.report;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.report.ReportDto;

public class ReportDaoImpl implements ReportDao {

	private static final String NAMESPACE = "mapper.itinerary.report.";

	/*
	 * ===================================================== 기존 신고 접수
	 * ======================================================
	 */

	@Override
	public int insertReport(SqlSession sqlSession, ReportDto reportDto) throws Exception {

		return sqlSession.insert(NAMESPACE + "insertReport", reportDto);
	}

	@Override
	public int countUserReport(SqlSession sqlSession, long reporterUserId, long targetUserId) throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("reporterUserId", reporterUserId);
		param.put("targetUserId", targetUserId);
		return sqlSession.selectOne(NAMESPACE + "countUserReport", param);
	}

	/*
	 * ===================================================== 관리자 신고 목록
	 * ======================================================
	 */

	@Override
	public List<ReportDto> selectAllReports(SqlSession sqlSession) throws Exception {

		return sqlSession.selectList(NAMESPACE + "selectAllReports");
	}

	/*
	 * ===================================================== 신고 1건
	 * ======================================================
	 */

	@Override
	public ReportDto selectReportById(SqlSession sqlSession, long reportId) throws Exception {

		return sqlSession.selectOne(NAMESPACE + "selectReportById", reportId);
	}

	/*
	 * ===================================================== 문제 없음 처리
	 * ======================================================
	 */

	@Override
	public int rejectReport(SqlSession sqlSession, long reportId, long adminUserId) throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("reportId", reportId);
		param.put("adminUserId", adminUserId);
		return sqlSession.update(NAMESPACE + "rejectReport", param);
	}

	/*
	 * ===================================================== 콘텐츠 삭제 신고 처리 완료
	 * ======================================================
	 */

	@Override
	public int resolveDeleteReport(SqlSession sqlSession, long reportId, long adminUserId) throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("reportId", reportId);
		param.put("adminUserId", adminUserId);
		return sqlSession.update(NAMESPACE + "resolveDeleteReport", param);
	}

	/*
	 * ===================================================== 회원 정지 신고 처리 완료
	 * ======================================================
	 */

	@Override
	public int resolveSuspendReport(SqlSession sqlSession, long reportId, long adminUserId) throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("reportId", reportId);
		param.put("adminUserId", adminUserId);
		return sqlSession.update(NAMESPACE + "resolveSuspendReport", param);
	}

	/*
	 * ===================================================== 여행 일정 삭제
	 * ======================================================
	 */

	@Override
	public int deleteItinerary(SqlSession sqlSession, long targetId, long adminUserId) throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("targetId", targetId);
		param.put("adminUserId", adminUserId);
		return sqlSession.update(NAMESPACE + "deleteItinerary", param);
	}

	/*
	 * ===================================================== 여행 꿀팁 삭제
	 * ======================================================
	 */

	@Override
	public int deleteTip(SqlSession sqlSession, long targetId, long adminUserId) throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("targetId", targetId);
		param.put("adminUserId", adminUserId);
		return sqlSession.update(NAMESPACE + "deleteTip", param);
	}

	/*
	 * ===================================================== 여행 메이트 삭제
	 * ======================================================
	 */

	@Override
	public int deleteMate(SqlSession sqlSession, long targetId, long adminUserId) throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("targetId", targetId);
		param.put("adminUserId", adminUserId);
		return sqlSession.update(NAMESPACE + "deleteMate", param);
	}

	/*
	 * ===================================================== 여행 꿀팁 댓글 삭제
	 * ======================================================
	 */

	@Override
	public int deleteTipComment(SqlSession sqlSession, long targetId) throws Exception {

		return sqlSession.update(NAMESPACE + "deleteTipComment", targetId);
	}

	/*
	 * ===================================================== 여행 메이트 댓글 삭제
	 * ======================================================
	 */

	@Override
	public int deleteMateComment(SqlSession sqlSession, long targetId) throws Exception {

		return sqlSession.update(NAMESPACE + "deleteMateComment", targetId);
	}

	/*
	 * ===================================================== 일정 댓글 삭제
	 * ======================================================
	 */

	@Override
	public int deleteItineraryComment(SqlSession sqlSession, long targetId) throws Exception {

		return sqlSession.update(NAMESPACE + "deleteItineraryComment", targetId);
	}

	/*
	 * ===================================================== 회원 정지
	 * ======================================================
	 */

	@Override
	public int suspendUser(SqlSession sqlSession, long userId) throws Exception {

		return sqlSession.update(NAMESPACE + "suspendUser", userId);
	}

	/*
	 * ===================================================== 관리자 조치 로그
	 * ======================================================
	 */

	@Override
	public int insertAdminActionLog(SqlSession sqlSession, long adminUserId, String actionType, String targetType,
			long targetId, long reportId, String memo) throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("adminUserId", adminUserId);
		param.put("actionType", actionType);
		param.put("targetType", targetType);
		param.put("targetId", targetId);
		param.put("reportId", reportId);
		param.put("memo", memo);
		return sqlSession.insert(NAMESPACE + "insertAdminActionLog", param);
	}
}