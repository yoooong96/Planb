package controller.community;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.community.MateDto;
import dto.member.UserDto;
import service.community.MateService;
import service.community.MateServiceImpl;

@WebServlet("/mateWriteList")
public class MateWriteList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MateService mateService = new MateServiceImpl();

	public MateWriteList() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// ========================================
		// 1. 로그인 사용자 확인
		// ========================================
		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}

		UserDto user = (UserDto) session.getAttribute("user");

		// ========================================
		// 2. 페이지 정보
		// ========================================
		int page = 1;
		int pageSize = 5;

		try {
			String pageParam = request.getParameter("page");
			if (pageParam != null && !pageParam.trim().isEmpty()) {
				page = Integer.parseInt(pageParam);
			}
		} catch (NumberFormatException e) {
			page = 1;
		}
		if (page < 1) {
			page = 1;
		}

		int offset = (page - 1) * pageSize;

		// ========================================
		// 3. 내가 작성한 여행 메이트 조회
		// ========================================
		List<MateDto> mateList = mateService.selectMateWriteList(user.getUserId(), pageSize, offset);

		int totalCount = mateService.countMateWriteList(user.getUserId());

		// ========================================
		// 4. 전체 페이지 수
		// ========================================
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		// ========================================
		// 5. JSP 전달
		// ========================================
		request.setAttribute("mateList", mateList);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("page", page);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totalPages", totalPages);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/view/mates/mateWriteList.jsp");
		dispatcher.forward(request, response);
	}
}