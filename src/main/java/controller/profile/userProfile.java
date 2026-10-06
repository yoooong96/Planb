package controller.profile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.member.UserDto;
import dto.profile.ProfileFeedDto;

import service.member.UserService;
import service.member.UserServiceImpl;

import service.profile.ProfileFeedService;
import service.profile.ProfileFeedServiceImpl;

@WebServlet("/profile/userProfile")
public class userProfile extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/*
	 * ========================================================= Service
	 * =========================================================
	 */

	private UserService userService = new UserServiceImpl();

	private ProfileFeedService profileFeedService = new ProfileFeedServiceImpl();

	/*
	 * ========================================================= 생성자
	 * =========================================================
	 */

	public userProfile() {

		super();
	}

	/*
	 * ========================================================= GET
	 *
	 * 예: /profile/userProfile?userId=3
	 * =========================================================
	 */

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {

			/*
			 * ================================================= 1. URL에서 조회할 회원번호 받기
			 * =================================================
			 */

			String userIdParam = request.getParameter("userId");

			/*
			 * userId 자체가 없는 경우
			 */
			if (userIdParam == null || userIdParam.trim().isEmpty()) {

				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "회원 번호가 없습니다.");

				return;
			}

			/*
			 * ================================================= 2. String -> long
			 * =================================================
			 */

			long targetUserId = Long.parseLong(userIdParam);

			/*
			 * ================================================= 3. 상대방 회원 정보 조회
			 * =================================================
			 */

			UserDto targetUser = userService.getUserById(targetUserId);

			/*
			 * 존재하지 않는 회원
			 */
			if (targetUser == null) {

				response.sendError(HttpServletResponse.SC_NOT_FOUND, "존재하지 않는 회원입니다.");

				return;
			}

			/*
			 * ================================================= 4. 상대방이 작성한 PUBLIC 일정 조회
			 * =================================================
			 */

			List<ProfileFeedDto> itineraries = profileFeedService.getPublicItineraries(targetUserId);

			if (itineraries == null) {

				itineraries = new ArrayList<ProfileFeedDto>();
			}

			/*
			 * ================================================= 5. 좋아요 / 북마크 공개 설정
			 * =================================================
			 *
			 * UserDto에 boolean으로 되어 있다는 기준
			 */

			boolean showLikedItinerary = targetUser.getShowLikedItinerary();

			boolean showBookmarkedItinerary = targetUser.getShowBookmarkedItinerary();

			/*
			 * ================================================= 6. 좋아요한 PUBLIC 일정
			 * =================================================
			 */

			List<ProfileFeedDto> likedItineraries = new ArrayList<ProfileFeedDto>();

			if (showLikedItinerary) {

				likedItineraries = profileFeedService.getPublicLikedItineraries(targetUserId);

				if (likedItineraries == null) {

					likedItineraries = new ArrayList<ProfileFeedDto>();
				}
			}

			/*
			 * ================================================= 7. 북마크한 PUBLIC 일정
			 * =================================================
			 */

			List<ProfileFeedDto> bookmarkedItineraries = new ArrayList<ProfileFeedDto>();

			if (showBookmarkedItinerary) {

				bookmarkedItineraries = profileFeedService.getPublicBookmarkedItineraries(targetUserId);

				if (bookmarkedItineraries == null) {

					bookmarkedItineraries = new ArrayList<ProfileFeedDto>();
				}
			}

			/*
			 * ================================================= 8. 게시물 수
			 * =================================================
			 */

			int postCount = itineraries.size();

			/*
			 * ================================================= 9. 받은 좋아요 총합
			 *
			 * 각 공개 일정의 likeCount를 모두 합침 =================================================
			 */

			int likeCount = 0;

			for (ProfileFeedDto item : itineraries) {

				likeCount += item.getLikeCount();
			}

			/*
			 * ================================================= 10. 받은 북마크 총합
			 *
			 * 각 공개 일정의 bookmarkCount를 모두 합침
			 * =================================================
			 */

			int bookmarkCount = 0;

			for (ProfileFeedDto item : itineraries) {

				bookmarkCount += item.getBookmarkCount();
			}

			/*
			 * ================================================= 11. JSP에 데이터 전달
			 * =================================================
			 */

			// 상대방 회원정보
			request.setAttribute("targetUser", targetUser);

			// 상대방 작성 공개 일정
			request.setAttribute("itineraries", itineraries);

			// 상대방이 좋아요한 공개 일정
			request.setAttribute("likedItineraries", likedItineraries);

			// 상대방이 북마크한 공개 일정
			request.setAttribute("bookmarkedItineraries", bookmarkedItineraries);

			/*
			 * 좋아요 / 북마크 공개 여부
			 */

			request.setAttribute("showLikedItinerary", showLikedItinerary);

			request.setAttribute("showBookmarkedItinerary", showBookmarkedItinerary);

			/*
			 * 프로필 상단 통계
			 */

			request.setAttribute("postCount", postCount);

			request.setAttribute("likeCount", likeCount);

			request.setAttribute("bookmarkCount", bookmarkCount);

			/*
			 * ================================================= 12. userProfile.jsp로 이동
			 * =================================================
			 */

			request.getRequestDispatcher("/view/profile/userProfile.jsp").forward(request, response);

			/*
			 * userId=abc 같은 잘못된 값이 들어온 경우
			 */
		} catch (NumberFormatException e) {

			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 회원 번호입니다.");

			/*
			 * DB / Service 등의 오류
			 */
		} catch (Exception e) {

			e.printStackTrace();

			throw new ServletException("사용자 프로필 조회 중 오류가 발생했습니다.", e);
		}
	}
}