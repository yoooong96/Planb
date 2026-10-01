<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="dto.member.UserDto" %>

<%
request.setAttribute("activePage", "profile");

/*
 * settingsSidebar.jsp에서 현재 메뉴를 활성화하기 위한 값
 */
request.setAttribute("settingsPage", "profile");

String ctx = request.getContextPath();

UserDto user =
        (UserDto) session.getAttribute("user");

if (user == null) {
    response.sendRedirect(ctx + "/view/auth/login.jsp");
    return;
}

String loginId =
        user.getLoginId() == null ? "" : user.getLoginId();

String nickname =
        user.getNickName() == null ? "" : user.getNickName();

String name =
        user.getName() == null ? "" : user.getName();

String email =
        user.getEmail() == null ? "" : user.getEmail();

String phone =
        user.getPhone() == null ? "" : user.getPhone();

String region =
        user.getRegion() == null ? "" : user.getRegion();

String postcode =
        user.getPostcode() == null ? "" : user.getPostcode();

String address =
        user.getAddress() == null ? "" : user.getAddress();

String addressDetail =
        user.getAddressDetail() == null ? "" : user.getAddressDetail();

String bio =
        user.getBio() == null ? "" : user.getBio();

String profileImg =
        user.getProfileImg() == null ? "" : user.getProfileImg();

String birthDate =
        user.getBirthDate() == null
            ? ""
            : user.getBirthDate().toString();

String profilePath =
        (String) application.getAttribute("profilePath");

if (profilePath == null || profilePath.trim().isEmpty()) {
    profilePath = "/profiles";
}
%>

<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>프로필 설정 · Planb</title>

<jsp:include page="/common/headStyles.jsp" />

<link
    rel="stylesheet"
    href="<%=ctx%>/view/assets/css/setting/settings.css">

</head>


<body class="site-shell">

<jsp:include page="/common/header.jsp" />


<div class="settings-page">

    <div class="settings-shell">


        <!-- 공통 설정 사이드바 -->
        <jsp:include page="/common/settingsSidebar.jsp" />


        <main class="settings-main">

            <div class="settings-content">


                <header class="settings-title">

                    <span class="settings-eyebrow">
                        SETTINGS
                    </span>

                    <h1>
                        프로필 설정
                    </h1>

                    <p>
                        회원 기본 정보와 프로필 정보를 관리합니다.
                    </p>

                </header>


                <!--
                    저장 기능 구현 시 action을 실제 Servlet URL로 설정하세요.
                    예: /member/settings/profile
                -->
                <form method="post"
                      enctype="multipart/form-data">


                    <!-- 프로필 사진 -->
                    <section class="settings-panel settings-profile-panel">

                        <div class="settings-profile-row">


                            <div class="settings-avatar">

                                <% if (!profileImg.isEmpty()) { %>

                                    <img
                                        src="<%=ctx%><%=profilePath%>/<%=profileImg%>"
                                        alt="<%=nickname%> 프로필 이미지">

                                <% } else { %>

                                    <svg width="28"
                                         height="28"
                                         viewBox="0 0 24 24"
                                         fill="none"
                                         stroke="currentColor"
                                         stroke-width="1.6">

                                        <circle
                                            cx="12"
                                            cy="8"
                                            r="4"/>

                                        <path
                                            d="M4 21c0-4.3 3.6-7 8-7s8 2.7 8 7"/>

                                    </svg>

                                <% } %>

                            </div>


                            <div class="settings-profile-copy">

                                <strong>
                                    <%=nickname%>
                                </strong>

                                <span>
                                    <%=name%>
                                </span>

                            </div>


                            <label class="settings-photo-label">

                                프로필 사진 변경

                                <input
                                    type="file"
                                    name="profileImage"
                                    accept="image/*">

                            </label>


                        </div>

                    </section>


                    <!-- 회원 정보 -->
                    <section class="settings-panel settings-form-panel">

                        <div class="settings-form settings-form-grid">


                            <label class="settings-field">

                                <span class="settings-field-label">
                                    로그인 아이디
                                </span>

                                <input
                                    type="text"
                                    value="<%=loginId%>"
                                    readonly>

                                <small>
                                    로그인 아이디는 이 화면에서 변경하지 않습니다.
                                </small>

                            </label>


                            <label class="settings-field">

                                <span class="settings-field-label">
                                    이름
                                </span>

                                <input
                                    type="text"
                                    name="name"
                                    maxlength="50"
                                    value="<%=name%>"
                                    required>

                            </label>


                            <label class="settings-field">

                                <span class="settings-field-label">
                                    닉네임
                                </span>

                                <input
                                    type="text"
                                    name="nickname"
                                    maxlength="50"
                                    value="<%=nickname%>"
                                    required>

                            </label>


                            <label class="settings-field">

                                <span class="settings-field-label">
                                    생년월일
                                </span>

                                <input
                                    type="date"
                                    name="birthDate"
                                    value="<%=birthDate%>">

                            </label>


                            <label class="settings-field">

                                <span class="settings-field-label">
                                    이메일
                                </span>

                                <input
                                    type="email"
                                    name="email"
                                    maxlength="100"
                                    value="<%=email%>"
                                    required>

                            </label>


                            <label class="settings-field">

                                <span class="settings-field-label">
                                    전화번호
                                </span>

                                <input
                                    type="tel"
                                    name="phone"
                                    maxlength="20"
                                    value="<%=phone%>"
                                    required>

                            </label>


                            <label class="settings-field">

                                <span class="settings-field-label">
                                    지역
                                </span>

                                <input
                                    type="text"
                                    name="region"
                                    maxlength="100"
                                    value="<%=region%>">

                            </label>


                            <label class="settings-field">

                                <span class="settings-field-label">
                                    우편번호
                                </span>

                                <input
                                    type="text"
                                    name="postcode"
                                    maxlength="100"
                                    value="<%=postcode%>"
                                    required>

                            </label>


                            <label class="settings-field full">

                                <span class="settings-field-label">
                                    주소
                                </span>

                                <input
                                    type="text"
                                    name="address"
                                    maxlength="200"
                                    value="<%=address%>"
                                    required>

                            </label>


                            <label class="settings-field full">

                                <span class="settings-field-label">
                                    상세주소
                                </span>

                                <input
                                    type="text"
                                    name="addressDetail"
                                    maxlength="200"
                                    value="<%=addressDetail%>">

                            </label>


                            <label class="settings-field full">

                                <span class="settings-field-label">
                                    소개
                                </span>

                                <textarea
                                    name="bio"
                                    rows="4"
                                    maxlength="300"><%=bio%></textarea>

                            </label>


                        </div>

                    </section>


                    <div class="settings-actions">

                        <!-- 저장 Servlet 연결 전에는 button으로 사용 -->
                        <button
                            class="settings-primary-btn"
                            type="button">

                            변경사항 저장

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
