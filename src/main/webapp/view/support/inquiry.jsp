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
<title>문의하기 · Planb</title><jsp:include page="/common/headStyles.jsp" /><link
	rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/support/support.css">
	<link
	rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/setting/settings.css">
</head>
<body class="site-shell"><jsp:include page="/common/header.jsp" /><div
		class="settings-page">
		<div class="settings-shell">
			<jsp:include page="/common/settingsSidebar.jsp" />			
			<main class="settings-main">
				<div class="settings-content">
					<header class="settings-title">
						<span class="settings-eyebrow">SETTINGS</span>
						<h1>문의하기</h1>
						<p>문의 내용을 남겨주시면 담당자가 확인할 수 있도록 구성한 화면입니다.</p>
					</header>
					<a class="support-back"
						href="${pageContext.request.contextPath}/view/support/support.jsp">‹
						고객지원</a>
					<form>
						<section class="settings-panel settings-form-panel">
							<div class="settings-form">
								<label class="settings-field"><span
									class="settings-field-label">문의 유형</span><select><option>계정/프로필</option>
										<option>여행 일정</option>
										<option>게시글/커뮤니티</option>
										<option>오류 신고</option>
										<option>기타</option></select></label><label class="settings-field"><span
									class="settings-field-label">답변 받을 이메일</span><input
									type="email" value="subin@example.com"></label><label
									class="settings-field"><span
									class="settings-field-label">문의 제목</span><input maxlength="60"
									placeholder="문의 제목을 입력해주세요."></label><label
									class="settings-field"><span
									class="settings-field-label">문의 내용</span>
								<textarea rows="7" placeholder="문의 내용을 자세히 작성해주세요."></textarea><small>개인정보나
										비밀번호 등 민감한 정보는 입력하지 마세요.</small></label>
							</div>
						</section>
						<div class="settings-actions support-form-actions">
							<a class="btn-soft"
								href="${pageContext.request.contextPath}/view/support/support.jsp">취소</a>
							<button type="submit" class="btn-primary">문의 접수</button>
						</div>
					</form>
				</div>
			</main>
		</div>
	</div><jsp:include page="/common/footer.jsp" /></body>
</html>