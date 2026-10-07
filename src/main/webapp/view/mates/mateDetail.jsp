<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.setAttribute("activePage", "mate");%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>여행 메이트 상세 | Planb</title>
	<jsp:include page="/common/headStyles.jsp" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/view/assets/css/mates/mateDetail.css">
	<script defer src="${pageContext.request.contextPath}/view/assets/js/mates/mateDetail.js?v=3"></script>
	
</head>
<body class="site-shell">
	<jsp:include page="/common/header.jsp" />
	<div class="min-h-screen" style="background-color: #f5f5fb;">
		<div class="w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
			<!-- 목록으로 -->
			<a href="${pageContext.request.contextPath}/mates"
				class="flex items-center gap-2 px-4 py-2 rounded-full 
				       bg-white border border-gray-200 text-sm font-semibold 
				       text-gray-600 hover:border-gray-400 hover:text-gray-800 
				       transition-colors shadow-sm mb-6">
				<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
					<path d="M15 18l-6-6 6-6" />
				</svg>
				목록으로
			</a>
			<div class="flex gap-6 items-start">
				<!-- ================================
				     좌측 광고
				================================ -->
				<div class="hidden lg:flex flex-col items-center justify-center gap-3 rounded-2xl shrink-0"
					 style="width: 160px; min-height: 600px; background-color: var(--brand-light); color: var(--brand);">
					<div class="w-12 h-12 rounded-full flex items-center justify-center font-extrabold text-sm text-white"
						 style="background-color: var(--brand);">
						AD
					</div>
					<p class="text-xs font-semibold text-center px-3" style="color: var(--brand);">
						좌측 광고 영역
						<br>
						<span class="text-[10px] font-normal opacity-60">
							(예: 160x600)
						</span>
					</p>
				</div>
				<!-- ================================
				     중앙 콘텐츠
				================================ -->
				<div class="flex-1 min-w-0">
					<div class="bg-white rounded-3xl shadow-sm border border-gray-100 overflow-hidden">
						<!-- ================================
						     대표 이미지 + 제목
						================================ -->
						<div class="relative overflow-hidden mate-detail-hero">
							<c:choose>
								<c:when test="${not empty mate.img}">
									<img src="${pageContext.request.contextPath}${mate.img}"
										 alt="${mate.title}"
										 class="absolute inset-0 w-full h-full object-cover">
								</c:when>
								<c:otherwise>
									<div class="absolute inset-0 flex items-center justify-center bg-gray-100 text-gray-400">
										이미지 없음
									</div>
								</c:otherwise>
							</c:choose>
							<div class="absolute inset-0"
								style="background: linear-gradient(to top, rgba(20, 12, 60, .8) 0%, 
								                   rgba(99, 105, 209, .2) 55%, transparent 100%);">
							</div>
							<div class="absolute bottom-6 left-7 right-7">
								<div class="flex items-center gap-2 mb-2 flex-wrap">
									<span class="text-xs font-bold px-3 py-1 rounded-full"
										  style="color: #6369D1; background-color: #eeeffe;">
										여행 메이트
									</span>
									<span class="text-white/80 text-xs flex items-center gap-1">
										<svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
											<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" />
											<circle cx="12" cy="10" r="3" />
										</svg>
										<c:out value="${mate.country}" />
									</span>
								</div>
								<h1 class="text-white text-xl md:text-2xl font-extrabold leading-snug">
									<c:out value="${mate.title}" />
								</h1>
							</div>
						</div>
						<div class="p-5 sm:p-6 md:p-7">
							<!-- ================================
							     작성자
							================================ -->
							<div class="flex items-center justify-between gap-4 mb-7 pb-6 border-b border-gray-100">
								<div class="flex items-center gap-3 min-w-0">
									<div class="w-10 h-10 rounded-full shrink-0 flex items-center justify-center text-white font-bold text-sm"
										 style="background: linear-gradient(135deg, #6369D1, #8B5CF6);">
										<c:choose>
											<c:when test="${not empty mate.nickname}">
												<c:out value="${mate.nickname.substring(0, 1)}" />
											</c:when>
											<c:otherwise>
												U
											</c:otherwise>
										</c:choose>
									</div>
									<div class="min-w-0">
										<p class="font-bold text-sm text-gray-900 truncate">
											<c:choose>
												<c:when test="${not empty mate.nickname}">
													<c:out value="${mate.nickname}" />
												</c:when>
												<c:otherwise>
													사용자
												</c:otherwise>
											</c:choose>
										</p>
										<p class="text-xs text-gray-400">
											<c:out value="${mate.timeAgo}" />
										</p>
									</div>
								</div>
								<div class="flex items-center gap-4 text-sm text-gray-400">
									<span class="flex items-center gap-1.5">
										<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
											<path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z" />
											<circle cx="12" cy="12" r="3" />
										</svg>
										<c:out value="${mate.viewCount}" />
									</span>
								</div>
							</div>
							<!-- ================================
							     여행 메이트 정보
							================================ -->
							<div class="mate-detail-info-grid">
								<!-- 여행지 -->
								<div class="mate-detail-info-item">
									<div class="mate-detail-info-icon">
										📍
									</div>
									<span class="mate-detail-info-label">
										여행지
									</span>
									<strong class="mate-detail-info-value">
										<c:out value="${mate.country}" />
									</strong>
								</div>
								<!-- 작성일 -->
								<div class="mate-detail-info-item">
									<div class="mate-detail-info-icon">
										📅
									</div>
									<span class="mate-detail-info-label">
										작성일
									</span>
									<strong class="mate-detail-info-value">
										<c:out value="${mate.formattedCreatedAt}" />
									</strong>
								</div>
								<!-- 모집 인원 -->
								<div class="mate-detail-info-item">
									<div class="mate-detail-info-icon">
										👥
									</div>
									<span class="mate-detail-info-label">
										모집 인원
									</span>
									<strong class="mate-detail-info-value">
										<c:out value="${mate.recruitCount}" />명
									</strong>
								</div>
								<!-- 조회수 -->
								<div class="mate-detail-info-item">
									<div class="mate-detail-info-icon">
										👁
									</div>
									<span class="mate-detail-info-label">
										조회수
									</span>
									<strong class="mate-detail-info-value">
										<c:out value="${mate.viewCount}" />
									</strong>
								</div>
							</div>
							<!-- ================================
							     본문
							================================ -->
							<div class="mate-detail-content">
								<p class="text-gray-700 text-base leading-relaxed whitespace-pre-wrap"><c:out value="${mate.content}" /></p>
							</div>
							<!-- ================================
							     추가 이미지
							     첫 번째 이미지는 대표 이미지이므로 제외
							================================ -->
							<c:if test="${not empty mateMediaList}">
								<div class="mate-detail-images">
									<c:forEach var="media" items="${mateMediaList}" varStatus="status">
										<c:if test="${status.index > 0 && media.mediaType eq 'IMAGE'}">
											<img src="${pageContext.request.contextPath}${media.mediaUrl}"
												 alt="여행 메이트 추가 이미지"
												 class="mate-detail-image">
										</c:if>
									</c:forEach>
								</div>
							</c:if>
							<!-- ================================
							     모집 상태
							================================ -->
							<div class="mate-detail-recruit-status">
							
								<c:choose>
							
									<c:when test="${mate.recruitStatus eq 'OPEN'}">
							
										<span class="mate-recruit-badge open">
											모집중
										</span>
							
									</c:when>
							
									<c:otherwise>
							
										<span class="mate-recruit-badge closed">
											모집완료
										</span>
							
									</c:otherwise>
							
								</c:choose>
							
							</div>
							
							
							<!-- ================================
							     좋아요 / 작성자 관리
							================================ -->
							<div class="mate-detail-actions">
							
								<!-- 좋아요 -->
								<div class="mate-detail-like-area">
							
									<c:choose>
							
										<c:when test="${not empty sessionScope.user}">
							
											<form
												id="mateLikeForm"
												class="mate-like-form">
											
												<input
													type="hidden"
													id="mateLikeMateId"
													name="mateId"
													value="${mate.mateId}">
											
												<button
													type="button"
													id="mateLikeButton"
													class="mate-like-btn ${liked ? 'active' : ''}">
											
													<svg
														class="mate-like-icon"
														viewBox="0 0 24 24"
														fill="${liked ? 'currentColor' : 'none'}"
														stroke="currentColor"
														stroke-width="2">
											
														<path
															d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
											
													</svg>
											
													<span>좋아요</span>
											
													<strong id="mateLikeCount">
														<c:out value="${mateLikeCount}" />
													</strong>
											
												</button>
											
											</form>
							
										</c:when>
							
										<c:otherwise>
							
											<div class="mate-like-btn disabled">
							
												<svg
													viewBox="0 0 24 24"
													fill="none"
													stroke="currentColor"
													stroke-width="2">
							
													<path
														d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
							
												</svg>
							
												<span>좋아요</span>
							
												<strong>
													<c:out value="${mateLikeCount}" />
												</strong>
							
											</div>
							
										</c:otherwise>
							
									</c:choose>
							
								</div>
							
							
								<!-- 작성자만 수정 / 삭제 -->
								<c:if test="${not empty sessionScope.user && sessionScope.user.userId eq mate.userId}">
							
									<div class="mate-detail-owner-actions">
							
										<a
											href="${pageContext.request.contextPath}/mateModify?mateId=${mate.mateId}"
											class="mate-detail-edit-btn">
							
											<svg
												viewBox="0 0 24 24"
												fill="none"
												stroke="currentColor"
												stroke-width="2">
							
												<path d="M12 20h9" />
												<path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L7 19l-4 1 1-4Z" />
							
											</svg>
							
											수정하기
							
										</a>
							
										<button
											type="button"
											id="mateDeleteButton"
											class="mate-detail-delete-btn"
											data-mate-id="${mate.mateId}">
							
											<svg
												viewBox="0 0 24 24"
												fill="none"
												stroke="currentColor"
												stroke-width="2">
							
												<path d="M3 6h18" />
												<path d="M8 6V4h8v2" />
												<path d="M19 6l-1 14H6L5 6" />
							
											</svg>
							
											삭제하기
							
										</button>
							
									</div>
							
								</c:if>
							
							</div>
						</div>
					</div>
					<!-- ================================
						     댓글
						================================ -->
						<div class="mate-comment-section">
						
							<!-- 댓글 제목 -->
							<div class="mate-comment-header">
						
								<h3>
									댓글
									<span id="mateCommentCount">
										<c:out value="${mateCommentList.size()}" />
									</span>
								</h3>
						
							</div>
						
							<!-- 댓글 목록 -->
							<div
								class="mate-comment-list"
								id="mateCommentList">
						
								<!-- 댓글 없음 -->
								<c:if test="${empty mateCommentList}">
									<div class="mate-comment-empty">
										아직 작성된 댓글이 없습니다.
									</div>
								</c:if>
						
								<!-- 댓글 -->
								<c:forEach
									var="comment"
									items="${mateCommentList}">
						
									<div
										class="mate-comment-item"
										data-comment-id="${comment.commentId}">
						
										<!-- 프로필 -->
										<div class="mate-comment-avatar">
											<c:out value="${comment.nickname.substring(0, 1)}" />
										</div>
						
										<!-- 댓글 정보 -->
										<div class="mate-comment-body">
						
											<div class="mate-comment-top">
						
												<div class="mate-comment-user">
						
													<strong>
														<c:out value="${comment.nickname}" />
													</strong>
						
													<span class="mate-comment-time">
														<c:out value="${comment.timeAgo}" />
						
														<c:if test="${comment.edited}">
															<span class="mate-comment-edited">
																(수정됨)
															</span>
														</c:if>
													</span>
						
												</div>
						
												<!-- 본인 댓글 수정 / 삭제 -->
												<c:if test="${not empty sessionScope.user && sessionScope.user.userId eq comment.userId}">
						
													<div class="mate-comment-actions">
						
														<button
															type="button"
															class="mate-comment-edit">
															수정
														</button>
						
														<button
															type="button"
															class="mate-comment-delete">
															삭제
														</button>
						
													</div>
						
												</c:if>
						
											</div>
						
											<!-- 댓글 내용 -->
											<p class="mate-comment-content">
												<c:out value="${comment.content}" />
											</p>
						
										</div>
						
									</div>
						
								</c:forEach>
						
							</div>
						
							<!-- ================================
							     댓글 작성
							================================ -->
							<c:choose>
						
								<c:when test="${not empty sessionScope.user}">
						
									<form
										id="mateCommentForm"
										class="mate-comment-form"
										action="${pageContext.request.contextPath}/mateCommentWrite"
										method="post">
						
										<input
											type="hidden"
											name="mateId"
											value="${mate.mateId}">
						
										<textarea
											id="mateCommentContent"
											name="content"
											maxlength="1000"
											placeholder="댓글을 입력해주세요..."></textarea>
						
										<div class="mate-comment-form-bottom">
						
											<span class="mate-comment-length">
												<span id="mateCommentLength">0</span>/1000
											</span>
						
											<button
												type="submit"
												class="mate-comment-submit">
												댓글 등록
											</button>
						
										</div>
						
									</form>
						
								</c:when>
						
								<c:otherwise>
						
									<div class="mate-comment-empty">
										댓글을 작성하려면 로그인이 필요합니다.
									</div>
						
								</c:otherwise>
						
							</c:choose>
						
						</div>
				</div>
				<!-- ================================
				     우측 광고
				================================ -->
				<div class="hidden lg:flex flex-col items-center justify-center gap-3 rounded-2xl shrink-0"
					style="width: 160px; min-height: 600px; background-color: var(--brand-light); color: var(--brand);">
					<div class="w-12 h-12 rounded-full flex items-center justify-center font-extrabold text-sm text-white"
						style="background-color: var(--brand);">
						AD
					</div>
					<p class="text-xs font-semibold text-center px-3" style="color: var(--brand);">
						우측 광고 영역
						<br>
						<span class="text-[10px] font-normal opacity-60">
							(예: 160x600)
						</span>
					</p>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/common/footer.jsp" />
</body>
</html>