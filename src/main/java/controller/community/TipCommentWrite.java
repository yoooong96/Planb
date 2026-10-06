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

@WebServlet("/tipCommentWrite")
public class TipCommentWrite extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public TipCommentWrite() {
        super();
    }

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
        // 요청값
        String tipIdParam = request.getParameter("tipId");
        String content = request.getParameter("content");
        // 값 검증
        if (tipIdParam == null || tipIdParam.trim().isEmpty() || content == null || content.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false}");
            return;
        }
        try {
            long tipId = Long.parseLong(tipIdParam);

            // DTO 생성
            TipCommentDto tipCommentDto = new TipCommentDto();

            tipCommentDto.setTipId(tipId);
            tipCommentDto.setUserId(user.getUserId());
            tipCommentDto.setContent(content.trim());

            // 댓글 저장
            TipCommentService tipCommentService = new TipCommentServiceImpl();
            int result = tipCommentService.insertTipComment(tipCommentDto);
            if (result > 0) {
                response.getWriter().write("{" + "\"success\":true," + "\"commentId\":" + tipCommentDto.getCommentId() + "}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"success\":false}");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false}");
        }
    }
}