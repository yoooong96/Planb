package dao.member;

import dto.member.UserDto;

public interface UserDao {
	void insertUser(UserDto userDto) throws Exception;
	void selectUser(UserDto userDto) throws Exception;
	void updateUser(UserDto userDto) throws Exception;
	void deleteUser(UserDto userDto) throws Exception;
}
