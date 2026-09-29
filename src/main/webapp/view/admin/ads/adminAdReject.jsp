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
<title>광고 거절 | Tripily</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body><jsp:include page="/common/header.jsp" /><main class="page">
		<div class="page-title-row">
			<div>
				<span class="eyebrow">ADMIN · ADS</span>
				<h1>광고 신청 거절</h1>
				<p class="page-desc">신청 정보를 확인하고 거절 사유를 입력합니다.</p>
			</div>
			<a class="btn outline" href="../reports/adminReports.jsp">신고 관리 →</a>
		</div>
		<form class="form-card" style="max-width: 760px"
			onsubmit="return tripilyDemoSubmit(event,'거절 상태 저장 후 신청자 이메일로 사유를 전송하도록 Service와 연결하세요.');">
			<div class="three-col">
				<div class="field">
					<label>업체명</label><input value="StayNine" readonly>
				</div>
				<div class="field">
					<label>담당자</label><input value="박마케팅" readonly>
				</div>
				<div class="field">
					<label>이메일</label><input value="hello@staynine.example" readonly>
				</div>
			</div>
			<div class="field">
				<label>거절 사유 <span class="required">필수</span></label>
				<textarea required placeholder="메일 본문에 포함될 거절 사유를 입력하세요."></textarea>
			</div>
			<div class="notice warn">거절 처리 후 승인 전 목록에서 제외되며 신청 업체 이메일로 거절
				사유를 안내합니다.</div>
			<div class="form-actions">
				<a class="btn outline" href="adminAdRequests.jsp">취소</a>
				<button class="btn danger">거절 및 메일 전송</button>
			</div>
		</form>
	</main><jsp:include page="/common/footer.jsp" /></body>
</html>