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
<title>승인 전 광고 | Tripily</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body><jsp:include page="/common/header.jsp" /><main class="page">
		<div class="page-title-row">
			<div>
				<span class="eyebrow">ADMIN · ADS</span>
				<h1>광고 관리 · 승인 전 신청</h1>
				<p class="page-desc">고객지원 광고 문의/신청을 통해 들어온 승인 전 광고입니다.</p>
			</div>
			<a class="btn outline" href="../reports/adminReports.jsp">신고 관리 →</a>
		</div>
		<div class="admin-tabs">
			<a class="admin-tab " href="adminAdPublished.jsp">게시중</a><a
				class="admin-tab " href="adminAdWaiting.jsp">게시 대기</a><a
				class="admin-tab active" href="adminAdRequests.jsp">승인 전 신청</a><a
				class="admin-tab " href="adminAdDeleted.jsp">삭제 목록</a>
		</div>
		<div class="table-wrap">
			<table class="data-table">
				<thead>
					<tr>
						<th>이미지</th>
						<th>업체명 / 광고내용</th>
						<th>담당자</th>
						<th>기간</th>
						<th>연락처 / 이메일</th>
						<th>광고 위치</th>
						<th>심사</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><img class="thumb"
							src="https://images.unsplash.com/photo-1549294413-26f195200c16?w=300&q=70"></td>
						<td><b>StayNine</b><br>
						<span class="help">신규 숙소 예약 캠페인</span></td>
						<td>박마케팅</td>
						<td>10.12 ~ 11.12</td>
						<td>010-2222-4455<br>hello@staynine.example
						</td>
						<td>홈 메인 배너</td>
						<td><div class="table-actions">
								<button class="btn secondary"
									onclick="tripilyToast('승인 후 게시 대기 상태로 변경합니다.')">승인</button>
								<a class="btn danger" href="adminAdReject.jsp">거절</a>
							</div></td>
					</tr>
				</tbody>
			</table>
		</div>
	</main><jsp:include page="/common/footer.jsp" /></body>
</html>