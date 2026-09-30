<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String ctx = request.getContextPath();
String activePage = String.valueOf(request.getAttribute("activePage"));
boolean homeHeader = "home".equals(activePage);
boolean forceAdmin = Boolean.TRUE.equals(request.getAttribute("forceAdminHeader"));
String role = session.getAttribute("role") == null ? "" : String.valueOf(session.getAttribute("role"));
if (request.getParameter("role") != null) role = request.getParameter("role");
boolean isAdminHeader = forceAdmin || "ADMIN".equalsIgnoreCase(role);
boolean loggedIn = isAdminHeader || session.getAttribute("loginUser") != null || session.getAttribute("userId") != null;
String nickname = isAdminHeader ? "관리자" : (session.getAttribute("nickname") == null ? "여행자" : String.valueOf(session.getAttribute("nickname")));
if (nickname == null || nickname.trim().isEmpty()) nickname = "여행자";
String avatar = session.getAttribute("avatar") == null ? "" : String.valueOf(session.getAttribute("avatar"));
String points = session.getAttribute("points") == null ? (isAdminHeader ? "0" : "3,250") : String.valueOf(session.getAttribute("points"));
%>
<header class="site-header<%=homeHeader ? " site-header--home" : ""%>">
  <div class="site-header-inner<%=homeHeader ? " site-header-inner--home" : ""%>">
    <a class="site-brand" href="<%=ctx%>/view/home/home.jsp" aria-label="Tripily 홈">
      <span class="tripily-mark" aria-hidden="true">
        <svg width="17" height="17" viewBox="0 0 24 24" fill="none">
          <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7Z" fill="currentColor"/>
          <circle cx="12" cy="9" r="2.6" fill="white"/>
        </svg>
      </span>
      <span class="site-brand-copy"><strong>Planb</strong><small>Travel Plan Share</small></span>
    </a>

    <nav class="site-nav<%=homeHeader ? " site-nav--pill" : ""%>" aria-label="주요 메뉴">
      <a class="<%=homeHeader ? "site-nav-pill" : "site-nav-link"%> <%="travel".equals(activePage) ? "active" : ""%>" href="<%=ctx%>/view/travel/scheduleList.jsp">여행일정</a>
      <a class="<%=homeHeader ? "site-nav-pill" : "site-nav-link"%> <%="planner".equals(activePage) ? "active" : ""%>" href="<%=ctx%>/view/itinerary/planner.jsp">일정 만들기</a>
      <a class="<%=homeHeader ? "site-nav-pill" : "site-nav-link"%> <%="tips".equals(activePage) ? "active" : ""%>" href="<%=ctx%>/view/tips/tipList.jsp">여행꿀팁</a>
      <a class="<%=homeHeader ? "site-nav-pill" : "site-nav-link"%> <%="mate".equals(activePage) ? "active" : ""%>" href="<%=ctx%>/view/mate/mateList.jsp">여행 메이트</a>
    </nav>

    <% if (!homeHeader) { %>
    <form class="site-header-search-bar" action="<%=ctx%>/view/search/searchResult.jsp" method="get">
      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="11" cy="11" r="7"/><path d="m20 20-3.4-3.4"/></svg>
      <input name="q" placeholder="여행지, 일정, 키워드로 검색해보세요." aria-label="전체 검색"/>
    </form>
    <% } %>

    <div class="site-actions">
      <% if (isAdminHeader) { %>
      <span class="site-badge-wrap">
        <a class="site-icon-btn site-admin-direct-btn <%="reports".equals(activePage) ? "active" : ""%>" href="<%=ctx%>/view/admin/reports/adminReports.jsp" title="신고 관리" aria-label="신고 관리">
          <svg width="19" height="19" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
            <line x1="12" y1="2" x2="12" y2="3.5"/><line x1="7.5" y1="3.8" x2="8.3" y2="5"/><line x1="16.5" y1="3.8" x2="15.7" y2="5"/><line x1="5" y1="7.5" x2="6.3" y2="8"/><line x1="19" y1="7.5" x2="17.7" y2="8"/>
            <path d="M6 16C6 11.582 8.686 8 12 8C15.314 8 18 11.582 18 16"/><line x1="6" y1="16" x2="18" y2="16"/><rect x="7" y="17" width="10" height="2" rx="1"/><line x1="12" y1="19" x2="12" y2="20"/><line x1="9.5" y1="20" x2="14.5" y2="20"/>
          </svg>
        </a>
        <span class="site-report-dot" aria-label="새 신고 있음"></span>
      </span>
      <% } %>

      <div class="site-badge-wrap site-notification-wrap">
        <button type="button" class="site-icon-btn" data-notification-toggle title="알림" aria-label="알림" aria-expanded="false">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M18 8a6 6 0 10-12 0c0 7-3 7-3 9h18c0-2-3-2-3-9"/><path stroke-linecap="round" stroke-linejoin="round" d="M10 21h4"/></svg>
        </button>
        <% if (loggedIn) { %><span class="site-count-badge">2</span><% } %>
        <% if (loggedIn) { %>
        <div class="site-notification-popover" data-notification-popover hidden>
          <div class="site-notification-head"><strong>알림</strong><a href="<%=ctx%>/view/notification/notifications.jsp">전체 보기</a></div>
          <a class="site-notification-item unread" href="<%=ctx%>/view/notification/notifications.jsp"><span class="site-notification-symbol comment">💬</span><span><strong>새 댓글</strong><small>민지님이 내 게시글에 댓글을 남겼어요.</small></span></a>
          <a class="site-notification-item unread" href="<%=ctx%>/view/notification/notifications.jsp"><span class="site-notification-symbol like">♥</span><span><strong>새 좋아요</strong><small>도윤님이 내 여행 일정에 좋아요를 눌렀어요.</small></span></a>
        </div>
        <% } %>
      </div>

      <span class="site-badge-wrap">
        <a class="site-icon-btn" href="<%=ctx%>/view/travel/scheduleList.jsp?view=cart" title="일정 장바구니" aria-label="일정 장바구니">
          <svg width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13 5.4 5M7 13l-2.3 2.3c-.6.6-.2 1.7.7 1.7H17m0 0a2 2 0 100 4 2 2 0 000-4Zm-8 2a2 2 0 11-4 0 2 2 0 014 0Z"/></svg>
        </a>
      </span>

      <% if (loggedIn) { %>
      <div class="site-point-pill" title="보유 포인트 <%=points%>P">
        <svg aria-hidden="true" width="17" height="17" viewBox="0 0 24 24" fill="none"><circle cx="12" cy="12" r="10" fill="#F5C518" stroke="#C99A00" stroke-width="1.5"/><circle cx="12" cy="12" r="7.5" fill="none" stroke="#C99A00" stroke-width="0.8" stroke-dasharray="1.5 1.5"/><text x="12" y="16.5" text-anchor="middle" font-size="10" font-weight="900" font-family="Arial,sans-serif" fill="#8A6A00">₩</text></svg>
        <span><%=points%>P</span>
      </div>
      <a class="site-profile-btn site-profile-btn--user<%=isAdminHeader ? " site-profile-btn--admin" : ""%>" href="<%=ctx%>/view/profile/myProfile.jsp" title="마이페이지">
        <span class="site-profile-avatar site-profile-avatar--img">
          <% if (!avatar.isEmpty()) { %><img src="<%=avatar%>" alt="<%=nickname%>"><% } else { %><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4.3 3.6-7 8-7s8 2.7 8 7"/></svg><% } %>
        </span><span class="site-profile-label"><%=nickname%></span>
      </a>
      <% } else { %>
      <div class="site-auth-actions">
        <a class="site-auth-btn site-auth-btn--outline" href="<%=ctx%>/view/auth/login.jsp">로그인</a>
        <a class="site-auth-btn site-auth-btn--fill" href="<%=ctx%>/view/auth/signup.jsp">회원가입</a>
      </div>
      <% } %>
    </div>
  </div>
</header>
