package controller.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.community.TipCommentDto;
import dto.member.UserDto;
import service.community.TipCommentService;
import service.community.TipCommentServiceImpl;

@WebServlet("/tipCommentDelete")
public class TipCommentDelete extends HttpServlet {

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

        String commentIdParam = request.getParameter("commentId");

        // commentId 확인
        if (commentIdParam == null || commentIdParam.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false}");
            return;
        }

        try {
            long commentId = Long.parseLong(commentIdParam);
            TipCommentDto tipCommentDto = new TipCommentDto();
            tipCommentDto.setCommentId(commentId);

            // 현재 로그인 사용자 ID
            tipCommentDto.setUserId(user.getUserId());

            TipCommentService tipCommentService = new TipCommentServiceImpl();

            int result = tipCommentService.deleteTipComment(tipCommentDto);

            if (result > 0) {
                response.getWriter().write("{\"success\":true}");
            } else {
                // 본인 댓글이 아니거나 존재하지 않는 댓글
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                response.getWriter().write("{\"success\":false}");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false}");
        }
    }
}