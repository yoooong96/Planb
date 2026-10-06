package controller.community;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDto;
import dto.community.TipDto;
import service.community.TipService;
import service.community.TipServiceImpl;

@WebServlet("/tipWriteList")
public class TipWriteList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TipService tipService;
	@Override
	public void init() throws ServletException {
		tipService = new TipServiceImpl();
	}
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// 로그인 세션 확인
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		// 현재 로그인 사용자
		UserDto user = (UserDto) session.getAttribute("user");
		long userId = user.getUserId();

		/* ================================
		 * 페이지 처리
		 * ================================ */

		// 한 페이지에 보여줄 게시글 수
		int pageSize = 5;

		// 현재 페이지
		int page = 1;

		String pageParam = request.getParameter("page");

		if (pageParam != null && !pageParam.trim().isEmpty()) {
		    try {
		        page = Integer.parseInt(pageParam);

		        // 0이나 음수 방지
		        if (page < 1) {
		            page = 1;
		        }

		    } catch (NumberFormatException e) {
		        page = 1;
		    }
		}

		// DB 조회 시작 위치
		int offset = (page - 1) * pageSize;

		try {
		    // 현재 페이지 게시글 5개 조회
		    List<TipDto> tipList = tipService.selectMyTipList(userId, offset, pageSize);

		    // 내가 작성한 전체 게시글 개수
		    int totalCount = tipService.countMyTipList(userId);

		    // 전체 페이지 수 계산
		    int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		    // 잘못된 페이지 번호 방지
		    if (totalPages > 0 && page > totalPages) {
		        page = totalPages;
		        offset = (page - 1) * pageSize;

		        tipList = tipService.selectMyTipList(userId, offset, pageSize);
		    }

		    // JSP로 전달
		    request.setAttribute("tipList", tipList);

		    request.setAttribute("currentPage", page);
		    request.setAttribute("totalPages", totalPages);
		    request.setAttribute("totalCount", totalCount);

		    request.getRequestDispatcher("/view/tips/tipWriteList.jsp").forward(request, response);
		} catch (Exception e) {
		    e.printStackTrace();
		    throw new ServletException(e);
		}
	}
}