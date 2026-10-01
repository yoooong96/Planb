<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="dto.member.UserDto" %>

<%
request.setAttribute("activePage", "profile");
request.setAttribute("settingsPage", "withdraw");

String ctx = request.getContextPath();

UserDto user = (UserDto) session.getAttribute("user");

if (user == null) {
    response.sendRedirect(ctx + "/view/auth/login.jsp");
    return;
}

String errorMessage =
        (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원 탈퇴 · Tripily</title>

<jsp:include page="/common/headStyles.jsp" />
<link rel="stylesheet"
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
                    <span class="settings-eyebrow">ACCOUNT</span>
                    <h1>회원 탈퇴</h1>
                    <p>탈퇴 전 아래 내용을 확인해주세요.</p>
                </header>

                <form
                    id="withdrawForm"
                    action="<%=ctx%>/auth/withdraw"
                    method="post">

                    <section class="settings-panel settings-form-panel">

                        <div class="settings-form compact">

                            <div style="
                                padding:14px 16px;
                                margin-bottom:18px;
                                border:1px solid #f2c5ca;
                                border-radius:12px;
                                background:#fff7f8;
                                color:#9f3440;
                                font-size:11.5px;
                                line-height:1.7;
                            ">
                                계정을 탈퇴하면 작성한 일정, 게시글,
                                좋아요 및 북마크 등 계정에 연결된 데이터가
                                더 이상 정상적으로 이용되지 않을 수 있습니다.
                            </div>

                            <label class="settings-field">
                                <span class="settings-field-label">
                                    비밀번호 확인
                                </span>

                                <input
                                    type="password"
                                    name="password"
                                    placeholder="현재 비밀번호를 입력하세요"
                                    autocomplete="current-password"
                                    required>

                                <small>
                                    본인 확인을 위해 현재 비밀번호를 입력해주세요.
                                </small>
                            </label>

                            <% if (errorMessage != null
                                    && !errorMessage.trim().isEmpty()) { %>

                                <div style="
                                    margin:-4px 0 16px;
                                    padding:10px 12px;
                                    border-radius:9px;
                                    background:#fff2f3;
                                    color:#d6404d;
                                    font-size:11px;
                                    line-height:1.5;
                                ">
                                    <%=errorMessage%>
                                </div>

                            <% } %>

                            <label style="
                                display:flex;
                                align-items:flex-start;
                                gap:8px;
                                margin:4px 0 18px;
                                color:#62636b;
                                font-size:11.5px;
                                line-height:1.5;
                                cursor:pointer;
                            ">
                                <input
                                    type="checkbox"
                                    name="withdrawAgree"
                                    value="Y"
                                    required
                                    style="
                                        margin-top:2px;
                                        accent-color:#6369D1;
                                    ">

                                <span>
                                    위 내용을 확인했으며
                                    회원 탈퇴에 동의합니다.
                                </span>
                            </label>

                        </div>

                    </section>

                    <div class="settings-actions"
                         style="gap:8px;">

                        <a
                            class="settings-soft-btn"
                            href="<%=ctx%>/view/profile/myProfile.jsp"
                            style="
                                min-width:104px;
                                text-decoration:none;
                            ">
                            취소
                        </a>

                        <button
                            type="submit"
                            class="btn-danger"
                            style="
                                min-width:116px;
                                height:40px;
                                display:inline-flex;
                                align-items:center;
                                justify-content:center;
                                padding:0 15px;
                                border:1px solid #E5484D;
                                border-radius:10px;
                                background:#E5484D;
                                color:#fff;
                                font:inherit;
                                font-size:12px;
                                font-weight:700;
                                cursor:pointer;
                            "
                            onclick="return confirm('정말 회원 탈퇴를 진행하시겠습니까?');">
                            회원 탈퇴
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
