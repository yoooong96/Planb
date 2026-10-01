<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage", "profile");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>고객지원 · Tripily</title><jsp:include page="/common/headStyles.jsp" /><link
	rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/support/support.css">
</head>
<body class="site-shell"><jsp:include page="/common/header.jsp" /><div
		class="settings-page">
		<div class="settings-shell">
			<aside class="settings-sidebar">
				<div class="settings-sidebar-head">
					<a class="back-icon"
						href="${pageContext.request.contextPath}/view/profile/myProfile.jsp">‹</a>
					<div>
						<span>MY PAGE</span>
						<h2>설정</h2>
					</div>
				</div>
				<nav>
					<a class=""
						href="${pageContext.request.contextPath}/view/settings/profileEdit.jsp">◯<span>프로필
							편집</span></a><a class=""
						href="${pageContext.request.contextPath}/view/settings/passwordChange.jsp">▣<span>비밀번호
							변경</span></a><a class=""
						href="${pageContext.request.contextPath}/view/settings/notificationSettings.jsp">♢<span>알림
							설정</span></a><a class=""
						href="${pageContext.request.contextPath}/view/settings/privacySettings.jsp">▤<span>개인정보
							및 공개범위</span></a><a class=""
						href="${pageContext.request.contextPath}/view/settings/securityActivity.jsp">⚙<span>보안
							및 로그인 활동</span></a><a class="active"
						href="${pageContext.request.contextPath}/view/support/support.jsp">▧<span>고객지원</span></a>
				</nav>
				<div class="settings-sidebar-bottom">
					<a href="${pageContext.request.contextPath}/view/auth/login.jsp">↪<span>로그아웃</span></a><a
						class="danger"
						href="${pageContext.request.contextPath}/view/auth/withdraw.jsp">♜<span>회원
							탈퇴</span></a>
				</div>
			</aside>
			<main class="settings-main">
				<div class="settings-content">
					<header class="settings-title">
						<span class="settings-eyebrow">SETTINGS</span>
						<h1>고객지원</h1>
						<p>Tripily 이용 중 필요한 도움을 빠르게 찾아보세요.</p>
					</header>
					<section class="support-entry-grid">
						<a class="support-entry-card"
							href="${pageContext.request.contextPath}/view/support/faq.jsp"><span
							class="support-entry-icon">▧</span><span><strong>자주
									묻는 질문</strong><small>계정, 프로필, 게시글 관련 안내를 확인합니다.</small></span><span>›</span></a><a
							class="support-entry-card"
							href="${pageContext.request.contextPath}/view/support/inquiry.jsp"><span
							class="support-entry-icon">◯</span><span><strong>문의하기</strong><small>문의
									유형과 내용을 작성해 접수하는 화면입니다.</small></span><span>›</span></a>
					</section>
					<section class="settings-panel support-links support-legal-links">
						<a
							href="${pageContext.request.contextPath}/view/support/adInquiry.jsp"><span
							style="display: inline-flex; align-items: center; gap: 8px">📣
								광고 문의하기</span><span>›</span></a>
						<button type="button">
							이용약관 <span>›</span>
						</button>
						<button type="button">
							개인정보처리방침 <span>›</span>
						</button>
					</section>
				</div>
			</main>
		</div>
	</div><jsp:include page="/common/footer.jsp" /></body>
</html>