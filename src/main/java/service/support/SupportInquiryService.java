package service.support;

public interface SupportInquiryService {
	long submitInquiry(long userId, String category, String email, String title, String content) throws Exception;
}
