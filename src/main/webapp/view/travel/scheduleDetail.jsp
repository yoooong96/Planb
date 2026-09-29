<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage", "travel");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>여행일정 상세 | Tripily</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body><jsp:include page="/common/header.jsp" /><main class="page">
		<section class="detail-hero">
			<img
				src="https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=1600&q=85">
			<div class="detail-title">
				<span class="pill yellow">TOKYO · JAPAN</span>
				<h1>도쿄 3박 4일 감성 여행</h1>
				<div>2026.10.12 - 10.15 · 2인 · 예산 820,000원 · 조회 1,248</div>
			</div>
		</section>
		<div class="content-layout">
			<article>
				<div class="toolbar" style="margin-bottom: 18px">
					<button class="btn secondary"
						onclick="tripilyToast('북마크에 저장되었습니다.')">⌑ 북마크</button>
					<button class="btn outline" data-modal-open="importSchedule">⇲
						선택적 가져오기</button>
					<button class="btn danger" data-modal-open="reportSchedule">⚑
						신고</button>
				</div>
				<div class="section-title">
					<div>
						<h2>DAY 1 · 아사쿠사와 시부야</h2>
						<p>전통적인 도쿄와 현대적인 도쿄를 하루에 연결합니다.</p>
					</div>
				</div>
				<div class="timeline">
					<div class="timeline-item">
						<div class="timeline-time">10:00</div>
						<i class="timeline-dot"></i>
						<div class="timeline-card">
							<h4>센소지 & 나카미세 거리</h4>
							<p>도쿄도 다이토구 · 2시간 · 입장 무료</p>
						</div>
					</div>
					<div class="timeline-item">
						<div class="timeline-time">13:00</div>
						<i class="timeline-dot"></i>
						<div class="timeline-card">
							<h4>우에노 카페</h4>
							<p>브런치 · 예상비용 2,500엔</p>
						</div>
					</div>
					<div class="timeline-item">
						<div class="timeline-time">17:30</div>
						<i class="timeline-dot"></i>
						<div class="timeline-card">
							<h4>시부야 스카이</h4>
							<p>선셋 시간대 사전 예약 추천</p>
						</div>
					</div>
				</div>
				<div class="section-title">
					<div>
						<h2>지도 & 동선</h2>
					</div>
				</div>
				<div class="map-placeholder">Kakao/VWorld 지도 API 연결 영역 · 마커와
					경로를 표시하세요.</div>
			</article>
			<aside class="sticky-card panel">
				<span class="pill brand">작성자</span>
				<h3 style="margin-bottom: 4px">황수빈님의 여행</h3>
				<p class="page-desc">느리게 걷고 오래 기억하는 여행을 좋아합니다.</p>
				<a class="btn outline" style="width: 100%; margin-top: 14px"
					href="../profile/userProfile.jsp">프로필 보기</a>
				<hr style="border: 0; border-top: 1px solid #eee; margin: 18px 0">
				<b style="font-size: 12px">일정 요약</b>
				<p class="page-desc">
					DAY 1 아사쿠사 · 시부야<br>DAY 2 신주쿠 · 하라주쿠<br>DAY 3 가마쿠라<br>DAY
					4 긴자 · 공항
				</p>
			</aside>
		</div>
	</main>
	<div class="modal-backdrop" id="importSchedule">
		<div class="modal">
			<div class="modal-head">
				<h3>일정 가져오기</h3>
				<button class="close-btn" data-modal-close="importSchedule">×</button>
			</div>
			<label class="check-row"><input type="checkbox" checked>
				DAY 1 전체 가져오기</label><label class="check-row"><input type="checkbox">
				DAY 2 전체 가져오기</label><label class="check-row"><input type="checkbox">
				DAY 3 전체 가져오기</label>
			<div class="form-actions">
				<button class="btn outline" data-modal-close="importSchedule">취소</button>
				<button class="btn primary"
					onclick="closeModal('importSchedule');tripilyToast('내 일정으로 복사되었습니다.')">가져오기</button>
			</div>
		</div>
	</div>
	<div class="modal-backdrop" id="reportSchedule">
		<div class="modal">
			<div class="modal-head">
				<h3>일정 신고</h3>
				<button class="close-btn" data-modal-close="reportSchedule">×</button>
			</div>
			<div class="field">
				<label>신고 사유</label><select><option>부적절한 콘텐츠</option>
					<option>허위 정보</option>
					<option>광고/도배</option>
					<option>기타</option></select>
			</div>
			<div class="field">
				<label>상세 내용</label>
				<textarea></textarea>
			</div>
			<div class="form-actions">
				<button class="btn danger"
					onclick="closeModal('reportSchedule');tripilyToast('신고가 접수되었습니다.')">신고
					접수</button>
			</div>
		</div>
	</div><jsp:include page="/common/footer.jsp" /></body>
</html>