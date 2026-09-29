<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage", "profile");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>사용자 프로필 · Tripily</title><jsp:include
	page="/common/headStyles.jsp" /><link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/profile.css">
</head>
<body class="site-shell"><jsp:include page="/common/header.jsp" />
	<div class="app-root app-root--inner">
		<div class="app-body">
			<div class="page profile-page">
				<a class="back-link" href="javascript:history.back()"><svg
						width="16" height="16" viewBox="0 0 24 24" fill="none"
						stroke="currentColor" stroke-width="1.7" stroke-linecap="round"
						stroke-linejoin="round" aria-hidden="true">
						<path d="m15 18-6-6 6-6" /></svg> 뒤로 가기</a>
				<section class="profile-hero">
					<div class="profile-hero-inner">
						<div class="profile-avatar-wrap">
							<div class="avatar avatar-xl">
								<img src="https://i.pravatar.cc/200?img=12" alt="여행좋아 프로필">
							</div>
						</div>
						<div class="profile-copy">
							<div class="profile-topline">
								<div>
									<div class="profile-username-row">
										<h1>yeojong_trip</h1>
									</div>
									<p class="profile-name">여행좋아</p>
								</div>
								<div class="profile-actions profile-actions--report">
									<button type="button" class="profile-report-btn"
										data-modal-open="reportModal">
										<svg width="14" height="14" viewBox="0 0 24 24" fill="none"
											stroke="currentColor" stroke-width="1.7"
											stroke-linecap="round" stroke-linejoin="round"
											aria-hidden="true">
											<path d="M5 21V4" />
											<path d="M5 4h10.5l-1.5 3 1.5 3H5" /></svg>
										<span>신고</span>
									</button>
								</div>
							</div>
							<div class="profile-stats">
								<button type="button">
									<strong>1</strong><span>게시물</span>
								</button>
								<button type="button">
									<strong>328</strong><span>받은 좋아요</span>
								</button>
								<button type="button">
									<strong>98</strong><span>받은 북마크</span>
								</button>
							</div>
							<div class="profile-bio-block">
								<p>여행좋아</p>
								<p style="font-weight: 400">제주도 전문 여행자. 자연과 맛집을 사랑합니다 🍊</p>
								<span class="profile-location">Jeju, Korea</span>
							</div>
						</div>
					</div>
				</section>
				<div class="profile-tabs">
					<button class="active">
						<svg width="17" height="17" viewBox="0 0 24 24" fill="none"
							stroke="currentColor" stroke-width="1.7" stroke-linecap="round"
							stroke-linejoin="round" aria-hidden="true">
							<rect x="3" y="3" width="7" height="7" />
							<rect x="14" y="3" width="7" height="7" />
							<rect x="3" y="14" width="7" height="7" />
							<rect x="14" y="14" width="7" height="7" /></svg>
						<span>게시물</span>
					</button>
				</div>
				<main class="profile-content">
					<div class="feed-grid">
						<div class="feed-admin-shell">
							<a class="feed-item"
								href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=1"
								aria-label="제주도 2박 3일 힐링 여행 보기"><img
								src="https://images.unsplash.com/photo-1628411848698-e3b3249a272a?w=600&h=400&fit=crop"
								alt="제주도 2박 3일 힐링 여행" loading="lazy"><span
								class="feed-hover"><span class="feed-hover-copy"><strong>제주도
											2박 3일 힐링 여행</strong><small>제주도</small></span><span class="feed-hover-stats"><span><svg
												width="17" height="17" viewBox="0 0 24 24"
												fill="currentColor" stroke="none" aria-hidden="true">
												<path
													d="M12 21s-7-4.35-9.5-9C1 8 2.5 4.5 6 4c2-.3 3.7.7 6 3 2.3-2.3 4-3.3 6-3 3.5.5 5 4 3.5 8-2.5 4.65-9.5 9-9.5 9Z" /></svg>
											328</span><span><svg width="16" height="16"
												viewBox="0 0 24 24" fill="currentColor" stroke="none"
												aria-hidden="true">
												<path d="M6 3h12a1 1 0 0 1 1 1v17l-7-4-7 4V4a1 1 0 0 1 1-1Z" /></svg>
											98</span><span><svg width="17" height="17"
												viewBox="0 0 24 24" fill="none" stroke="currentColor"
												stroke-width="1.7" stroke-linecap="round"
												stroke-linejoin="round" aria-hidden="true">
												<path
													d="M21 11.5a8.38 8.38 0 0 1-8.9 8.4A8.38 8.38 0 0 1 3 12.4 8.5 8.5 0 0 1 12.1 4a8.38 8.38 0 0 1 8.9 7.5Z" /></svg>
											0</span></span></span></a>
						</div>
					</div>
				</main>
			</div>
		</div>
	</div>
	<div class="jsp-modal" id="reportModal">
		<div class="report-modal" role="dialog" aria-modal="true"
			aria-labelledby="profile-report-title">
			<form onsubmit="return tripilyDemoSubmit(event,'신고가 접수되었습니다.')">
				<div class="report-modal-header">
					<div>
						<h3 id="profile-report-title">신고하기</h3>
						<p>여행좋아님의 프로필에서 문제가 되는 항목을 선택해 주세요.</p>
					</div>
					<button type="button" class="report-close-btn"
						data-modal-close="reportModal" aria-label="신고 창 닫기">
						<svg width="19" height="19" viewBox="0 0 24 24" fill="none"
							stroke="currentColor" stroke-width="1.7" stroke-linecap="round"
							stroke-linejoin="round">
							<path d="M18 6 6 18M6 6l12 12" /></svg>
					</button>
				</div>
				<div class="report-modal-body">
					<fieldset class="report-reason-group">
						<legend>
							신고 사유를 선택해 주세요 <span>*</span>
						</legend>
						<label class="report-radio-row"><input type="radio"
							name="profile-report-reason" value="r0"><span
							class="report-radio-ui" aria-hidden="true"></span><span>닉네임
								또는 아이디가 부적절해요</span></label><label class="report-radio-row"><input
							type="radio" name="profile-report-reason" value="r1"><span
							class="report-radio-ui" aria-hidden="true"></span><span>프로필
								사진이 부적절해요</span></label><label class="report-radio-row"><input
							type="radio" name="profile-report-reason" value="r2"><span
							class="report-radio-ui" aria-hidden="true"></span><span>게시글
								또는 게시물 내용이 부적절해요</span></label><label class="report-radio-row"><input
							type="radio" name="profile-report-reason" value="r3"><span
							class="report-radio-ui" aria-hidden="true"></span><span>스팸
								또는 광고 계정이에요</span></label><label class="report-radio-row"><input
							type="radio" name="profile-report-reason" value="r4"><span
							class="report-radio-ui" aria-hidden="true"></span><span>다른
								사람을 사칭하고 있어요</span></label><label class="report-radio-row"><input
							type="radio" name="profile-report-reason" value="r5"><span
							class="report-radio-ui" aria-hidden="true"></span><span>개인정보
								노출 또는 도용이 의심돼요</span></label><label class="report-radio-row"><input
							type="radio" name="profile-report-reason" value="r6"><span
							class="report-radio-ui" aria-hidden="true"></span><span>기타</span></label>
					</fieldset>
					<label class="report-detail-label" for="profile-report-detail">상세
						내용 <span>(선택)</span>
					</label>
					<textarea id="profile-report-detail" maxlength="300"
						placeholder="신고 사유에 대해 자세히 설명해 주세요."></textarea>
					<div class="report-char-count">0/300</div>
				</div>
				<div class="report-modal-footer">
					<button type="button" class="report-cancel-btn"
						data-modal-close="reportModal">취소</button>
					<button type="submit" class="report-submit-btn">신고하기</button>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="/common/footer.jsp" /></body>
</html>