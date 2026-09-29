<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage", "mate");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>메이트 글 작성 | Tripily</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body><jsp:include page="/common/header.jsp" /><main
		class="page narrow">
		<div class="page-title-row">
			<div>
				<span class="eyebrow">TRAVEL MATE</span>
				<h1>메이트 모집글 작성</h1>
			</div>
		</div>
		<form class="form-card"
			onsubmit="return tripilyDemoSubmit(event,'메이트 모집글 저장 Controller 연결 위치입니다.');">
			<div class="two-col">
				<div class="field">
					<label>여행지 <span class="required">필수</span></label><input required
						placeholder="일본 도쿄">
				</div>
				<div class="field">
					<label>모집 인원 <span class="required">필수</span></label><input
						type="number" min="1" max="10" value="2">
				</div>
			</div>
			<div class="two-col">
				<div class="field">
					<label>출발일</label><input type="date">
				</div>
				<div class="field">
					<label>종료일</label><input type="date">
				</div>
			</div>
			<div class="field">
				<label>제목 <span class="required">필수</span></label><input required>
			</div>
			<div class="field">
				<label>여행 스타일 / 상세 내용 <span class="required">필수</span></label>
				<textarea style="min-height: 260px" required></textarea>
			</div>
			<div class="form-actions">
				<a class="btn outline" href="mateList.jsp">취소</a>
				<button class="btn primary">저장</button>
			</div>
		</form>
	</main><jsp:include page="/common/footer.jsp" /></body>
</html>