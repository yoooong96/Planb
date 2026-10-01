<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="dto.member.UserDto" %>

<%
request.setAttribute("activePage", "profile");
request.setAttribute("settingsPage", "password");

String ctx = request.getContextPath();

UserDto user =
        (UserDto) session.getAttribute("user");

if (user == null) {
    response.sendRedirect(ctx + "/view/auth/login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>비밀번호 변경 · Planb</title>

<jsp:include page="/common/headStyles.jsp" />

<link
    rel="stylesheet"
    href="<%=ctx%>/view/assets/css/setting/settings.css">

</head>


<body class="site-shell">

<jsp:include page="/common/header.jsp" />


<div class="settings-page">

    <div class="settings-shell">


        <jsp:include page="/common/settingsSidebar.jsp" />


        <main class="settings-main">

            <div class="settings-content">


                <header class="settings-title">

                    <span class="settings-eyebrow">
                        SETTINGS
                    </span>

                    <h1>
                        비밀번호 변경
                    </h1>

                    <p>
                        안전한 계정 사용을 위해
                        새로운 비밀번호를 설정하세요.
                    </p>

                </header>


                <!--
                    기능 구현 시 실제 Servlet URL을 action에 연결하세요.
                -->
                <form method="post">


                    <section class="settings-panel settings-form-panel">

                        <div class="settings-form">


                            <label class="settings-field">

                                <span class="settings-field-label">
                                    현재 비밀번호
                                </span>

                                <input
                                    type="password"
                                    name="currentPassword"
                                    autocomplete="current-password"
                                    placeholder="현재 비밀번호"
                                    required>

                            </label>


                            <label class="settings-field">

                                <span class="settings-field-label">
                                    새 비밀번호
                                </span>

                                <input
                                    type="password"
                                    name="newPassword"
                                    autocomplete="new-password"
                                    placeholder="새 비밀번호"
                                    required>

                                <small>
                                    영문, 숫자, 특수문자를 포함해
                                    8자 이상 입력해주세요.
                                </small>

                            </label>


                            <label class="settings-field">

                                <span class="settings-field-label">
                                    새 비밀번호 확인
                                </span>

                                <input
                                    type="password"
                                    name="confirmPassword"
                                    autocomplete="new-password"
                                    placeholder="새 비밀번호 다시 입력"
                                    required>

                            </label>


                        </div>

                    </section>


                    <div class="settings-actions">

                        <button
                            class="settings-primary-btn"
                            type="button">

                            비밀번호 변경

                        </button>

                    </div>


                </form>


            </div>

        </main>


    </div>

</div>


<jsp:include page="/common/footer.jsp" />

</body>
</html>
