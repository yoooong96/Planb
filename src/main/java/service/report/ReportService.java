package service.report;

import java.util.List;

import dto.report.ReportReasonDto;

public interface ReportService {
	
	List<ReportReasonDto> getContentReportReasons() throws Exception;

	long submitItineraryReport(Long itineraryId, Long loginUserId, Integer reasonId, String detail) throws Exception;
}