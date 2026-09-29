<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setAttribute("activePage", "tips");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>여행꿀팁 | Tripily</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body>
	<!-- 공통 Header -->
	<jsp:include page="/common/header.jsp" />
	<!-- Main -->
	<main class="page">
		<!-- 페이지 제목 -->
		<div class="page-title-row">
			<div>
				<span class="eyebrow"> TRAVEL TIPS </span>
				<h1>여행꿀팁</h1>
				<p class="page-desc">여행자들의 실제 경험에서 나온 교통, 숙소, 음식, 준비 팁을 확인하세요.</p>
			</div>
			<!-- 글쓰기 -->
			<a class="btn primary"
				href="${pageContext.request.contextPath}/view/tips/tipWrite.jsp">
				＋ 글쓰기 </a>
		</div>
		<!-- 검색 / 필터 -->
		<div class="toolbar">
			<div class="search-box">
				<span> ⌕ </span> <input type="text" placeholder="제목, 지역, 키워드 검색">
			</div>
			<button type="button" class="chip active">전체</button>
			<button type="button" class="chip">아시아</button>
			<button type="button" class="chip">유럽</button>
			<button type="button" class="chip">국내</button>
		</div>
		<!-- 게시글 목록 -->
		<div class="grid grid-3" style="margin-top: 22px;">
			<!-- 게시글 1 -->
			<a class="card"
				href="${pageContext.request.contextPath}/view/tips/tipDetail.jsp">
				<div class="card-img">
					<img src="https://images.unsplash.com/photo-1585208798174-6cedd86e019a?w=800&q=80" alt="도쿄 여행">
				</div>
				<div class="card-body">
					<span class="card-kicker"> TOKYO · 준비 팁 </span>
					<h3>처음 가는 도쿄에서 꼭 알아둘 것들</h3>
					<p>교통패스부터 숙소 위치까지 직접 다녀온 경험을 정리했어요.</p>
					<div class="meta">
						<span> 여행좋아 </span> <span> ♡ 68 </span> <span> 💬 12 </span>
					</div>
				</div>
			</a>
			<!-- 게시글 2 -->
			<a class="card" href="${pageContext.request.contextPath}/view/tips/tipDetail.jsp">
				<div class="card-img">
					<img src="https://images.unsplash.com/photo-1591814468924-caf88d1232e1?w=800&q=80" alt="제주 여행">
				</div>
				<div class="card-body">
					<span class="card-kicker"> JEJU · 여행 기록 </span>
					<h3>렌터카 없이 제주 동쪽 여행하기</h3>
					<p>버스와 택시만으로도 충분했던 2박 3일 동선입니다.</p>
					<div class="meta">
						<span> 바다러버 </span> <span> ♡ 54 </span> <span> 💬 7 </span>
					</div>
				</div>
			</a>
			<!-- 게시글 3-->
			<a class="card"
				href="${pageContext.request.contextPath}/view/tips/tipDetail.jsp">
				<div class="card-img">
					<img src="https://images.unsplash.com/photo-1613395877344-13d4a8e0d49e?w=800&q=80" alt="유럽 여행">
				</div>
				<div class="card-body">
					<span class="card-kicker"> EUROPE · 추천 </span>
					<h3>유럽 여행 짐 싸기 체크리스트</h3>
					<p>장기 여행에서 정말 필요했던 것만 정리했습니다.</p>
					<div class="meta">
						<span> 문화탐험가 </span> <span> ♡ 91 </span> <span> 💬 18 </span>
					</div>
				</div>
			</a>
		</div>
	</main>
	<!-- 공통 Footer -->
	<jsp:include page="/common/footer.jsp" />

	<!-- 공통 JavaScript -->
	<script src="${pageContext.request.contextPath}/view/assets/js/tripily.js"></script>

</body>

</html>