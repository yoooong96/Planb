package dao.report;

import dto.report.ReportDto;

public interface ReportDao {
	void insertReport(ReportDto reportDto) throws Exception;
	void selectReport(ReportDto reportDto) throws Exception;
	void updateReport(ReportDto reportDto) throws Exception;
	void deleteReport(ReportDto reportDto) throws Exception;
}
