package controller.itinerary;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 구버전 /planner 주소 호환용.
 * 신규 작성과 수정 화면은 각각 /writeplan, /modifyplan으로 분리한다.
 */
@WebServlet("/planner")
public class PlannerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String itineraryId = request.getParameter("itineraryId");

        if (itineraryId != null && !itineraryId.trim().isEmpty()) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/modifyplan?itineraryId="
                    + java.net.URLEncoder.encode(itineraryId, "UTF-8")
            );
            return;
        }

        response.sendRedirect(request.getContextPath() + "/writeplan");
    }
}
