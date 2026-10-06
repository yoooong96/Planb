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

import javax.servlet.annotation.MultipartConfig;
@WebServlet("/tipModify")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 10 * 1024 * 1024,
    maxRequestSize = 50 * 1024 * 1024
)
public class TipModify extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private TipService tipService;

    @Override
    public void init() throws ServletException {
        tipService = new TipServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 로그인 확인
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        UserDto user =(UserDto) session.getAttribute("user");
        long userId = user.getUserId();

        // tipId 받기
        String tipIdParam =request.getParameter("tipId");

        if (tipIdParam == null || tipIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/tipWriteList");
            return;
        }
        try {
            long tipId = Long.parseLong(tipIdParam);

            // 게시글 조회
            TipDto tip = tipService.selectTipDetail(tipId);

            // 게시글이 없는 경우
            if (tip == null) {
                response.sendRedirect(request.getContextPath() + "/tipWriteList");
                return;
            }
            // 본인이 작성한 글인지 확인
            if (tip.getUserId() != userId) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "본인이 작성한 글만 수정할 수 있습니다.");
                return;
            }
            // 수정 JSP로 전달
            request.setAttribute("tip", tip);
            request.getRequestDispatcher("/view/tips/tipModify.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/tipWriteList");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        UserDto user = (UserDto) session.getAttribute("user");
        try {
            long tipId = Long.parseLong(request.getParameter("tipId"));
            String title = request.getParameter("title");
            String hashtag = request.getParameter("hashtag");
            String content = request.getParameter("content");

            // 기본 입력값 검사
            if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/tipModify?tipId=" + tipId);
                return;
            }
            TipDto tip = new TipDto();

            tip.setTipId(tipId);
            tip.setUserId(user.getUserId());

            tip.setTitle(title.trim());
            tip.setHashtag(hashtag == null ? null : hashtag.trim());
            tip.setContent(content.trim());

            int result = tipService.updateTip(tip);
            if (result == 0) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "수정할 수 없는 게시글입니다.");
                return;
            }
            // 수정 완료 후 내가 작성한 글로 이동
            response.sendRedirect(request.getContextPath() + "/tipWriteList");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/tipWriteList");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}