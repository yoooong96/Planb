<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage", "profile");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>내 프로필 | Tripily</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body><jsp:include page="/common/header.jsp" /><main class="page">
		<section class="profile-head">
			<div class="profile-avatar">황</div>
			<div>
				<div class="profile-name">황수빈</div>
				<div class="profile-user">@soobin.trip · Seoul, Korea</div>
				<div class="profile-bio">느리게 걷고 오래 기억하는 여행을 좋아합니다. ☁️</div>
				<div class="stats">
					<div class="stat">
						<b>9</b><span>게시물</span>
					</div>
					<div class="stat">
						<b>473</b><span>받은 좋아요 합계</span>
					</div>
					<div class="stat">
						<b>221</b><span>북마크 합계</span>
					</div>
				</div>
			</div>
			<div class="toolbar">
				<a class="btn outline" href="../settings/profileEdit.jsp">프로필 편집</a><a
					class="btn secondary" href="../settings/settings.jsp">설정</a>
			</div>
		</section>
		<nav class="profile-tabs">
			<button class="profile-tab active" data-tab="posts"
				data-tab-group="profile">게시물</button>
			<button class="profile-tab" data-tab="bookmarks"
				data-tab-group="profile">북마크</button>
			<button class="profile-tab" data-tab="likes" data-tab-group="profile">좋아요</button>
			<button class="profile-tab" data-tab="activity"
				data-tab-group="profile">활동</button>
		</nav>
		<div data-tab-panel="posts" data-tab-panel-group="profile"
			class="feed-grid">
			<a class="feed-item" href="../travel/scheduleDetail.jsp"><img
				src="https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=700&q=80">
			<div class="feed-overlay">
					<div>
						<div class="feed-title">도쿄 3박 4일</div>
						<div class="feed-meta">도쿄 · ♡ 128 · ⌑ 64</div>
					</div>
				</div></a><a class="feed-item" href="../travel/scheduleDetail.jsp"><img
				src="https://images.unsplash.com/photo-1688544969956-a887beadb9d2?w=700&q=80">
			<div class="feed-overlay">
					<div>
						<div class="feed-title">제주 동쪽 여행</div>
						<div class="feed-meta">제주 · ♡ 96 · ⌑ 38</div>
					</div>
				</div></a><a class="feed-item" href="../travel/scheduleDetail.jsp"><img
				src="https://images.unsplash.com/photo-1511739001486-6bfe10ce785f?w=700&q=80">
			<div class="feed-overlay">
					<div>
						<div class="feed-title">파리 미술관 산책</div>
						<div class="feed-meta">파리 · ♡ 77 · ⌑ 41</div>
					</div>
				</div></a><a class="feed-item" href="../travel/scheduleDetail.jsp"><img
				src="https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=700&q=80">
			<div class="feed-overlay">
					<div>
						<div class="feed-title">발리 휴양 코스</div>
						<div class="feed-meta">발리 · ♡ 68 · ⌑ 31</div>
					</div>
				</div></a><a class="feed-item" href="../travel/scheduleDetail.jsp"><img
				src="https://images.unsplash.com/photo-1496588152823-86ff7695e68f?w=700&q=80">
			<div class="feed-overlay">
					<div>
						<div class="feed-title">뉴욕 5일 기록</div>
						<div class="feed-meta">뉴욕 · ♡ 55 · ⌑ 24</div>
					</div>
				</div></a><a class="feed-item" href="../travel/scheduleDetail.jsp"><img
				src="https://images.unsplash.com/photo-1579282240050-352db0a14c21?w=700&q=80">
			<div class="feed-overlay">
					<div>
						<div class="feed-title">바르셀로나 건축 여행</div>
						<div class="feed-meta">바르셀로나 · ♡ 49 · ⌑ 22</div>
					</div>
				</div></a>
		</div>
		<div data-tab-panel="bookmarks" data-tab-panel-group="profile"
			class="hidden">
			<div class="empty">북마크한 여행일정이 표시됩니다. 공개/비공개 설정과 연동합니다.</div>
		</div>
		<div data-tab-panel="likes" data-tab-panel-group="profile"
			class="hidden">
			<div class="empty">좋아요한 콘텐츠가 표시됩니다. 공개/비공개 설정과 연동합니다.</div>
		</div>
		<div data-tab-panel="activity" data-tab-panel-group="profile"
			class="hidden">
			<div class="panel">
				<b>최근 활동</b>
				<p class="page-desc">제주에서 가장 좋았던 산책 코스를 공유했어요. · 2026.09.12</p>
				<p class="page-desc">“숙소 정보 감사합니다!” 댓글을 작성했습니다. · 2026.09.11</p>
			</div>
		</div>
	</main><jsp:include page="/common/footer.jsp" /></body>
</html>