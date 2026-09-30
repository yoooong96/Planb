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

}
