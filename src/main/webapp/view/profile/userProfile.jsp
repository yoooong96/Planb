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
<title>사용자 프로필 | Tripily</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>
<body><jsp:include page="/common/header.jsp" /><main class="page">
		<section class="profile-head">
			<div class="profile-avatar">
				<img src="https://i.pravatar.cc/240?img=12">
			</div>
			<div>
				<div class="profile-name">여행좋아</div>
				<div class="profile-user">@yeojong_trip · Jeju, Korea</div>
				<div class="profile-bio">제주도 전문 여행자. 자연과 맛집을 사랑합니다 🍊</div>
				<div class="stats">
					<div class="stat">
						<b>14</b><span>게시물</span>
					</div>
					<div class="stat">
						<b>782</b><span>받은 좋아요</span>
					</div>
					<div class="stat">
						<b>319</b><span>북마크</span>
					</div>
				</div>
			</div>
			<button class="btn danger" data-modal-open="reportUser">⚑ 신고</button>
		</section>
		<nav class="profile-tabs">
			<button class="profile-tab active">게시물</button>
		</nav>
		<div class="feed-grid">
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
	</main>
	<div class="modal-backdrop" id="reportUser">
		<div class="modal">
			<div class="modal-head">
				<div>
					<h3>프로필 신고</h3>
					<p class="page-desc">문제가 되는 항목을 선택해주세요.</p>
				</div>
				<button class="close-btn" data-modal-close="reportUser">×</button>
			</div>
			<div class="field">
				<label>신고 사유</label><select><option>닉네임/아이디가 부적절해요</option>
					<option>프로필 사진이 부적절해요</option>
					<option>게시글에 문제가 있어요</option>
					<option>기타</option></select>
			</div>
			<div class="field">
				<label>상세 내용</label>
				<textarea placeholder="관리자가 확인할 수 있도록 설명해주세요."></textarea>
			</div>
			<div class="form-actions">
				<button class="btn outline" data-modal-close="reportUser">취소</button>
				<button class="btn danger"
					onclick="closeModal('reportUser');tripilyToast('신고가 접수되었습니다.')">신고
					접수</button>
			</div>
		</div>
	</div><jsp:include page="/common/footer.jsp" /></body>
</html>