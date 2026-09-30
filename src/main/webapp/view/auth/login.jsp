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

    <title>로그인 · Planb</title>

    <jsp:include page="/common/headStyles.jsp" />

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/view/assets/css/auth/login.css">
</head>

<body class="site-shell">

<jsp:include page="/common/header.jsp" />


<main class="login-main">

    <div class="login-container">


        <!-- =========================
             상단
        ========================== -->
        <div class="login-header">

            <a href="${pageContext.request.contextPath}/view/home/home.jsp"
               class="login-logo">

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

                <span class="login-logo-text">
                    Planb
                </span>

            </a>


            <h1>로그인</h1>

            <p>
                여행 일정을 공유하고 메이트를 찾아보세요.
            </p>

        </div>


        <!-- =========================
             로그인 카드
        ========================== -->
        <div class="login-card">

            <form
                id="loginForm"
                action="${pageContext.request.contextPath}/auth/login"
                method="post"
                novalidate>


                <!-- 아이디 -->
                <div class="form-group">

                    <label for="loginId">
                        아이디
                    </label>

                    <input
                        type="text"
                        id="loginId"
                        name="loginId"
                        maxlength="50"
                        placeholder="아이디를 입력하세요"
                        autocomplete="username"
                        required>

                    <p class="field-error"
                       data-error-for="loginId"></p>

                </div>


                <!-- 비밀번호 -->
                <div class="form-group">

                    <label for="password">
                        비밀번호
                    </label>

                    <div class="password-wrap">

                        <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="비밀번호를 입력하세요"
                            autocomplete="current-password"
                            required>

                        <button
                            type="button"
                            id="passwordToggle"
                            class="password-toggle"
                            aria-label="비밀번호 보기">

                            보기

                        </button>

                    </div>

                    <p class="field-error"
                       data-error-for="password"></p>

                </div>


                <!-- 아이디 기억 + 비밀번호 찾기 -->
                <div class="login-options">

                    <label class="remember-login">

                        <input
                            type="checkbox"
                            name="rememberLogin"
                            id="rememberLogin">

                        <span>아이디 저장</span>

                    </label>


                    <a href="${pageContext.request.contextPath}/view/auth/findPassword.jsp"
                       class="find-password">

                        비밀번호 찾기

                    </a>

                </div>


                <!-- 전체 에러 -->
                <div
                    id="loginError"
                    class="login-error-box"
                    hidden>

                    아이디와 비밀번호를 확인해주세요.

                </div>


                <!-- 로그인 버튼 -->
                <button
                    type="submit"
                    class="login-submit">

                    로그인

                </button>

            </form>


            <!-- 구분선 -->
            <div class="login-divider">

                <div></div>

                <span>또는</span>

                <div></div>

            </div>


            <!-- 회원가입 -->
            <p class="signup-link">

                아직 회원이 아니신가요?

                <a href="${pageContext.request.contextPath}/view/auth/signup.jsp">
                    회원가입
                </a>

            </p>

        </div>


        <!-- 하단 약관 -->
        <p class="login-policy">

            로그인 시

            <a href="#">
                이용약관
            </a>

            및

            <a href="#">
                개인정보처리방침
            </a>

            에 동의하는 것으로 간주합니다.

        </p>

    </div>

</main>


<jsp:include page="/common/footer.jsp" />


<script
    src="${pageContext.request.contextPath}/view/assets/js/auth/login.js">
</script>

</body>
</html>