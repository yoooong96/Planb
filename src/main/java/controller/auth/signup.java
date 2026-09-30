package controller.auth;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dto.member.UserDto;
import service.member.UserService;
import service.member.UserServiceImpl;

/**
 * Servlet implementation class signup
 */
@WebServlet("/auth/signup")
@MultipartConfig(
		maxFileSize = 1024*1024*10, //개별 파일 최대 크기(10MB)
		maxRequestSize = 1024*1024*10*5, //전체 요청 최대 크리(50MB)
		fileSizeThreshold = 1024*1024*1 //1MB 초과시 임시 디스크 경로 사용
	)

public class signup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public signup() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/view/auth/signup.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDto userDto = new UserDto();
		userDto.setLoginId(request.getParameter("loginId"));
		userDto.setPassword(request.getParameter("password"));
		userDto.setEmail(request.getParameter("email"));
		userDto.setAddress(request.getParameter("address"));
		userDto.setPostcode(request.getParameter("postcode"));
		userDto.setAddressDetail(request.getParameter("addressDetail"));
		userDto.setRegion(request.getParameter("region"));
		String birthDateStr = request.getParameter("birthDate");

		Date birthDate = null;

		if (birthDateStr != null && !birthDateStr.trim().isEmpty()) {
		    birthDate = Date.valueOf(birthDateStr);
		}
		
		userDto.setBirthDate(birthDate);
		userDto.setPhone(request.getParameter("phone"));
		userDto.setNickName(request.getParameter("nickname"));
		userDto.setBio(request.getParameter("bio"));
		userDto.setName(request.getParameter("name"));
		
		Part profile = request.getPart("profileImage");
		String uploadPath = (String)request.getServletContext().getAttribute("profilePath");
		String realPath = request.getServletContext().getRealPath(uploadPath);
		
		UserService service = new UserServiceImpl();
		try {
			service.signup(userDto, realPath, profile);
			request.getRequestDispatcher("/view/auth/login.jsp").forward(request, response);;
		} catch(Exception e) {
			e.printStackTrace();
			request.getRequestDispatcher("/error.jsp");
		}
	}

}
