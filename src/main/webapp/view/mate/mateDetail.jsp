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
<title>여행 메이트 상세 | Tripily</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body><jsp:include page="/common/header.jsp" /><main class="page">
		<div class="content-layout">
			<article class="panel">
				<span class="pill yellow">모집중 · 도쿄</span>
				<h1 style="font-size: 30px">10월 도쿄 3박 4일 같이 여행하실 분!</h1>
				<div class="meta">
					<a href="../profile/userProfile.jsp">재팬러버</a><span>2026.09.28</span><span>조회
						328</span>
				</div>
				<div class="article">
					<h2>여행 정보</h2>
					<p>2026.10.12 ~ 10.15 · 일본 도쿄 · 20~30대 · 1~2명 모집</p>
					<h2>원하는 여행 스타일</h2>
					<p>맛집 줄서는 건 괜찮지만 너무 빡빡한 일정은 피하고 싶어요. 사진 찍는 걸 좋아하고, 저녁에는 가볍게 술
						한잔하는 정도를 선호합니다.</p>
					<h2>간단한 일정</h2>
					<p>
						DAY 1 아사쿠사 / 시부야<br>DAY 2 신주쿠 / 하라주쿠<br>DAY 3 가마쿠라
					</p>
				</div>
				<div class="toolbar">
					<button class="btn danger" data-modal-open="reportMate">⚑
						신고</button>
				</div>
			</article>
			<aside class="sticky-card panel">
				<b>모집 현황</b>
				<p class="page-desc">
					모집 2명 중 0명 확정<br>마감 D-8
				</p>
				<a class="btn outline" style="width: 100%"
					href="../profile/userProfile.jsp">작성자 프로필</a>
			</aside>
		</div>
	</main>
	<div class="modal-backdrop" id="reportMate">
		<div class="modal">
			<div class="modal-head">
				<h3>모집글 신고</h3>
				<button class="close-btn" data-modal-close="reportMate">×</button>
			</div>
			<div class="field">
				<label>신고 사유</label><select><option>부적절한 모집</option>
					<option>사기 의심</option>
					<option>광고/도배</option>
					<option>기타</option></select>
			</div>
			<div class="field">
				<label>상세 내용</label>
				<textarea></textarea>
			</div>
			<div class="form-actions">
				<button class="btn danger"
					onclick="closeModal('reportMate');tripilyToast('신고가 접수되었습니다.')">신고</button>
			</div>
		</div>
	</div><jsp:include page="/common/footer.jsp" /></body>
</html>