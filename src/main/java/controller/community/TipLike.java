package controller.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.community.TipLikeDto;
import dto.member.UserDto;
import service.community.TipLikeService;
import service.community.TipLikeServiceImpl;

@WebServlet("/tipLike")
public class TipLike extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public TipLike() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // AJAX 요청이므로 JSON으로 응답
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 1. 로그인 확인
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"success\":false,\"loginRequired\":true}");
            return;
        }

        UserDto user = (UserDto) session.getAttribute("user");

        // 2. 게시글 번호 받기
        String tipIdParam = request.getParameter("tipId");

        if (tipIdParam == null || tipIdParam.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false}");
            return;
        }
        long tipId;

        try {
            tipId = Long.parseLong(tipIdParam);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false}");
            return;
        }
        // 3. 좋아요 DTO
        TipLikeDto tipLikeDto = new TipLikeDto();

        tipLikeDto.setTipId(tipId);
        tipLikeDto.setUserId(user.getUserId());

        TipLikeService tipLikeService = new TipLikeServiceImpl();

        // 4. 현재 좋아요 여부
        TipLikeDto existingLike = tipLikeService.selectTipLike(tipLikeDto);

        // 현재 처리 후 좋아요 상태를 저장할 변수
        boolean liked;

        // 5. 좋아요 토글
        if (existingLike == null) {
            // 좋아요 등록
            tipLikeService.insertTipLike(tipLikeDto);
            liked = true;
        } else {
            // 좋아요 취소
            tipLikeService.deleteTipLike(tipLikeDto);
            liked = false;
        }
        // 6. 변경 후 좋아요 개수
        int likeCount = tipLikeService.selectTipLikeCount(tipId);

        // 7. JSON 응답
        String json =
                "{"
                + "\"success\":true,"
                + "\"liked\":" + liked + ","
                + "\"likeCount\":" + likeCount
                + "}";

        response.getWriter().write(json);
    }
}