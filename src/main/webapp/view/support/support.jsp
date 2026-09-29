<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage", "settings");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>고객지원 | Tripily</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body><jsp:include page="/common/header.jsp" /><main
		class="page narrow">
		<div class="page-title-row">
			<div>
				<span class="eyebrow">SUPPORT</span>
				<h1>고객지원</h1>
				<p class="page-desc">궁금한 점과 서비스 이용 문의를 도와드립니다.</p>
			</div>
		</div>
		<div class="settings-cards">
			<a class="setting-card" href="faq.jsp"><h3>자주 묻는 질문</h3>
				<p>회원가입, 일정 작성, 커뮤니티 등 자주 묻는 내용을 확인합니다.</p>
				<span class="pill brand">FAQ →</span></a><a class="setting-card"
				href="inquiry.jsp"><h3>문의하기</h3>
				<p>서비스 이용 중 발생한 문제나 의견을 보내주세요.</p>
				<span class="pill brand">문의 작성 →</span></a><a class="setting-card"
				href="adInquiry.jsp"
				style="grid-column: 1/-1; border-color: #dcdcff; background: #fafaff"><h3>광고
					문의하기</h3>
				<p>Tripily 내 광고 게재를 원하는 업체/담당자는 광고 정보와 이미지를 함께 제출할 수 있습니다.</p>
				<span class="pill yellow">광고 신청 →</span></a>
		</div>
	</main><jsp:include page="/common/footer.jsp" /></body>
</html>