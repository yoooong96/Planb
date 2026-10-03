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

@WebServlet("/tips/load")
public class TipLoad extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private TipService tipService;

	@Override
	public void init() throws ServletException {
		tipService = new TipServiceImpl();
	}

	@Override
	protected void doGet(
			HttpServletRequest request,
			HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String country = request.getParameter("country");
		String keyword = request.getParameter("keyword");
		String sort = request.getParameter("sort");

		if (sort == null || sort.trim().isEmpty()) {
			sort = "latest";
		}

		// 기본값
		int page = 2;
		int pageSize = 8;

		try {
			String pageParam = request.getParameter("page");

			if (pageParam != null && !pageParam.trim().isEmpty()) {
				page = Integer.parseInt(pageParam);
			}

			if (page < 1) {
				page = 1;
			}

		} catch (NumberFormatException e) {
			page = 2;
		}

		try {

			List<TipDto> tipList =
					tipService.selectTipListByFilter(
							country,
							keyword,
							sort,
							page,
							pageSize
					);

			int totalCount =
					tipService.countTipListByFilter(
							country,
							keyword
					);

			request.setAttribute("tipList", tipList);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("page", page);
			request.setAttribute("pageSize", pageSize);

			request.getRequestDispatcher(
					"/view/tips/tipCardList.jsp"
			).forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
	}
}