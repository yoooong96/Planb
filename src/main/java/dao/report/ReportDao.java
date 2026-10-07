package dao.report;

import org.apache.ibatis.session.SqlSession;

import dto.report.ReportDto;

public interface ReportDao {

	int insertReport(SqlSession sqlSession, ReportDto reportDto) throws Exception;
}