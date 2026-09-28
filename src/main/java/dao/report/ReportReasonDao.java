package dao.report;

import dto.report.ReportReasonDto;

public interface ReportReasonDao {
	void insertReportReason(ReportReasonDto reportReasonDto) throws Exception;
	void selectReportReason(ReportReasonDto reportReasonDto) throws Exception;
	void updateReportReason(ReportReasonDto reportReasonDto) throws Exception;
	void deleteReportReason(ReportReasonDto reportReasonDto) throws Exception;
}
