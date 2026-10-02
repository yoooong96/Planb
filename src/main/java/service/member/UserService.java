package service.member;

import javax.servlet.http.Part;

import dto.member.UserDto;

public interface UserService {
	void signup(UserDto user, String uploadPath, Part profile) throws Exception;
	UserDto login(String id, String password) throws Exception;
	boolean checkUserId(String id) throws Exception;
	boolean withdraw(long userId, String password) throws Exception;
	Long findPasswordUser(String loginId, String name, String email, String phone) throws Exception;
	void resetPassword(long userId, String password) throws Exception;
	boolean isLoginIdAvailable(String loginId);
	boolean isNicknameAvailable(String nickname);
	boolean isEmailAvailable(String email);
	UserDto findSocialUser(String provider, String providerUserId) throws Exception;
	void signupGoogle(UserDto user) throws Exception;
	void updateUser(UserDto user) throws Exception;
	UserDto selectUser(String loginId) throws Exception;
}
