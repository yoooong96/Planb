package controller.community;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.community.TipDto;
import service.community.TipService;
import service.community.TipServiceImpl;

@WebServlet("/community/tiplist")
public class TipList extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public TipList() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 검색어 받기
		String keyword = request.getParameter("keyword");

		// Service 생성
		TipService service = new TipServiceImpl();

		// 조회된 여행꿀팁 목록
		List<TipDto> tipList;

		// 검색어가 없으면 전체 조회
		if (keyword == null || keyword.trim().isEmpty()) {

			tipList = service.getTipList();

		} else {

			// 앞뒤 공백 제거
			keyword = keyword.trim();

			// 해시태그 검색
			tipList = service.searchTipByHashtag(keyword);
		}

		// JSP로 데이터 전달
		request.setAttribute("tipList", tipList);
		request.setAttribute("keyword", keyword);

		// 여행꿀팁 목록 페이지로 이동
		request.getRequestDispatcher("/view/tips/tipList.jsp")
			   .forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
}