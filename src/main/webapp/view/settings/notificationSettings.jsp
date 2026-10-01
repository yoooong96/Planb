<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="dto.member.UserDto" %>

<%
request.setAttribute("activePage", "profile");
request.setAttribute("settingsPage", "notification");

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

<title>알림 설정 · Planb</title>

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
                        알림 설정
                    </h1>

                    <p>
                        필요한 활동 알림만 선택해서 받을 수 있습니다.
                    </p>

                </header>


                <!--
                    TB_USER
                    notify_like
                    notify_comment
                    notify_post
                    항목과 연결할 수 있도록 name을 지정했습니다.
                -->
                <form method="post">


                    <section class="settings-panel settings-list-panel">


                        <div class="toggle-row">

                            <div class="toggle-copy">

                                <strong>
                                    좋아요 알림
                                </strong>

                                <span>
                                    내 게시물에 좋아요가 등록되면 알려드립니다.
                                </span>

                            </div>


                            <label class="switch">

                                <input
                                    type="checkbox"
                                    name="notifyLike"
                                    value="1"
                                    checked>

                                <span class="slider"></span>

                            </label>

                        </div>


                        <div class="toggle-row">

                            <div class="toggle-copy">

                                <strong>
                                    댓글 알림
                                </strong>

                                <span>
                                    내 게시물에 새 댓글이 등록되면 알려드립니다.
                                </span>

                            </div>


                            <label class="switch">

                                <input
                                    type="checkbox"
                                    name="notifyComment"
                                    value="1"
                                    checked>

                                <span class="slider"></span>

                            </label>

                        </div>


                        <div class="toggle-row">

                            <div class="toggle-copy">

                                <strong>
                                    새 게시물 알림
                                </strong>

                                <span>
                                    새 여행 게시물 관련 알림을 받습니다.
                                </span>

                            </div>


                            <label class="switch">

                                <input
                                    type="checkbox"
                                    name="notifyPost"
                                    value="1"
                                    checked>

                                <span class="slider"></span>

                            </label>

                        </div>


                    </section>


                    <div class="settings-actions">

                        <button
                            class="settings-primary-btn"
                            type="button">

                            알림 설정 저장

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
