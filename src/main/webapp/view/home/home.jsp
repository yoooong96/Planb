<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setAttribute("activePage", "home");
%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<title>홈 | Tripily</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>

<body>

	<!-- 공통 헤더 -->
	<jsp:include page="/common/header.jsp" />

	<main class="page">

		<!-- =====================================================
             HERO
        ====================================================== -->
		<section class="hero"
			style="background-image: url('https://images.unsplash.com/photo-1539635278303-d4002c07eae3?w=1600&amp;q=85');">
			<div class="hero-content">

				<div class="kicker">YOUR JOURNEY, YOUR STORY</div>

				<h1>
					여행은 계획할 때부터<br> 이미 시작됩니다.
				</h1>

				<p>다른 여행자의 일정을 발견하고, 나만의 여행을 만들고, 유용한 팁과 동행을 함께 나눠보세요.</p>

				<form class="hero-search"
					action="${pageContext.request.contextPath}/view/search/searchResult.jsp"
					method="get">
					<input type="text" name="q" placeholder="어디로 떠나고 싶으세요?">

					<button type="submit">검색</button>
				</form>

			</div>
		</section>


		<!-- =====================================================
             인기 여행일정
        ====================================================== -->
		<div class="section-title">

			<div>
				<h2>지금 가장 인기 있는 여행일정</h2>
				<p>여행자들이 많이 저장한 일정이에요.</p>
			</div>

			<a class="btn outline"
				href="${pageContext.request.contextPath}/view/travel/scheduleList.jsp">
				전체보기 → </a>

		</div>


		<div class="grid grid-4">

			<!-- 도쿄 -->
			<a class="card"
				href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp">

				<div class="card-img">
					<img
						src="https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=800&q=80"
						alt="도쿄 여행">
				</div>

				<div class="card-body">

					<span class="card-kicker"> JAPAN · TOKYO </span>

					<h3>도쿄 3박 4일 감성 여행</h3>

					<p>아사쿠사부터 시부야까지 천천히 즐기는 일정</p>

					<div class="meta">
						<span>♡ 328</span> <span>⌑ 164</span> <span>3박 4일</span>
					</div>

				</div>
			</a>


			<!-- 산토리니 -->
			<a class="card"
				href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp">

				<div class="card-img">
					<img
						src="https://images.unsplash.com/photo-1613395877344-13d4a8e0d49e?w=800&q=80"
						alt="산토리니 여행">
				</div>

				<div class="card-body">

					<span class="card-kicker"> GREECE · SANTORINI </span>

					<h3>산토리니 선셋 여행</h3>

					<p>하얀 골목과 에게해를 만나는 낭만 코스</p>

					<div class="meta">
						<span>♡ 291</span> <span>⌑ 137</span> <span>4박 5일</span>
					</div>

				</div>
			</a>


			<!-- 제주 -->
			<a class="card"
				href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp">

				<div class="card-img">
					<img
						src="https://images.unsplash.com/photo-1688544969956-a887beadb9d2?w=800&q=80"
						alt="제주 여행">
				</div>

				<div class="card-body">

					<span class="card-kicker"> KOREA · JEJU </span>

					<h3>제주 동쪽 2박 3일</h3>

					<p>바다, 오름, 카페를 가볍게 연결한 코스</p>

					<div class="meta">
						<span>♡ 244</span> <span>⌑ 121</span> <span>2박 3일</span>
					</div>

				</div>
			</a>


			<!-- 파리 -->
			<a class="card"
				href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp">

				<div class="card-img">
					<img
						src="https://images.unsplash.com/photo-1511739001486-6bfe10ce785f?w=800&q=80"
						alt="파리 여행">
				</div>

				<div class="card-body">

					<span class="card-kicker"> FRANCE · PARIS </span>

					<h3>파리 클래식 4박 5일</h3>

					<p>미술관과 골목, 야경을 모두 담은 첫 파리 일정</p>

					<div class="meta">
						<span>♡ 216</span> <span>⌑ 105</span> <span>4박 5일</span>
					</div>

				</div>
			</a>

		</div>


		<!-- =====================================================
             여행꿀팁 / 여행메이트
        ====================================================== -->
		<div class="section-title">

			<div>
				<h2>여행꿀팁 &amp; 메이트</h2>

				<p>여행 준비부터 현지 경험까지 함께 나눠요.</p>
			</div>

		</div>


		<div class="grid grid-2">

			<!-- 여행꿀팁 -->
			<a class="panel soft"
				href="${pageContext.request.contextPath}/view/tips/tipList.jsp">

				<span class="pill brand"> TRAVEL TIPS </span>

				<h2>여행 준비가 쉬워지는 실전 팁</h2>

				<p class="page-desc">교통, 숙소, 맛집, 준비물 정보를 한 번에 확인하세요.</p>

			</a>


			<!-- 여행메이트 -->
			<a class="panel soft"
				href="${pageContext.request.contextPath}/view/mate/mateList.jsp">

				<span class="pill yellow"> TRAVEL MATE </span>

				<h2>여행을 함께할 사람을 찾아보세요</h2>

				<p class="page-desc">일정과 여행 스타일이 맞는 동행을 안전하게 찾아보세요.</p>

			</a>

		</div>

	</main>


	<!-- 공통 푸터 -->
	<jsp:include page="/common/footer.jsp" />


	<!-- 공통 JavaScript -->
	<script
		src="${pageContext.request.contextPath}/view/assets/js/tripily.js"></script>

</body>

</html>