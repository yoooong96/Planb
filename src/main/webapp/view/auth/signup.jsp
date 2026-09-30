<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setAttribute("activePage", "auth");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>회원가입 · Planb</title>

    <jsp:include page="/common/headStyles.jsp" />

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/view/assets/css/signup.css">
</head>

<body class="site-shell">

<jsp:include page="/common/header.jsp" />

<main class="signup-main">

    <div class="signup-container">

        <!-- 상단 로고 -->
        <div class="signup-header">

            <a href="${pageContext.request.contextPath}/view/home/home.jsp"
               class="signup-logo">

                <span class="tripily-mark" aria-hidden="true">
                    <svg width="22"
                         height="22"
                         viewBox="0 0 24 24"
                         fill="none">

                        <path
                            d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7Z"
                            fill="var(--brand)" />

                        <circle
                            cx="12"
                            cy="9"
                            r="2.6"
                            fill="white" />
                    </svg>
                </span>

                <span class="signup-logo-text">
                    Planb
                </span>
            </a>

            <h1>회원가입</h1>

            <p>
                Planb와 함께 특별한 여행을 시작하세요.
            </p>

        </div>


        <!-- 회원가입 카드 -->
        <div class="signup-card">

            <form
                id="signupForm"
                action="${pageContext.request.contextPath}/auth/signup"
                method="post"
                enctype="multipart/form-data"
                novalidate>


                <!-- ======================================= -->
                <!-- 필수 정보 -->
                <!-- ======================================= -->

                <section class="signup-section">

                    <div class="section-title-area">
                        <h2>기본 정보</h2>
                        <span class="required-guide">
                            <span class="required">*</span>
                            필수 입력
                        </span>
                    </div>


                    <!-- 로그인 아이디 -->
                    <div class="form-group">

                        <label for="loginId">
                            아이디
                            <span class="required">*</span>
                        </label>

                        <input
                            type="text"
                            id="loginId"
                            name="loginId"
                            maxlength="50"
                            placeholder="로그인 아이디를 입력하세요"
                            autocomplete="username"
                            required>

                        <p class="input-help">
                            영문, 숫자, 밑줄(_)을 사용하여 4~20자로 입력해주세요.
                        </p>

                        <p class="field-error"
                           data-error-for="loginId"></p>

                    </div>


                    <!-- 비밀번호 -->
                    <div class="form-group">

                        <label for="password">
                            비밀번호
                            <span class="required">*</span>
                        </label>

                        <input
                            type="password"
                            id="password"
                            name="password"
                            maxlength="100"
                            placeholder="8자 이상 입력하세요"
                            autocomplete="new-password"
                            required>

                        <p class="input-help">
                            영문과 숫자를 포함하여 8자 이상 입력해주세요.
                        </p>

                        <p class="field-error"
                           data-error-for="password"></p>

                    </div>


                    <!-- 비밀번호 확인 -->
                    <div class="form-group">

                        <label for="passwordConfirm">
                            비밀번호 확인
                            <span class="required">*</span>
                        </label>

                        <input
                            type="password"
                            id="passwordConfirm"
                            name="passwordConfirm"
                            maxlength="100"
                            placeholder="비밀번호를 한 번 더 입력하세요"
                            autocomplete="new-password"
                            required>

                        <p class="field-error"
                           data-error-for="passwordConfirm"></p>

                    </div>


                    <div class="form-row">

                        <!-- 이름 -->
                        <div class="form-group">

                            <label for="name">
                                이름
                                <span class="required">*</span>
                            </label>

                            <input
                                type="text"
                                id="name"
                                name="name"
                                maxlength="50"
                                placeholder="실명을 입력하세요"
                                autocomplete="name"
                                required>

                            <p class="field-error"
                               data-error-for="name"></p>

                        </div>


                        <!-- 닉네임 -->
                        <div class="form-group">

                            <label for="nickname">
                                닉네임
                                <span class="required">*</span>
                            </label>

                            <input
                                type="text"
                                id="nickname"
                                name="nickname"
                                maxlength="50"
                                placeholder="사용할 닉네임"
                                required>

                            <p class="field-error"
                               data-error-for="nickname"></p>

                        </div>

                    </div>


                    <!-- 이메일 -->
                    <div class="form-group">

                        <label for="email">
                            이메일
                            <span class="required">*</span>
                        </label>

                        <input
                            type="email"
                            id="email"
                            name="email"
                            maxlength="100"
                            placeholder="example@email.com"
                            autocomplete="email"
                            required>

                        <p class="field-error"
                           data-error-for="email"></p>

                    </div>


                    <!-- 전화번호 -->
                    <div class="form-group">

                        <label for="phone">
                            전화번호
                            <span class="required">*</span>
                        </label>

                        <input
                            type="tel"
                            id="phone"
                            name="phone"
                            maxlength="13"
                            placeholder="010-1234-5678"
                            autocomplete="tel"
                            required>

                        <p class="field-error"
                           data-error-for="phone"></p>

                    </div>

                </section>


                <!-- ======================================= -->
                <!-- 주소 -->
                <!-- ======================================= -->

                <section class="signup-section">

                    <div class="section-title-area">
                        <h2>주소 정보</h2>
                    </div>


                    <!-- 우편번호 -->
                    <div class="form-group">

                        <label for="postcode">
                            우편번호
                            <span class="required">*</span>
                        </label>

                        <div class="postcode-row">

                            <input
                                type="text"
                                id="postcode"
                                name="postcode"
                                maxlength="100"
                                placeholder="우편번호"
                                required>

                            <button
                                type="button"
                                id="postcodeButton"
                                class="postcode-button">

                                주소 검색

                            </button>

                        </div>

                        <p class="field-error"
                           data-error-for="postcode"></p>

                    </div>


                    <!-- 기본 주소 -->
                    <div class="form-group">

                        <label for="address">
                            기본 주소
                            <span class="required">*</span>
                        </label>

                        <input
                            type="text"
                            id="address"
                            name="address"
                            maxlength="200"
                            placeholder="도로명 주소를 입력하세요"
                            required>

                        <p class="field-error"
                           data-error-for="address"></p>

                    </div>


                    <!-- 상세 주소 -->
                    <div class="form-group">

                        <label for="addressDetail">
                            상세 주소
                            <span class="optional">선택</span>
                        </label>

                        <input
                            type="text"
                            id="addressDetail"
                            name="addressDetail"
                            maxlength="200"
                            placeholder="동, 호수 등 상세 주소">

                    </div>

                </section>


                <!-- ======================================= -->
                <!-- 선택 정보 -->
                <!-- ======================================= -->

                <section class="signup-section optional-section">

                    <div class="section-title-area">
                        <div>
                            <h2>추가 정보</h2>
                            <p class="section-description">
                                선택사항이며 가입 후 마이페이지에서도 수정할 수 있습니다.
                            </p>
                        </div>
                    </div>


                    <div class="form-row">

                        <!-- 생년월일 -->
                        <div class="form-group">

                            <label for="birthDate">
                                생년월일
                                <span class="optional">선택</span>
                            </label>

                            <input
                                type="date"
                                id="birthDate"
                                name="birthDate">

                        </div>


                        <!-- 지역 -->
                        <div class="form-group">

                            <label for="region">
                                지역
                                <span class="optional">선택</span>
                            </label>

                            <input
                                type="text"
                                id="region"
                                name="region"
                                maxlength="100"
                                placeholder="예: 서울">

                        </div>

                    </div>


                    <!-- 프로필 이미지 -->
                    <div class="form-group">

                        <label for="profileImage">
                            프로필 이미지
                            <span class="optional">선택</span>
                        </label>

                        <div class="profile-upload">

                            <div class="profile-preview"
                                 id="profilePreview">

                                <span>사진</span>

                            </div>

                            <div class="profile-upload-info">

                                <input
                                    type="file"
                                    id="profileImage"
                                    name="profileImage"
                                    accept="image/jpeg,image/png,image/webp">

                                <p class="input-help">
                                    JPG, PNG, WEBP / 최대 5MB
                                </p>

                            </div>

                        </div>

                        <p class="field-error"
                           data-error-for="profileImage"></p>

                    </div>


                    <!-- 자기소개 -->
                    <div class="form-group">

                        <label for="bio">
                            소개글
                            <span class="optional">선택</span>
                        </label>

                        <textarea
                            id="bio"
                            name="bio"
                            maxlength="300"
                            rows="4"
                            placeholder="간단한 자기소개를 입력해주세요."></textarea>

                        <div class="textarea-bottom">

                            <span></span>

                            <span id="bioCounter">
                                0 / 300
                            </span>

                        </div>

                    </div>

                </section>


                <!-- 전체 에러 -->
                <div
                    id="signupError"
                    class="signup-error-box"
                    hidden>

                    입력 내용을 다시 확인해주세요.

                </div>


                <!-- 회원가입 버튼 -->
                <button
                    type="submit"
                    class="signup-submit">

                    회원가입

                </button>

            </form>


            <p class="login-link">

                이미 계정이 있으신가요?

                <a href="${pageContext.request.contextPath}/view/auth/login.jsp">
                    로그인
                </a>

            </p>

        </div>

    </div>

</main>


<jsp:include page="/common/footer.jsp" />


<!-- 카카오 우편번호 서비스 -->
<script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script
    src="${pageContext.request.contextPath}/view/assets/js/signup.js">
</script>

</body>
</html>