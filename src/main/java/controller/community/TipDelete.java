package controller.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.community.TipDto;
import dto.member.UserDto;
import service.community.TipService;
import service.community.TipServiceImpl;

@WebServlet("/tipDelete")
public class TipDelete extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 로그인 확인
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"success\":false,\"loginRequired\":true}");
            return;
        }

        UserDto user = (UserDto) session.getAttribute("user");
        String tipIdParam = request.getParameter("tipId");
        if (tipIdParam == null || tipIdParam.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false}");
            return;
        }
        try {
            long tipId = Long.parseLong(tipIdParam);
            TipService tipService = new TipServiceImpl();
            // 게시글 조회
            TipDto tip = tipService.selectTipDetail(tipId);
            if (tip == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"success\":false}");
                return;
            }
            // 작성자 확인
            if (tip.getUserId() != user.getUserId()) {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                response.getWriter().write("{\"success\":false}");
                return;
            }

            // 다음 단계에서 실제 삭제 처리
            int result = tipService.deleteTip(tipId, user.getUserId());
            if (result > 0) {
                response.getWriter().write("{\"success\":true}");
            } 
            else {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                response.getWriter().write("{\"success\":false}");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false}");
        }
    }
}