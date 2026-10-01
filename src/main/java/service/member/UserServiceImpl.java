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

}
