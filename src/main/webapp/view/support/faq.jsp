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
<title>FAQ | Tripily</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body><jsp:include page="/common/header.jsp" /><main
		class="page narrow">
		<div class="page-title-row">
			<div>
				<span class="eyebrow">FAQ</span>
				<h1>자주 묻는 질문</h1>
			</div>
			<a class="btn outline" href="support.jsp">← 고객지원</a>
		</div>
		<div class="form-card">
			<div class="faq-item">
				<button class="faq-q">
					일정은 어떻게 저장하나요?<span>＋</span>
				</button>
				<div class="faq-a">여행 일정 상세에서 북마크 버튼을 누르면 내 프로필의 북마크 탭에서 다시
					확인할 수 있습니다.</div>
			</div>
			<div class="faq-item">
				<button class="faq-q">
					일정을 가져오면 원본도 수정되나요?<span>＋</span>
				</button>
				<div class="faq-a">아니요. 선택한 DAY 또는 장소가 내 일정으로 복사되며 원본에는 영향을 주지
					않습니다.</div>
			</div>
			<div class="faq-item">
				<button class="faq-q">
					광고 문의는 어디서 하나요?<span>＋</span>
				</button>
				<div class="faq-a">고객지원의 “광고 문의하기”에서 업체정보, 이미지, 기간, 위치를 입력해
					신청할 수 있습니다.</div>
			</div>
			<div class="faq-item">
				<button class="faq-q">
					신고한 내용은 어디에서 처리되나요?<span>＋</span>
				</button>
				<div class="faq-a">관리자 신고 관리 화면에서 별도로 확인하고 조치합니다. 일반 알림과는
					분리됩니다.</div>
			</div>
		</div>
	</main><jsp:include page="/common/footer.jsp" /></body>
</html>