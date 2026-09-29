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
<title>회원 탈퇴 · Tripily</title><jsp:include page="/common/headStyles.jsp" /><link
	rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/profile.css">
</head>
<body class="site-shell"><jsp:include page="/common/header.jsp" />
	<div class="settings-page">
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
					<a
						href="${pageContext.request.contextPath}/view/settings/profileEdit.jsp">◯<span>프로필
							편집</span></a><a
						href="${pageContext.request.contextPath}/view/settings/passwordChange.jsp">▣<span>비밀번호
							변경</span></a><a
						href="${pageContext.request.contextPath}/view/settings/notificationSettings.jsp">♢<span>알림
							설정</span></a><a
						href="${pageContext.request.contextPath}/view/settings/privacySettings.jsp">▤<span>개인정보
							및 공개범위</span></a><a
						href="${pageContext.request.contextPath}/view/settings/securityActivity.jsp">⚙<span>보안
							및 로그인 활동</span></a><a
						href="${pageContext.request.contextPath}/view/support/support.jsp">▧<span>고객지원</span></a>
				</nav>
				<div class="settings-sidebar-bottom">
					<a href="${pageContext.request.contextPath}/view/auth/login.jsp">↪<span>로그아웃</span></a><a
						class="danger active"
						href="${pageContext.request.contextPath}/view/auth/withdraw.jsp">♜<span>회원
							탈퇴</span></a>
				</div>
			</aside>
			<main class="settings-main">
				<div class="settings-content">
					<header class="settings-title">
						<span class="settings-eyebrow">ACCOUNT</span>
						<h1>회원 탈퇴</h1>
						<p>탈퇴 전 아래 내용을 확인해주세요.</p>
					</header>
					<section class="settings-panel settings-form-panel">
						<div class="settings-form compact">
							<div
								style="padding: 14px 16px; margin-bottom: 18px; border: 1px solid #f2c5ca; border-radius: 12px; background: #fff7f8; color: #9f3440; font-size: 11.5px; line-height: 1.7">계정을
								삭제하면 작성한 일정, 게시글, 좋아요 및 북마크 등 계정에 연결된 데이터가 삭제될 수 있습니다.</div>
							<label class="settings-field"><span
								class="settings-field-label">비밀번호 확인</span><input
								type="password" placeholder="현재 비밀번호를 입력하세요"><small>본인
									확인을 위해 현재 비밀번호를 입력해주세요.</small></label><label
								style="display: flex; align-items: center; gap: 8px; margin: 4px 0 18px; color: #62636b; font-size: 11.5px"><input
								type="checkbox"> 위 내용을 확인했으며 회원 탈퇴에 동의합니다.</label>
						</div>
					</section>
					<div class="settings-actions" style="gap: 8px">
						<a class="btn-soft"
							style="min-width: 104px; display: inline-flex; align-items: center; justify-content: center"
							href="${pageContext.request.contextPath}/view/profile/myProfile.jsp">취소</a>
						<button class="btn-danger" style="min-width: 116px"
							onclick="return confirm('정말 탈퇴하시겠습니까?')">회원 탈퇴</button>
					</div>
				</div>
			</main>
		</div>
	</div>
	<jsp:include page="/common/footer.jsp" /></body>
</html>
