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

@WebServlet("/tips")
public class TipList extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private TipService tipService;

	public TipList() {
		super();
		tipService = new TipServiceImpl();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String country = request.getParameter("country");
		String keyword = request.getParameter("keyword");
		String sort = request.getParameter("sort");
	
		if (sort == null || sort.trim().isEmpty()) {
			sort = "latest";
		}
		
		// 무한 스크롤 페이지 설정
		int page = 1;
		int pageSize = 8;
		
		try {
			List<TipDto> tipList = tipService.selectTipListByFilter(country, keyword, sort, page, pageSize);
			int totalCount = tipService.countTipListByFilter(country, keyword);

			request.setAttribute("tipList", tipList);
			request.setAttribute("country", country);
			request.setAttribute("keyword", keyword);
			request.setAttribute("sort", sort);
			request.setAttribute("page", page);
			request.setAttribute("pageSize", pageSize);
			request.setAttribute("totalCount", totalCount);

			request.getRequestDispatcher("/view/tips/tipList.jsp" ).forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}