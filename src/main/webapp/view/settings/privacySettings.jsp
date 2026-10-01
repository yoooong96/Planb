<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="dto.member.UserDto" %>

<%
request.setAttribute("activePage", "profile");
request.setAttribute("settingsPage", "privacy");

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

<title>개인정보 및 공개범위 · Planb</title>

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
                        개인정보 및 공개범위
                    </h1>

                    <p>
                        프로필과 피드에 노출되는 정보를
                        항목별로 관리합니다.
                    </p>

                </header>


                <form method="post">


                    <!-- 프로필 공개 여부 -->
                    <section class="settings-panel">

                        <div class="panel-head">

                            <h3>
                                프로필 공개범위
                            </h3>

                            <p>
                                다른 사용자가 내 프로필을
                                볼 수 있는 범위를 선택합니다.
                            </p>

                        </div>


                        <div class="visibility-options">


                            <label class="visibility-option">

                                <input
                                    type="radio"
                                    name="profileVisibility"
                                    value="PUBLIC"
                                    checked>

                                <span>

                                    <strong>
                                        공개
                                    </strong>

                                    <small>
                                        다른 사용자가 내 프로필과
                                        공개 게시물을 볼 수 있습니다.
                                    </small>

                                </span>

                            </label>


                            <label class="visibility-option">

                                <input
                                    type="radio"
                                    name="profileVisibility"
                                    value="PRIVATE">

                                <span>

                                    <strong>
                                        비공개
                                    </strong>

                                    <small>
                                        내 프로필과 활동 정보의
                                        노출을 제한합니다.
                                    </small>

                                </span>

                            </label>


                        </div>

                    </section>


                    <!-- 좋아요/북마크 공개 설정 -->
                    <section class="settings-panel settings-list-panel">


                        <div class="toggle-row">

                            <div class="toggle-copy">

                                <strong>
                                    북마크한 게시글 공개
                                </strong>

                                <span>
                                    내 프로필의 북마크한 게시글 탭을
                                    다른 사용자에게 공개합니다.
                                </span>

                            </div>


                            <label class="switch">

                                <input
                                    type="checkbox"
                                    name="showBookmarkedItinerary"
                                    value="1"
                                    checked>

                                <span class="slider"></span>

                            </label>

                        </div>


                        <div class="toggle-row">

                            <div class="toggle-copy">

                                <strong>
                                    좋아요한 게시글 공개
                                </strong>

                                <span>
                                    내 프로필의 좋아요한 게시글 탭을
                                    다른 사용자에게 공개합니다.
                                </span>

                            </div>


                            <label class="switch">

                                <input
                                    type="checkbox"
                                    name="showLikedItinerary"
                                    value="1"
                                    checked>

                                <span class="slider"></span>

                            </label>

                        </div>


                    </section>


                    <p class="settings-footnote">

                        공개범위 설정은 TB_USER의
                        profile_visibility,
                        show_liked_itinerary,
                        show_bookmarked_itinerary 항목과
                        연결하면 됩니다.

                    </p>


                    <div class="settings-actions">

                        <button
                            class="settings-primary-btn"
                            type="button">

                            공개범위 저장

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
