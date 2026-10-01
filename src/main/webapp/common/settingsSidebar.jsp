<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%
String ctx = request.getContextPath();

String settingsPage =
    request.getAttribute("settingsPage") == null
        ? ""
        : String.valueOf(
            request.getAttribute("settingsPage")
        );
%>

<aside class="settings-sidebar">

    <div class="settings-sidebar-head">

        <a class="settings-back"
           href="<%=ctx%>/view/profile/myProfile.jsp"
           aria-label="내 프로필로 돌아가기">

            ‹

        </a>

        <div>

            <span>
                MY PAGE
            </span>

            <h2>
                설정
            </h2>

        </div>

    </div>


    <nav>

        <!-- 프로필 설정 -->
        <a
            class="settings-nav-link
            <%="profile".equals(settingsPage) ? "active" : ""%>"
            href="<%=ctx%>/view/settings/settings.jsp">

            <span class="settings-nav-icon">
                ◯
            </span>

            <span>
                프로필 설정
            </span>

        </a>


        <!-- 비밀번호 -->
        <a
            class="settings-nav-link
            <%="password".equals(settingsPage) ? "active" : ""%>"
            href="<%=ctx%>/view/settings/passwordChange.jsp">

            <span class="settings-nav-icon">
                ▣
            </span>

            <span>
                비밀번호 변경
            </span>

        </a>


        <!-- 알림 -->
        <a
            class="settings-nav-link
            <%="notification".equals(settingsPage) ? "active" : ""%>"
            href="<%=ctx%>/view/settings/notificationSettings.jsp">

            <span class="settings-nav-icon">
                ♢
            </span>

            <span>
                알림 설정
            </span>

        </a>


        <!-- 개인정보 -->
        <a
            class="settings-nav-link
            <%="privacy".equals(settingsPage) ? "active" : ""%>"
            href="<%=ctx%>/view/settings/privacySettings.jsp">

            <span class="settings-nav-icon">
                ▤
            </span>

            <span>
                개인정보 및 공개범위
            </span>

        </a>


        <!-- 보안 -->
        <a
            class="settings-nav-link
            <%="security".equals(settingsPage) ? "active" : ""%>"
            href="<%=ctx%>/view/settings/securityActivity.jsp">

            <span class="settings-nav-icon">
                ⚙
            </span>

            <span>
                보안 및 로그인 활동
            </span>

        </a>


        <!-- 고객지원 -->
        <a
            class="settings-nav-link
            <%="support".equals(settingsPage) ? "active" : ""%>"
            href="<%=ctx%>/view/support/support.jsp">

            <span class="settings-nav-icon">
                ?
            </span>

            <span>
                고객지원
            </span>

        </a>

    </nav>


    <div class="settings-sidebar-bottom">

        <!-- 로그아웃 -->
        <a href="<%=ctx%>/auth/logout">

            <span class="settings-nav-icon">
                ↪
            </span>

            <span>
                로그아웃
            </span>

        </a>


        <!-- 회원 탈퇴 -->
        <a
            class="danger"
            href="<%=ctx%>/view/auth/withdraw.jsp">

            <span class="settings-nav-icon">
                ×
            </span>

            <span>
                회원 탈퇴
            </span>

        </a>

    </div>

</aside>