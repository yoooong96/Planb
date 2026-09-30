package service.member;

import javax.servlet.http.Part;

import dto.member.UserDto;

public interface UserService {
	void signup(UserDto user, String uploadPath, Part profile) throws Exception;
	UserDto login(String id, String password) throws Exception;
	boolean checkUserId(String id) throws Exception;
}
