package dao.report;

import org.apache.ibatis.session.SqlSession;

import dto.report.ReportDto;

public class ReportDaoImpl implements ReportDao {

	@Override
	public int insertReport(SqlSession sqlSession, ReportDto reportDto) throws Exception {

		return sqlSession.insert("mapper.itinerary.report.insertReport", reportDto);
	}
}