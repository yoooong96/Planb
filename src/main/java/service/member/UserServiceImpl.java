package service.member;

import java.io.File;
import java.nio.file.Paths;

import javax.servlet.http.Part;

import dao.member.UserDao;
import dao.member.UserDaoImpl;
import dto.member.UserDto;

public class UserServiceImpl implements UserService {
	private UserDao userDao;
	
	public UserServiceImpl() {
		userDao = new UserDaoImpl();
	}
	
	@Override
	public void signup(UserDto user, String uploadPath, Part profile) throws Exception {

	    if (profile != null) {

	        String submittedFileName = profile.getSubmittedFileName();

	        if (submittedFileName != null && !submittedFileName.isEmpty()) {

	            String fileName = Paths
	                    .get(submittedFileName)
	                    .getFileName()
	                    .toString();

	            System.out.println(fileName);

	            File uploadDir = new File(uploadPath);

	            if (!uploadDir.exists()) {
	                uploadDir.mkdirs();
	            }

	            profile.write(
	                uploadPath + File.separator + fileName
	            );

	            user.setProfileImg(fileName);
	        }
	    }

	    userDao.insertUser(user);
	}

	@Override
	public UserDto login(String id, String password) throws Exception {
		UserDto user = userDao.selectUser(id);
		if(user==null) throw new Exception("아이디 오류입니다.");
		if(!user.getPassword().equals(password)) throw new Exception("비밀번호 오류입니다.");
		user.setPassword("");
		return user;
	}

	@Override
	public boolean checkUserId(String id) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean withdraw(long userId, String password) throws Exception {
		String dbPassword = userDao.selectPasswordByUserId(userId);
		
		if(dbPassword == null) {
			throw new Exception("회원정보를 찾을 수 없습니다.");
		}
		
		if(!dbPassword.equals(password)) {
			throw new Exception("비밀번호가 일치하지 않습니다.");
		}
		
		int result = userDao.withdrawUser(userId);
		
		if(result == 0) {
			throw new Exception("회원 탈퇴 처리에 실패했습니다.");
		}
		
		return true;
	}

	@Override
	public Long findPasswordUser(String loginId, String name, String email, String phone) throws Exception {
		Long userId = userDao.findPasswordUser(loginId, name, email, phone);
		if(userId == null) {
			throw new Exception("일치하는 회원 정보가 없습니다.");
		}
		
		return userId;
		
	}

	@Override
	public void resetPassword(long userId, String password) throws Exception {
		int result = userDao.resetPassword(userId, password);
		if(result == 0) {
			throw new Exception("비밀번호 변경에 실패했습니다.");
		}
	}

	@Override
	public boolean isLoginIdAvailable(String loginId) {
		// TODO Auto-generated method stub
		return  userDao.countLoginId(loginId) == 0;
	}

	@Override
	public boolean isNicknameAvailable(String nickname) {
		// TODO Auto-generated method stub
		return userDao.countNickname(nickname) == 0;
	}

	@Override
	public boolean isEmailAvailable(String email) {
		// TODO Auto-generated method stub
		return userDao.countEmail(email) == 0;
	}

	@Override
	public UserDto findSocialUser(String provider, String providerUserId) throws Exception {
		return userDao.findSocialUser(provider, providerUserId);
	}

	@Override
	public void signupGoogle(UserDto user) throws Exception {
		userDao.insertGoogleUser(user);
		
	}

	@Override
	public void updateUser(UserDto user) throws Exception {
		userDao.updateUser(user);
		
	}

	@Override
	public UserDto selectUser(String loginId) throws Exception {
		return userDao.selectUser(loginId);
	}

}
