<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage", "planner");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>일정 만들기 | Tripily</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body><jsp:include page="/common/header.jsp" /><main class="page"
		style="width: min(1400px, calc(100% - 34px))">
		<div class="page-title-row">
			<div>
				<span class="eyebrow">PLANNER</span>
				<h1>여행 일정 만들기</h1>
				<p class="page-desc">대표 이미지와 DAY별 장소/시간/비용/메모를 구성하세요.</p>
			</div>
			<div class="toolbar">
				<button class="btn outline" onclick="tripilyToast('임시 저장되었습니다.')">임시
					저장</button>
				<button class="btn primary"
					onclick="tripilyToast('일정 저장 Controller 연결 위치입니다.')">일정 저장</button>
			</div>
		</div>
		<div class="planner-layout">
			<aside class="day-list">
				<b style="display: block; padding: 10px; font-size: 12px">여행일</b>
				<button class="day-btn active">DAY 1 · 10/12</button>
				<button class="day-btn">DAY 2 · 10/13</button>
				<button class="day-btn">DAY 3 · 10/14</button>
				<button class="day-btn">DAY 4 · 10/15</button>
				<button class="day-btn" onclick="tripilyToast('DAY가 추가됩니다.')">＋
					DAY 추가</button>
			</aside>
			<section class="planner-center">
				<div class="two-col">
					<div class="field">
						<label>일정 제목 <span class="required">필수</span></label><input
							value="도쿄 3박 4일 감성 여행">
					</div>
					<div class="field">
						<label>대표 이미지 <span class="optional">선택</span></label><input
							type="file" accept="image/*">
					</div>
				</div>
				<div class="three-col">
					<div class="field">
						<label>국가</label><input value="일본">
					</div>
					<div class="field">
						<label>도시</label><input value="도쿄">
					</div>
					<div class="field">
						<label>예산</label><input value="820000">
					</div>
				</div>
				<h3 style="font-size: 14px">DAY 1 일정 블록</h3>
				<div class="planner-block">
					<div class="planner-time">10:00</div>
					<div>
						<h4>센소지</h4>
						<p>장소 · 2시간 · 메모: 오전 일찍 방문</p>
					</div>
					<button class="btn outline">⋮</button>
				</div>
				<div class="planner-block">
					<div class="planner-time">13:00</div>
					<div>
						<h4>우에노 브런치</h4>
						<p>식당 · 1시간 · 2,500엔</p>
					</div>
					<button class="btn outline">⋮</button>
				</div>
				<div class="planner-block">
					<div class="planner-time">17:30</div>
					<div>
						<h4>시부야 스카이</h4>
						<p>명소 · 2시간 · 2,200엔</p>
					</div>
					<button class="btn outline">⋮</button>
				</div>
				<button class="btn secondary" style="width: 100%; margin-top: 12px"
					data-modal-open="addPlace">＋ 장소/일정 블록 추가</button>
				<div class="cost-box">
					<b>DAY 1 예상 비용</b><strong style="float: right; color: #6369D1">약
						48,000원</strong>
				</div>
			</section>
			<aside>
				<div class="map-placeholder" style="min-height: 420px">
					지도 API<br>선택한 장소 마커/경로 표시
				</div>
				<div class="panel" style="margin-top: 14px">
					<b style="font-size: 12px">공개 설정</b><label class="check-row"><input
						type="radio" name="pub" checked> 공개</label><label
						class="check-row"><input type="radio" name="pub">
						비공개</label>
				</div>
			</aside>
		</div>
	</main>
	<div class="modal-backdrop" id="addPlace">
		<div class="modal">
			<div class="modal-head">
				<h3>장소 추가</h3>
				<button class="close-btn" data-modal-close="addPlace">×</button>
			</div>
			<div class="field">
				<label>장소 검색</label><input placeholder="Kakao Places 검색">
			</div>
			<div class="two-col">
				<div class="field">
					<label>시간</label><input type="time">
				</div>
				<div class="field">
					<label>비용</label><input type="number">
				</div>
			</div>
			<div class="field">
				<label>메모</label>
				<textarea></textarea>
			</div>
			<div class="field">
				<label>장소 이미지 <span class="optional">최대 3장</span></label><input
					type="file" accept="image/*" multiple>
			</div>
			<div class="form-actions">
				<button class="btn primary"
					onclick="closeModal('addPlace');tripilyToast('일정 블록이 추가됩니다.')">추가</button>
			</div>
		</div>
	</div><jsp:include page="/common/footer.jsp" /></body>
</html>