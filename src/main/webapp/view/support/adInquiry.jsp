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
<title>광고 문의하기 · Planb</title><jsp:include
	page="/common/headStyles.jsp" /><link rel="stylesheet"
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
						<h1>광고 문의하기</h1>
						<p>Planb 내 광고 및 제휴 상품에 대해 문의할 수 있습니다.</p>
					</header>
					<a class="support-back"
						href="${pageContext.request.contextPath}/view/support/support.jsp">‹
						고객지원</a>
					<section class="settings-panel"
						style="margin-bottom: 14px; padding: 16px 20px; background: #fbfbff">
						<strong style="font-size: 18px">📣 Planb 광고 문의</strong>
						<p style="margin-top: 6px; color: #72737d; font-size: 12px">여행
							서비스, 숙박, 교통, 브랜드 제휴 광고를 문의할 수 있습니다.</p>
					</section>
					<form>
						<section class="settings-panel settings-form-panel">
							<div class="settings-form">
								<label class="settings-field"><span
									class="settings-field-label">회사/브랜드명</span><input
									placeholder="회사 또는 브랜드명을 입력해주세요."></label><label
									class="settings-field"><span
									class="settings-field-label">담당자명</span><input
									placeholder="담당자 이름"></label><label class="settings-field"><span
									class="settings-field-label">연락 이메일</span><input type="email"
									placeholder="example@company.com"></label><label
									class="settings-field"><span
									class="settings-field-label">전화번호</span><input
									placeholder="01012345678"></label><label class="settings-field"><span
									class="settings-field-label">광고 희망 기간</span>
								<div
										style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px">
										<input type="date"><input type="date">
									</div></label><label class="settings-field"><span
									class="settings-field-label">문의 내용</span>
								<textarea rows="7" placeholder="희망 광고 영역, 예산, 일정 등을 작성해주세요."></textarea></label>
							</div>
						</section>
						<div class="settings-actions support-form-actions">
							<a class="btn-soft"
								href="${pageContext.request.contextPath}/view/support/support.jsp">취소</a>
							<button class="btn-primary">광고 문의 접수</button>
						</div>
					</form>
				</div>
			</main>
		</div>
	</div><jsp:include page="/common/footer.jsp" /></body>
</html>