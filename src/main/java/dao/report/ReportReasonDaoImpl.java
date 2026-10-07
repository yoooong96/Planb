package dao.report;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.report.ReportReasonDto;

public class ReportReasonDaoImpl implements ReportReasonDao {

	@Override
	public List<ReportReasonDto> selectContentReportReasons(SqlSession sqlSession) throws Exception {

		return sqlSession.selectList("mapper.itinerary.reportReason.selectContentReportReasons");
	}

	@Override
	public ReportReasonDto selectContentReportReason(SqlSession sqlSession, Integer reasonId) throws Exception {

		return sqlSession.selectOne("mapper.itinerary.reportReason.selectContentReportReason", reasonId);
	}

	@Override
	public List<ReportReasonDto> selectUserReportReasons(SqlSession sqlSession) throws Exception {
		return sqlSession.selectList("mapper.itinerary.reportReason.selectUserReportReasons");
	}

	@Override
	public ReportReasonDto selectUserReportReasonByCode(SqlSession sqlSession, String reasonCode) throws Exception {
		return sqlSession.selectOne("mapper.itinerary.reportReason.selectUserReportReasonByCode", reasonCode);
	}
}