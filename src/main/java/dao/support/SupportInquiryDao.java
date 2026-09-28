package dao.support;

import dto.support.SupportInquiryDto;

public interface SupportInquiryDao {
	void insertSupportInquiry(SupportInquiryDto supportInquiryDto) throws Exception;
	void selectSupportInquiry(SupportInquiryDto supportInquiryDto) throws Exception;
	void updateSupportInquiry(SupportInquiryDto supportInquiryDto) throws Exception;
	void deleteSupportInquiry(SupportInquiryDto supportInquiryDto) throws Exception;
}
