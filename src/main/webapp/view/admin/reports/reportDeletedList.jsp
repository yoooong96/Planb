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
<title>삭제 조치 목록 | Tripily</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body><jsp:include page="/common/header.jsp" /><main class="page">
		<div class="page-title-row">
			<div>
				<span class="eyebrow">ADMIN · REPORTS</span>
				<h1>삭제 조치 목록</h1>
			</div>
		</div>
		<div class="admin-tabs">
			<a class="admin-tab " href="reportPendingList.jsp">접수 목록</a><a
				class="admin-tab " href="reportProcessedList.jsp">처리 완료</a><a
				class="admin-tab active" href="reportDeletedList.jsp">삭제 조치</a>
		</div>
		<div class="table-wrap">
			<table class="data-table">
				<thead>
					<tr>
						<th>조치일</th>
						<th>신고 ID</th>
						<th>삭제 대상</th>
						<th>삭제 사유</th>
						<th>처리자</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>09.27 18:12</td>
						<td>RPT-20260927-0028</td>
						<td>커뮤니티 #91</td>
						<td>반복 광고성 게시물</td>
						<td>admin01</td>
					</tr>
				</tbody>
			</table>
		</div>
	</main><jsp:include page="/common/footer.jsp" /></body>
</html>