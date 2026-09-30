package dao.member;

import dto.member.UserDto;

public interface UserDao {
	void insertUser(UserDto userDto) throws Exception;
	UserDto selectUser(String id) throws Exception;
	void updateUser(UserDto userDto) throws Exception;
}
