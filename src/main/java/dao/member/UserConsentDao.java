package dao.member;

import dto.member.UserConsentDto;

public interface UserConsentDao {
	void insertUserConsent(UserConsentDto userConsentDto) throws Exception;
	void selectUserConsent(UserConsentDto userConsentDto) throws Exception;
	void updateUserConsent(UserConsentDto userConsentDto) throws Exception;
	void deleteUserConsent(UserConsentDto userConsentDto) throws Exception;
}
