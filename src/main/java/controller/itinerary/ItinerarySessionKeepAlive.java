package controller.itinerary;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 일정 작성/수정 화면에서 사용자가 실제로 작업 중일 때 로그인 세션을 유지한다.
 * 이 요청이 정상적으로 들어오면 HttpSession의 lastAccessedTime이 갱신된다.
 */
@WebServlet("/itinerary/session/keepalive")
public class ItinerarySessionKeepAlive extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        response.setHeader("Pragma", "no-cache");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        // 요청이 들어온 것 자체로 세션의 마지막 접근 시간이 갱신된다.
        response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    }
}
