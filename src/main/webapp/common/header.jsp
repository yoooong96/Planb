<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String ctx = request.getContextPath();

String activePage = String.valueOf(request.getAttribute("activePage"));

boolean homeHeader = "home".equals(activePage);

boolean forceAdmin = Boolean.TRUE.equals(request.getAttribute("forceAdminHeader"));

String role = session.getAttribute("role") == null ? "" : String.valueOf(session.getAttribute("role"));

if (request.getParameter("role") != null) {
	role = request.getParameter("role");
}

boolean isAdminHeader = forceAdmin || "ADMIN".equalsIgnoreCase(role);

boolean loggedIn = isAdminHeader || session.getAttribute("loginUser") != null || session.getAttribute("userId") != null;

String nickname = isAdminHeader ? "관리자"
		: (session.getAttribute("nickname") == null ? "여행자" : String.valueOf(session.getAttribute("nickname")));

if (nickname == null || nickname.trim().isEmpty()) {
	nickname = "여행자";
}
%>


<header class="site-header">

	<div class="header-inner <%=homeHeader ? "home" : ""%>">

		<!-- =========================
             로고
        ========================== -->

		<a class="brand" href="<%=ctx%>/home"> <span class="brand-mark">
				⌖ </span> <span class="brand-copy"> <b>Tripily</b> <small>TRAVEL
					PLAN SHARE</small>
		</span>
		</a>


		<!-- =========================
             메인 메뉴
        ========================== -->

		<nav class="main-nav">

			<!-- 여행일정 -->
			<a class="nav-link <%="travel".equals(activePage) ? "active" : ""%>"
				href="<%=ctx%>/view/travel/scheduleList.jsp"> 여행일정 </a>


			<!-- 일정 만들기 -->
			<a class="nav-link <%="planner".equals(activePage) ? "active" : ""%>"
				href="<%=ctx%>/view/itinerary/planner.jsp"> 일정 만들기 </a>


			<!-- 여행꿀팁 -->
			<a class="nav-link <%="tips".equals(activePage) ? "active" : ""%>"
				href="<%=ctx%>/view/tips/tipList.jsp"> 여행꿀팁 </a>


			<!-- 여행 메이트 -->
			<a class="nav-link <%="mate".equals(activePage) ? "active" : ""%>"
				href="<%=ctx%>/view/mate/mateList.jsp"> 여행 메이트 </a>

		</nav>


		<!-- =========================
             검색창
             홈에서는 숨김
        ========================== -->

		<%
		if (!homeHeader) {
		%>

		<form class="header-search"
			action="<%=ctx%>/view/search/searchResult.jsp" method="get">

			<span>⌕</span> <input type="text" name="q"
				placeholder="여행지, 일정, 키워드로 검색">

		</form>

		<%
		} else {
		%>

		<span></span>

		<%
		}
		%>


		<!-- =========================
             우측 메뉴
        ========================== -->

		<div class="header-actions">


			<!-- 관리자 메뉴 -->
			<%
			if (isAdminHeader) {
			%>

			<!-- 광고 관리 -->
			<a class="admin-head-btn ads"
				href="<%=ctx%>/view/admin/ads/adminAds.jsp" title="광고 관리"> ▣ <span>광고
					관리</span>
			</a>


			<!-- 신고 관리 -->
			<span class="badge-wrap"> <a class="admin-head-btn reports"
				href="<%=ctx%>/view/admin/reports/adminReports.jsp" title="신고 관리">
					⚑ <span>신고 관리</span>
			</a> <i class="count-dot"> 3 </i>

			</span>

			<%
			}
			%>


			<!-- 알림 -->
			<span class="badge-wrap"> <a class="icon-btn"
				href="<%=ctx%>/view/notification/notifications.jsp" title="알림">
					♧ </a> <%
 if (loggedIn) {
 %> <i class="count-dot"> 2 </i> <%
 }
 %>

			</span>


			<!-- 일정 장바구니 -->
			<a class="icon-btn"
				href="<%=ctx%>/view/travel/scheduleList.jsp?view=cart"
				title="일정 장바구니"> ⌑ </a>


			<!-- =====================
                 로그인 상태
            ====================== -->

			<%
			if (loggedIn) {
			%>

			<a class="profile-btn" href="<%=ctx%>/view/profile/myProfile.jsp">

				<span class="avatar-mini"> <%=nickname.substring(0, 1)%>
			</span> <span class="profile-label"> <%=nickname%>
			</span>

			</a>


			<!-- =====================
                 비로그인 상태
            ====================== -->

			<%
			} else {
			%>

			<a class="auth-btn outline" href="<%=ctx%>/view/auth/login.jsp">
				로그인 </a> <a class="auth-btn fill" href="<%=ctx%>/view/auth/signup.jsp">
				회원가입 </a>

			<%
			}
			%>

		</div>

	</div>

</header>