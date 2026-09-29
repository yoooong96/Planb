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
<title>여행일정 | Tripily</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body><jsp:include page="/common/header.jsp" /><main class="page">
		<div class="page-title-row">
			<div>
				<span class="eyebrow">DISCOVER</span>
				<h1>여행일정</h1>
				<p class="page-desc">조건에 맞는 실제 여행자들의 일정을 찾아보세요.</p>
			</div>
			<a class="btn primary" href="../itinerary/planner.jsp">＋ 일정 만들기</a>
		</div>
		<div class="toolbar">
			<div class="search-box">
				<span>⌕</span><input value="" placeholder="여행지 또는 키워드 검색">
			</div>
			<button class="chip active">인기순</button>
			<button class="chip">최신순</button>
		</div>
		<div class="filters">
			<select><option>대륙 전체</option>
				<option>아시아</option>
				<option>유럽</option></select><select><option>국가 전체</option>
				<option>한국</option>
				<option>일본</option>
				<option>프랑스</option></select><select><option>기간 전체</option>
				<option>1~3일</option>
				<option>4~6일</option>
				<option>7일 이상</option></select><select><option>예산 전체</option>
				<option>50만원 이하</option>
				<option>50~100만원</option>
				<option>100만원 이상</option></select><select><option>인원 전체</option>
				<option>혼자</option>
				<option>2인</option>
				<option>3인 이상</option></select>
		</div>
		<div class="grid grid-3">
			<a class="card" href="scheduleDetail.jsp"><div class="card-img">
					<img
						src="https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=800&q=80">
				</div>
				<div class="card-body">
					<span class="card-kicker">TOKYO · 3박 4일</span>
					<h3>도쿄 감성 여행</h3>
					<p>맛집과 골목 산책을 균형 있게 담은 일정</p>
					<div class="meta">
						<span>조회 1.2k</span><span>⌑ 164</span><span>예산 82만원</span>
					</div>
				</div></a><a class="card" href="scheduleDetail.jsp"><div class="card-img">
					<img
						src="https://images.unsplash.com/photo-1688544969956-a887beadb9d2?w=800&q=80">
				</div>
				<div class="card-body">
					<span class="card-kicker">JEJU · 2박 3일</span>
					<h3>제주 동쪽 드라이브</h3>
					<p>성산부터 세화까지 여유로운 해안 코스</p>
					<div class="meta">
						<span>조회 980</span><span>⌑ 121</span><span>예산 45만원</span>
					</div>
				</div></a><a class="card" href="scheduleDetail.jsp"><div class="card-img">
					<img
						src="https://images.unsplash.com/photo-1511739001486-6bfe10ce785f?w=800&q=80">
				</div>
				<div class="card-body">
					<span class="card-kicker">PARIS · 4박 5일</span>
					<h3>파리 첫 여행 정석</h3>
					<p>미술관, 몽마르트, 세느강 야경까지</p>
					<div class="meta">
						<span>조회 840</span><span>⌑ 105</span><span>예산 190만원</span>
					</div>
				</div></a><a class="card" href="scheduleDetail.jsp"><div class="card-img">
					<img
						src="https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=800&q=80">
				</div>
				<div class="card-body">
					<span class="card-kicker">TOKYO · 3박 4일</span>
					<h3>도쿄 감성 여행</h3>
					<p>맛집과 골목 산책을 균형 있게 담은 일정</p>
					<div class="meta">
						<span>조회 1.2k</span><span>⌑ 164</span><span>예산 82만원</span>
					</div>
				</div></a><a class="card" href="scheduleDetail.jsp"><div class="card-img">
					<img
						src="https://images.unsplash.com/photo-1688544969956-a887beadb9d2?w=800&q=80">
				</div>
				<div class="card-body">
					<span class="card-kicker">JEJU · 2박 3일</span>
					<h3>제주 동쪽 드라이브</h3>
					<p>성산부터 세화까지 여유로운 해안 코스</p>
					<div class="meta">
						<span>조회 980</span><span>⌑ 121</span><span>예산 45만원</span>
					</div>
				</div></a><a class="card" href="scheduleDetail.jsp"><div class="card-img">
					<img
						src="https://images.unsplash.com/photo-1511739001486-6bfe10ce785f?w=800&q=80">
				</div>
				<div class="card-body">
					<span class="card-kicker">PARIS · 4박 5일</span>
					<h3>파리 첫 여행 정석</h3>
					<p>미술관, 몽마르트, 세느강 야경까지</p>
					<div class="meta">
						<span>조회 840</span><span>⌑ 105</span><span>예산 190만원</span>
					</div>
				</div></a>
		</div>
	</main><jsp:include page="/common/footer.jsp" /></body>
</html>