<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage", "tips");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>여행꿀팁 작성 | Tripily</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body><jsp:include page="/common/header.jsp" /><main
		class="page narrow">
		<div class="page-title-row">
			<div>
				<span class="eyebrow">TRAVEL TIPS</span>
				<h1>여행꿀팁 작성</h1>
			</div>
		</div>
		<form class="form-card"
			onsubmit="return tripilyDemoSubmit(event,'여행꿀팁 저장 Controller 연결 위치입니다.');">
			<div class="two-col">
				<div class="field">
					<label>지역/국가 <span class="required">필수</span></label><input
						required placeholder="예: 일본 도쿄">
				</div>
				<div class="field">
					<label>분류 <span class="required">필수</span></label><select><option>교통</option>
						<option>숙소</option>
						<option>음식</option>
						<option>준비물</option>
						<option>기타</option></select>
				</div>
			</div>
			<div class="field">
				<label>제목 <span class="required">필수</span></label><input required>
			</div>
			<div class="field">
				<label>내용 <span class="required">필수</span></label>
				<textarea style="min-height: 300px" required></textarea>
			</div>
			<div class="field">
				<label>이미지</label><input type="file" multiple accept="image/*">
			</div>
			<div class="form-actions">
				<a class="btn outline" href="tipList.jsp">취소</a>
				<button class="btn primary">저장</button>
			</div>
		</form>
	</main><jsp:include page="/common/footer.jsp" /></body>
</html>