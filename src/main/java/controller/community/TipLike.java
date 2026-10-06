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

        // 1. 로그인 확인
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        UserDto user = (UserDto) session.getAttribute("user");

        // 2. 게시글 번호 받기
        String tipIdParam = request.getParameter("tipId");

        if (tipIdParam == null || tipIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/tips");
            return;
        }

        long tipId;

        try {
            tipId = Long.parseLong(tipIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/tips");
            return;
        }

        // 3. 좋아요 DTO 생성
        TipLikeDto tipLikeDto = new TipLikeDto();

        tipLikeDto.setTipId(tipId);
        tipLikeDto.setUserId(user.getUserId());

        TipLikeService tipLikeService = new TipLikeServiceImpl();

        // 4. 현재 좋아요 여부 확인
        TipLikeDto existingLike = tipLikeService.selectTipLike(tipLikeDto);

        // 5. 좋아요 토글
        if (existingLike == null) {
            // 좋아요가 없으면 등록
            tipLikeService.insertTipLike(tipLikeDto);
        } else {
            // 이미 좋아요 했으면 취소
            tipLikeService.deleteTipLike(tipLikeDto);
        }

        // 6. 다시 상세페이지로 이동
        response.sendRedirect(request.getContextPath() + "/tipDetail?tipId=" + tipId);
    }
}