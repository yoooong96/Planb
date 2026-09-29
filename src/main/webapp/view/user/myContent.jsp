<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage", "profile");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>내 작성 콘텐츠 | Tripily</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body><jsp:include page="/common/header.jsp" /><main class="page">
		<div class="page-title-row">
			<div>
				<span class="eyebrow">MY CONTENT</span>
				<h1>내 작성 콘텐츠</h1>
				<p class="page-desc">여행꿀팁과 여행 메이트 모집글을 한 곳에서 관리합니다.</p>
			</div>
		</div>
		<div class="admin-tabs">
			<button class="admin-tab active" data-tab="myTips"
				data-tab-group="mine">여행꿀팁 3</button>
			<button class="admin-tab" data-tab="myMate" data-tab-group="mine">여행메이트
				2</button>
		</div>
		<div data-tab-panel="myTips" data-tab-panel-group="mine"
			class="table-wrap">
			<table class="data-table">
				<thead>
					<tr>
						<th>유형</th>
						<th>제목</th>
						<th>작성일</th>
						<th>반응</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><span class="pill brand">교통</span></td>
						<td>리스본 트램, 처음 타도 어렵지 않아요</td>
						<td>2026.09.25</td>
						<td>♡68 · 💬12</td>
						<td><div class="table-actions">
								<a class="btn outline" href="../tips/tipWrite.jsp">수정</a>
								<button class="btn danger">삭제</button>
							</div></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div data-tab-panel="myMate" data-tab-panel-group="mine"
			class="table-wrap hidden">
			<table class="data-table">
				<thead>
					<tr>
						<th>여행지</th>
						<th>제목</th>
						<th>상태</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>도쿄</td>
						<td>10월 도쿄 같이 여행하실 분</td>
						<td><span class="pill green">모집중</span></td>
						<td><a class="btn outline" href="../mate/mateWrite.jsp">수정</a></td>
					</tr>
				</tbody>
			</table>
		</div>
	</main><jsp:include page="/common/footer.jsp" /></body>
</html>