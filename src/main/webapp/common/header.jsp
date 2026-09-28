<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String ctx = request.getContextPath();
String activePage = String.valueOf(request.getAttribute("activePage"));
boolean homeHeader = "home".equals(activePage);
boolean forceAdmin = Boolean.TRUE.equals(request.getAttribute("forceAdminHeader"));
String role = session.getAttribute("role") == null ? "" : String.valueOf(session.getAttribute("role"));
if(request.getParameter("role") != null) role = request.getParameter("role");
boolean isAdminHeader = forceAdmin || "ADMIN".equalsIgnoreCase(role);
boolean loggedIn = isAdminHeader || session.getAttribute("loginUser") != null || session.getAttribute("userId") != null;
String nickname = isAdminHeader ? "관리자" : (session.getAttribute("nickname") == null ? "여행자" : String.valueOf(session.getAttribute("nickname")));
if(nickname == null || nickname.trim().isEmpty()) nickname = "여행자";
%>
<header class="site-header">
  <div class="header-inner <%=homeHeader?"home":""%>">
    <a class="brand" href="<%=ctx%>/home/home.jsp">
      <span class="brand-mark">⌖</span><span class="brand-copy"><b>Tripily</b><small>TRAVEL PLAN SHARE</small></span>
    </a>
    <nav class="main-nav">
      <a class="nav-link <%="travel".equals(activePage)?"active":""%>" href="<%=ctx%>/travel/scheduleList.jsp">여행일정</a>
      <a class="nav-link <%="planner".equals(activePage)?"active":""%>" href="<%=ctx%>/itinerary/planner.jsp">일정 만들기</a>
      <a class="nav-link <%="tips".equals(activePage)?"active":""%>" href="<%=ctx%>/tips/tipList.jsp">여행꿀팁</a>
      <a class="nav-link <%="mate".equals(activePage)?"active":""%>" href="<%=ctx%>/mate/mateList.jsp">여행 메이트</a>
    </nav>
    <% if(!homeHeader){ %><form class="header-search" action="<%=ctx%>/search/searchResult.jsp"><span>⌕</span><input name="q" placeholder="여행지, 일정, 키워드로 검색"/></form><% } else { %><span></span><% } %>
    <div class="header-actions">
      <% if(isAdminHeader){ %>
        <!-- 요청사항: 광고 관리 버튼이 신고 관리 버튼 왼쪽 -->
        <a class="admin-head-btn ads" href="<%=ctx%>/admin/ads/adminAds.jsp" title="광고 관리">▣ <span>광고 관리</span></a>
        <span class="badge-wrap"><a class="admin-head-btn reports" href="<%=ctx%>/admin/reports/adminReports.jsp" title="신고 관리">⚑ <span>신고 관리</span></a><i class="count-dot">3</i></span>
      <% } %>
      <span class="badge-wrap"><a class="icon-btn" href="<%=ctx%>/notification/notifications.jsp" title="알림">♧</a><% if(loggedIn){ %><i class="count-dot">2</i><% } %></span>
      <a class="icon-btn" href="<%=ctx%>/travel/scheduleList.jsp?view=cart" title="일정 장바구니">⌑</a>
      <% if(loggedIn){ %><a class="profile-btn" href="<%=ctx%>/profile/myProfile.jsp"><span class="avatar-mini"><%=nickname.substring(0,1)%></span><span class="profile-label"><%=nickname%></span></a>
      <% } else { %><a class="auth-btn outline" href="<%=ctx%>/auth/login.jsp">로그인</a><a class="auth-btn fill" href="<%=ctx%>/auth/signup.jsp">회원가입</a><% } %>
    </div>
  </div>
</header>