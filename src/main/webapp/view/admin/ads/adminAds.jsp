<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage", "admin");
request.setAttribute("forceAdminHeader", Boolean.TRUE);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>광고 관리 | Tripily</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body><jsp:include page="/common/header.jsp" /><main class="page">
		<div class="page-title-row">
			<div>
				<span class="eyebrow">ADMIN · ADS</span>
				<h1>광고 관리</h1>
				<p class="page-desc">광고 문의에서 접수된 신청과 게시 상태를 한 곳에서 관리합니다.</p>
			</div>
			<a class="btn outline" href="../reports/adminReports.jsp">신고 관리 →</a>
		</div>
		<div class="status-counts">
			<a class="status-card" href="adminAdPublished.jsp"><b>3</b><span>게시중</span></a><a
				class="status-card" href="adminAdWaiting.jsp"><b>2</b><span>게시
					대기</span></a><a class="status-card" href="adminAdRequests.jsp"><b>4</b><span>승인
					전 신청</span></a><a class="status-card" href="adminAdDeleted.jsp"><b>6</b><span>삭제/철회</span></a>
		</div>
		<div class="panel soft">
			<b>관리 기준</b>
			<p class="page-desc">광고 문의 접수 → 승인 전 신청 → 승인 → 게시 대기 → 시작일 도래 시
				게시중 흐름으로 관리합니다. 게시 철회 또는 삭제는 삭제 목록으로 이동합니다.</p>
		</div>
		<div class="section-title">
			<div>
				<h2>최근 광고 신청</h2>
			</div>
			<a class="btn outline" href="adminAdRequests.jsp">전체보기</a>
		</div>
		<div class="table-wrap">
			<table class="data-table">
				<thead>
					<tr>
						<th>업체명</th>
						<th>담당자</th>
						<th>기간</th>
						<th>위치</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><b>TripStay</b></td>
						<td>김담당 · brand@tripstay.example</td>
						<td>2026.10.01 ~ 10.31</td>
						<td>홈 메인 배너</td>
						<td><span class="pill yellow">승인 전</span></td>
					</tr>
					<tr>
						<td><b>RailGo</b></td>
						<td>이지원 · ad@railgo.example</td>
						<td>2026.10.05 ~ 11.05</td>
						<td>여행일정 목록</td>
						<td><span class="pill green">게시 대기</span></td>
					</tr>
				</tbody>
			</table>
		</div>
	</main><jsp:include page="/common/footer.jsp" /></body>
</html>