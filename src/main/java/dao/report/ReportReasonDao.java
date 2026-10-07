package dao.report;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.report.ReportReasonDto;

public interface ReportReasonDao {

	// 팝업에 표시할 활성 신고 사유 목록
	List<ReportReasonDto> selectContentReportReasons(SqlSession sqlSession) throws Exception;
	// 제출된 사유 번호가 일정 신고에 사용할 수 있는지 확인
	ReportReasonDto selectContentReportReason(SqlSession sqlSession, Integer reasonId) throws Exception;
	
	List<ReportReasonDto>selectUserReportReasons(SqlSession sqlSession) throws Exception;
	ReportReasonDto selectUserReportReasonByCode(SqlSession sqlSession, String reasonCode) throws Exception;
}