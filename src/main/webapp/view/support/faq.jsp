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
<title>자주 묻는 질문 · Planb</title><jsp:include
	page="/common/headStyles.jsp" /><link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/support/support.css">
	<link rel="stylesheet"
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
						<h1>자주 묻는 질문</h1>
						<p>Planb 이용 중 자주 발생하는 질문을 확인해보세요.</p>
					</header>
					<a class="support-back"
						href="${pageContext.request.contextPath}/view/support/support.jsp">‹
						고객지원</a>
					<section class="settings-panel faq-list">
						<div class="faq-item open">
							<button type="button">
								<span>프로필 공개 범위는 어디서 바꾸나요?</span><span class="faq-symbol">−</span>
							</button>
							<p>설정 &gt; 개인정보 및 공개범위에서 계정 공개 여부와 북마크/좋아요 게시글 공개 여부를 각각 변경할
								수 있습니다.</p>
						</div>
						<div class="faq-item">
							<button type="button">
								<span>게시글에 표시되는 좋아요와 북마크 수는 무엇인가요?</span><span
									class="faq-symbol">+</span>
							</button>
							<p>프로필 상단의 수치는 내가 작성한 전체 게시글에 받은 좋아요와 북마크를 각각 합산한 값입니다.</p>
						</div>
						<div class="faq-item">
							<button type="button">
								<span>프로필 사진이나 소개를 수정하고 싶어요.</span><span class="faq-symbol">+</span>
							</button>
							<p>설정 &gt; 프로필 편집에서 정보를 수정할 수 있습니다.</p>
						</div>
					</section>
				</div>
			</main>
		</div>
	</div><jsp:include page="/common/footer.jsp" /></body>
</html>