package dao.report;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.report.ReportDto;

public class ReportDaoImpl implements ReportDao {

	@Override
	public int insertReport(SqlSession sqlSession, ReportDto reportDto) throws Exception {

		return sqlSession.insert("mapper.itinerary.report.insertReport", reportDto);
	}

	@Override
	public int countUserReport(SqlSession sqlSession, long reporterUserId, long targetUserId) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("reporterUserId", reporterUserId);
		param.put("targetUserId", targetUserId);
		return sqlSession.selectOne("mapper.itinerary.report.countUserReport", param);
	}
}