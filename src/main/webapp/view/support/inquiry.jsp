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
<title>문의하기 | Tripily</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body><jsp:include page="/common/header.jsp" /><main
		class="page narrow">
		<div class="page-title-row">
			<div>
				<span class="eyebrow">CONTACT</span>
				<h1>문의하기</h1>
				<p class="page-desc">문의 내용을 남겨주시면 확인 후 답변드립니다.</p>
			</div>
			<a class="btn outline" href="support.jsp">← 고객지원</a>
		</div>
		<form class="form-card"
			onsubmit="return tripilyDemoSubmit(event,'문의가 접수되는 Controller 연결 위치입니다.');">
			<div class="field">
				<label>문의 유형 <span class="required">필수</span></label><select
					required><option>서비스 이용</option>
					<option>계정/로그인</option>
					<option>신고/안전</option>
					<option>기타</option></select>
			</div>
			<div class="field">
				<label>답변 받을 이메일 <span class="required">필수</span></label><input
					type="email" required>
			</div>
			<div class="field">
				<label>제목 <span class="required">필수</span></label><input required>
			</div>
			<div class="field">
				<label>문의 내용 <span class="required">필수</span></label>
				<textarea required></textarea>
			</div>
			<div class="form-actions">
				<a class="btn outline" href="support.jsp">취소</a>
				<button class="btn primary">문의 접수</button>
			</div>
		</form>
	</main><jsp:include page="/common/footer.jsp" /></body>
</html>