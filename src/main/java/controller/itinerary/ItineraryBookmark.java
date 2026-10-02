package controller.itinerary;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dto.member.UserDto;
import service.itinerary.ItineraryService;
import service.itinerary.ItineraryServiceImpl;

/**
 * Servlet implementation class ItineraryBookmark
 */
@WebServlet("/itinerary/bookmark")
public class ItineraryBookmark extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private final Gson gson = new Gson();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItineraryBookmark() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        response.setContentType("application/json; charset=UTF-8");

        response.setHeader("Cache-Control", "no-store");

        // 로그인 확인
        HttpSession session = request.getSession(false);
        
        ItineraryService service = new ItineraryServiceImpl();

        UserDto loginUser = session == null ? null : (UserDto) session.getAttribute("user");

        if (loginUser == null) {
            writeFailure(response,HttpServletResponse.SC_UNAUTHORIZED,"로그인 후 이용할 수 있습니다.");
            return;
        }

        try {
            String value = request.getParameter("itineraryId");

            if (value == null || value.trim().isEmpty()) {
                writeFailure(response,HttpServletResponse.SC_BAD_REQUEST,"일정 번호가 필요합니다.");
                return;
            }

            Long itineraryId = Long.valueOf(value.trim());

            // 회원 번호는 요청값 대신 세션에서 사용
            boolean bookmarked = service.toggleBookmark(itineraryId,loginUser.getUserId());

            Map<String, Object> result = new HashMap<>();

            result.put("success", true);
            result.put("bookmarked", bookmarked);

            response.getWriter().write(gson.toJson(result));

        } catch (NumberFormatException e) {
            writeFailure(response,HttpServletResponse.SC_BAD_REQUEST,"일정 번호는 올바른 숫자여야 합니다.");

        } catch (SecurityException e) {
            // 본인 일정 또는 비공개 일정 등
            writeFailure(response,HttpServletResponse.SC_FORBIDDEN,e.getMessage());

        } catch (IllegalArgumentException e) {
            writeFailure(response,HttpServletResponse.SC_BAD_REQUEST,e.getMessage());

        } catch (Exception e) {
            getServletContext().log("북마크 처리 중 오류 발생",e);

            writeFailure(response,HttpServletResponse.SC_INTERNAL_SERVER_ERROR,"북마크 처리 중 오류가 발생했습니다.");
        }
    }
	
	private void writeFailure(HttpServletResponse response,int status,String message) throws IOException {
        response.setStatus(status);
        Map<String, Object> result = new HashMap<>();
        result.put("success", false);
        result.put("message", message);
        response.getWriter().write(gson.toJson(result));
    }
}
