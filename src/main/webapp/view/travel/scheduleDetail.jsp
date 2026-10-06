<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
request.setAttribute("activePage", "travel");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title><c:out value="${itinerary.title}" /> | Planb</title>
<jsp:include page="/common/headStyles.jsp" />
</head>
<body class="site-shell"><jsp:include page="/common/header.jsp" />
	<main class="relative"
		style="height: calc(100vh - 68px); background: #f9f9fc; overflow: hidden">
		<div class="absolute inset-0">
			<div class="relative w-full h-full">
				<div id="detailGoogleMap" class="w-full h-full"
					style="background: #e8eef4"></div>
				<div class="absolute top-4 right-4 z-20">
					<button type="button"
						class="flex items-center gap-2 min-w-[116px] justify-between rounded-xl border bg-white/95 px-3.5 py-2.5 text-xs font-bold shadow-lg backdrop-blur-sm transition-all hover:shadow-xl"
						style="border-color: #D1D2F9; color: #6369D1">
						<span class="flex items-center gap-2"><span
							class="w-2 h-2 rounded-full" style="background: #6369D1"></span>전체</span>
						<svg class="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none"
							stroke="currentColor" stroke-width="2.5">
							<path d="m6 9 6 6 6-6" /></svg>
					</button>
				</div>
			</div>
		</div>
		<button id="detailPanelToggle" type="button"
			class="absolute z-30 flex h-10 w-10 items-center justify-center rounded-full border bg-white shadow-lg transition-all duration-300"
			style="top: 50%; left: 40%; transform: translate(-50%, -50%); border-color: #D1D2F9; color: #6369D1; transition-property: left, transform, box-shadow"
			title="패널 접기" aria-label="패널 접기">
			<svg class="h-4 w-4" fill="none" stroke="currentColor"
				viewBox="0 0 24 24">
				<path id="detailPanelChevron" stroke-linecap="round"
					stroke-linejoin="round" stroke-width="2.5" d="M15 6l-6 6 6 6" /></svg>
		</button>
		<div id="detailLeftPanel"
			class="absolute top-0 left-0 bottom-0 z-20 flex flex-col overflow-hidden"
			style="width: 40%; transition: width .3s cubic-bezier(.4, 0, .2, 1); background: white; box-shadow: 4px 0 24px rgba(0, 0, 0, .12); pointer-events: auto">
			<div class="overflow-y-auto flex-1 flex flex-col"
				style="min-width: 340px">
				<div
					class="sticky top-0 z-20 bg-white/90 backdrop-blur-sm border-b px-5 py-3 flex items-center gap-3"
					style="border-color: #D1D2F9">
					<a href="${pageContext.request.contextPath}/schedules"
						class="flex items-center gap-1.5 text-[12.5px] font-semibold text-gray-500 hover:text-gray-900 transition-colors"><svg
							class="w-4 h-4" fill="none" stroke="currentColor"
							viewBox="0 0 24 24">
							<path stroke-linecap="round" stroke-linejoin="round"
								stroke-width="2" d="M15 19l-7-7 7-7" /></svg>목록으로</a><span
						class="text-gray-300">|</span>
					<nav
						class="flex items-center gap-1 text-[11.5px] text-gray-400 min-w-0">
						<a href="${pageContext.request.contextPath}/schedules"
							class="hover:text-gray-600 shrink-0">여행일정</a><span
							class="shrink-0">›</span> <span
							class="text-gray-700 font-medium truncate"> <c:out
								value="${itinerary.title}" />
						</span>
					</nav>
					<div class="ml-auto flex items-center gap-1.5 shrink-0">
						<button
							class="w-8 h-8 rounded-full border flex items-center justify-center text-gray-400 hover:text-gray-700 hover:border-gray-300 transition-all"
							style="border-color: #D1D2F9" title="공유">
							<svg class="w-3.5 h-3.5" fill="none" stroke="currentColor"
								viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round"
									stroke-width="2"
									d="M8.684 13.342C8.886 12.938 9 12.482 9 12c0-.482-.114-.938-.316-1.342m0 2.684a3 3 0 110-2.684m0 2.684l6.632 3.316m-6.632-6l6.632-3.316m0 0a3 3 0 105.367-2.684 3 3 0 00-5.367 2.684zm0 9.316a3 3 0 105.368 2.684 3 3 0 00-5.368-2.684z" /></svg>
						</button>
						<c:if
							test="${empty sessionScope.user or itinerary.userId ne sessionScope.user.userId}">

							<button type="button" id="scheduleBookmarkButton"
								data-bookmark-url="${pageContext.request.contextPath}/itinerary/bookmark"
								data-itinerary-id="${itinerary.itineraryId}"
								data-logged-in="${not empty sessionScope.user}"
								data-login-url="${pageContext.request.contextPath}/auth/login"
								aria-pressed="${itinerary.bookmarked}"
								aria-label="${itinerary.bookmarked ? '북마크 해제' : '북마크 추가'}"
								title="${itinerary.bookmarked ? '북마크 해제' : '북마크 추가'}"
								class="w-8 h-8 rounded-full border flex items-center justify-center transition-all"
								style="border-color: #D1D2F9; background: white">

								<svg class="w-3.5 h-3.5" viewBox="0 0 24 24"
									fill="${itinerary.bookmarked ? '#6369D1' : 'none'}"
									stroke="#6369D1" stroke-width="2" aria-hidden="true">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" />
        						</svg>
							</button>

						</c:if>
					</div>
				</div>
				<div class="relative w-full overflow-hidden"
					style="aspect-ratio: 16/7; flex-shrink: 0">
					<c:choose>
						<c:when test="${not empty itinerary.thumbnailImg}">

							<c:choose>
								<c:when test="${itinerary.thumbnailImg.startsWith('/')}">
									<c:url var="detailThumbnailUrl"
										value="${itinerary.thumbnailImg}" />
								</c:when>

								<c:otherwise>
									<c:url var="detailThumbnailUrl"
										value="/${itinerary.thumbnailImg}" />
								</c:otherwise>
							</c:choose>

							<img src="<c:out value='${detailThumbnailUrl}'/>"
								alt="<c:out value='${itinerary.title}'/>"
								class="w-full h-full object-cover">

						</c:when>

						<c:otherwise>
							<div class="w-full h-full flex items-center justify-center"
								style="background: #F0F0FF; color: #6369D1">여행 일정</div>
						</c:otherwise>
					</c:choose>
					<!-- <img
						src="https://images.unsplash.com/photo-1628411848698-e3b3249a272a?w=600&h=400&fit=crop"
						alt="제주도 2박 3일 힐링 여행" class="w-full h-full object-cover"> -->
					<div
						class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent"></div>
					<span
						class="absolute top-4 left-4 text-[11px] font-bold px-2.5 py-1 rounded-full text-white"
						style="background: #6369D1"> 🌏 <c:out
							value="${itinerary.country}" /> <c:if
							test="${not empty itinerary.city}">
			        		· <c:out value="${itinerary.city}" />
						</c:if>
					</span> <span
						class="absolute bottom-4 left-4 text-white text-xs font-bold bg-black/50 rounded-full px-2.5 py-1">
						<c:out value="${itinerary.durationText}" />
					</span>
					<div class="absolute right-4 bottom-4 z-10">
						<button type="button"
							class="group flex items-center gap-2 rounded-2xl border border-white/70 bg-black/45 p-1.5 pr-2 backdrop-blur-md shadow-lg transition-all hover:bg-black/60">
							<div class="flex -space-x-2">
								<span
									class="relative block h-9 w-9 overflow-hidden rounded-lg border-2 border-white shadow-sm"><img
									src="https://images.unsplash.com/photo-1628411848698-e3b3249a272a?w=120&h=80&fit=crop"
									alt="1일차" class="h-full w-full object-cover"><span
									class="absolute bottom-0 right-0 rounded-tl-md px-1 text-[8px] font-black text-white"
									style="background: #6369D1">1</span></span> <span
									class="relative block h-9 w-9 overflow-hidden rounded-lg border-2 border-white shadow-sm"><img
									src="https://images.unsplash.com/photo-1678284949334-5f9edb02e55e?w=120&h=80&fit=crop"
									alt="2일차" class="h-full w-full object-cover"><span
									class="absolute bottom-0 right-0 rounded-tl-md px-1 text-[8px] font-black text-white"
									style="background: #ef4444">2</span></span> <span
									class="relative block h-9 w-9 overflow-hidden rounded-lg border-2 border-white shadow-sm"><img
									src="https://images.unsplash.com/photo-1616798249081-30877e213b16?w=120&h=80&fit=crop"
									alt="3일차" class="h-full w-full object-cover"><span
									class="absolute bottom-0 right-0 rounded-tl-md px-1 text-[8px] font-black text-white"
									style="background: #10b981">3</span></span>
							</div>
							<span class="text-[10px] font-bold text-white">사진 10</span>
							<svg class="h-3.5 w-3.5 text-white transition-transform"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2.5">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="m6 9 6 6 6-6" /></svg>
						</button>
					</div>
				</div>
				<div class="px-5 pt-4 pb-3 border-b" style="border-color: #D1D2F9">
					<!-- 제목 -->
					<h1 class="font-black text-[18px] leading-tight text-gray-900 mb-2">
						<c:out value="${itinerary.title}" />
					</h1>
					<!-- 내용 -->
					<p class="text-[13px] text-gray-500 leading-relaxed mb-3">
						<c:out value="${itinerary.summary}" />
					</p>
					<div class="flex items-center gap-4 mb-3">
						<div class="flex items-center gap-3 text-[12px] text-gray-500">

							<!-- 좋아요 버튼 -->
							<button type="button" id="scheduleLikeButton"
								class="flex items-center gap-1 transition-colors"
								data-login-url="${pageContext.request.contextPath}/auth/login"
								data-like-url="${pageContext.request.contextPath}/itinerary/like"
								data-itinerary-id="${itinerary.itineraryId}"
								data-logged-in="${not empty sessionScope.user}"
								aria-pressed="${itinerary.liked}"
								aria-label="${itinerary.liked ? '좋아요 취소' : '좋아요'}"
								style="color: ${itinerary.liked ? '#ef4444' : '#94a3b8'}">

								<svg class="w-3.5 h-3.5"
									fill="${itinerary.liked ? 'currentColor' : 'none'}"
									stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">

        							<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
    							</svg>

								<span id="scheduleLikeCount" class="font-semibold"> <fmt:formatNumber
										value="${itinerary.likeCount}" pattern="#,##0" />
								</span>
							</button>
							<span class="flex items-center gap-1"> <svg
									class="w-3.5 h-3.5" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
								</svg> <fmt:formatNumber
									value="${empty itinerary.viewCount ? 0 : itinerary.viewCount}"
									pattern="#,##0" />
							</span>
						</div>
					</div>
					<div class="flex flex-wrap gap-2 mb-3">

						<!-- 여행 기간 -->
						<span
							class="flex items-center gap-1 text-[12px] px-3 py-1.5 rounded-full border font-medium"
							style="border-color: #D1D2F9; background: #f5f5ff; color: #4a4a6a">
							<span>🗓️</span> <c:out value="${itinerary.durationText}" />
						</span>

						<!-- 여행 날짜 -->
						<span
							class="flex items-center gap-1 text-[12px] px-3 py-1.5 rounded-full border font-medium"
							style="border-color: #D1D2F9; background: #f5f5ff; color: #4a4a6a">
							<span>📍</span> <c:choose>
								<c:when
									test="${not empty itinerary.startDate and not empty itinerary.endDate}">
									<fmt:formatDate value="${itinerary.startDate}"
										pattern="yyyy.MM.dd" />                
									~
                					<fmt:formatDate value="${itinerary.endDate}"
										pattern="yyyy.MM.dd" />
								</c:when>
								<c:otherwise>날짜 미정</c:otherwise>
							</c:choose>
						</span>

						<!-- 여행 인원 -->
						<span
							class="flex items-center gap-1 text-[12px] px-3 py-1.5 rounded-full border font-medium"
							style="border-color: #D1D2F9; background: #f5f5ff; color: #4a4a6a">
							<span>👥</span> <c:choose>
								<c:when test="${not empty itinerary.travelerCount}">
									<c:out value="${itinerary.travelerCount}" />명
            					</c:when>
								<c:otherwise>인원 미정</c:otherwise>
							</c:choose>
						</span>

						<!-- 총 예산 -->
						<span
							class="flex items-center gap-1 text-[12px] px-3 py-1.5 rounded-full border font-medium"
							style="border-color: #D1D2F9; background: #f5f5ff; color: #4a4a6a">
							<span>💰</span> <c:choose>
								<c:when test="${not empty itinerary.totalBudget}">
									<fmt:formatNumber value="${itinerary.totalBudget}"
										pattern="#,##0" />원
            					</c:when>
								<c:otherwise>예산 미정</c:otherwise>
							</c:choose>
						</span>

					</div>
					<div class="flex gap-2">
						<button type="button" data-toast="전체 일정을 장바구니에 담았어요!"
							class="flex-1 py-2.5 rounded-xl text-[10px] font-semibold flex items-center justify-center gap-1.5 transition-all hover:opacity-90"
							style="background: #6369D1; color: white">
							<svg class="w-3.5 h-3.5 shrink-0" fill="none"
								stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round"
									stroke-width="2"
									d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13 5.4 5M7 13l-2.3 2.3c-.6.6-.2 1.7.7 1.7H17m0 0a2 2 0 100 4 2 2 0 000-4Zm-8 2a2 2 0 11-4 0 2 2 0 014 0Z" /></svg>
							전체 일정 장바구니에 담기
						</button>
						<button type="button"
							class="flex items-center gap-1 px-3 py-2.5 rounded-xl text-[12px] font-bold border transition-all hover:bg-[#FFE8DE] hover:border-[#FF8A5B] hover:text-[#D95B2B]"
							style="background: #FFF5F0; border-color: #FFB08A; color: #E76F3C">
							<svg class="w-3.5 h-3.5" fill="none" stroke="currentColor"
								viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round"
									stroke-width="2"
									d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" /></svg>
							신고
						</button>
					</div>
				</div>
				<div class="px-5 py-3 border-b flex items-center gap-3"
					style="border-color: #D1D2F9">
					<a
						href="${pageContext.request.contextPath}/view/profile/userProfile.jsp"
						class="flex items-center gap-2.5 flex-1 min-w-0 hover:opacity-75 transition-opacity text-left"><img
						src="https://i.pravatar.cc/40?img=12" alt="여행좋아"
						class="w-9 h-9 rounded-full object-cover border-2 shrink-0"
						style="border-color: #D1D2F9">
						<div class="min-w-0">
							<p class="text-[13px] font-bold text-gray-900 hover:underline">여행좋아</p>
							<p class="text-[11px] text-gray-400">2026.08.20 게시</p>
						</div></a>
				</div>
				<div class="px-5 py-3 border-b" style="border-color: #D1D2F9">
					<p
						class="text-[11px] font-bold text-gray-400 uppercase tracking-wider mb-2">사진</p>
					<div class="flex gap-2 overflow-x-auto pb-1"
						style="scrollbar-width: none">
						<div class="rounded-xl overflow-hidden shrink-0"
							style="width: 100px; height: 70px">
							<img
								src="https://images.unsplash.com/photo-1628411848698-e3b3249a272a?w=300&h=200&fit=crop"
								alt="" class="w-full h-full object-cover">
						</div>
						<div class="rounded-xl overflow-hidden shrink-0"
							style="width: 100px; height: 70px">
							<img
								src="https://images.unsplash.com/photo-1616798249081-30877e213b16?w=300&h=200&fit=crop"
								alt="" class="w-full h-full object-cover">
						</div>
						<div class="rounded-xl overflow-hidden shrink-0"
							style="width: 100px; height: 70px">
							<img
								src="https://images.unsplash.com/photo-1599840386256-807f9707efe2?w=300&h=200&fit=crop"
								alt="" class="w-full h-full object-cover">
						</div>
						<div class="rounded-xl overflow-hidden shrink-0"
							style="width: 100px; height: 70px">
							<img
								src="https://images.unsplash.com/photo-1678284949334-5f9edb02e55e?w=300&h=200&fit=crop"
								alt="" class="w-full h-full object-cover">
						</div>
					</div>
				</div>
				<div class="flex border-b sticky z-10"
					style="border-color: #D1D2F9; top: 57px; background: white">

					<button type="button" data-detail-tab="schedule"
						aria-selected="true" aria-controls="detailSchedulePanel"
						class="flex-1 py-3 text-[12.5px] font-semibold relative transition-colors whitespace-nowrap"
						style="color: #6369D1">

						일정표 <span data-detail-tab-line
							class="absolute bottom-0 left-0 right-0 h-[2.5px] rounded-t-full"
							style="background: #6369D1"></span>
					</button>

					<button type="button" data-detail-tab="comments"
						aria-selected="false" aria-controls="detailCommentPanel"
						class="flex-1 py-3 text-[12.5px] font-semibold relative transition-colors whitespace-nowrap"
						style="color: #94a3b8">

						댓글 (<span id="scheduleCommentCount"><c:out
								value="${itinerary.commentCount}" /></span>) <span
							data-detail-tab-line
							class="hidden absolute bottom-0 left-0 right-0 h-[2.5px] rounded-t-full"
							style="background: #6369D1"></span>
					</button>
				</div>
				<section id="detailCommentPanel" class="hidden p-4"
					data-itinerary-id="${itinerary.itineraryId}"
					data-logged-in="${not empty sessionScope.user}"
					data-login-user-id="${empty sessionScope.user ? '' : sessionScope.user.userId}"
					data-login-url="${pageContext.request.contextPath}/auth/login"
					data-context-path="${pageContext.request.contextPath}"
					data-write-url="${pageContext.request.contextPath}/itinerary/comment/write"
					data-delete-url="${pageContext.request.contextPath}/itinerary/comment/delete">

					<!-- 댓글 입력 -->
					<div class="rounded-2xl border p-4 mb-5"
						style="border-color: #D1D2F9; background: #fafafa">

						<textarea id="scheduleCommentContent" aria-label="댓글 내용"
							placeholder="여행 일정에 대한 댓글을 남겨보세요..."
							class="w-full bg-transparent text-[13px] outline-none resize-none"
							style="min-height: 110px"></textarea>

						<div class="flex items-center justify-between mt-3">
							<span class="text-[11px] text-gray-400"> <span
								id="scheduleCommentLength">0</span> / 1,000
							</span>

							<button type="button" id="scheduleCommentSubmit"
								class="px-5 py-2 rounded-xl text-[13px] font-bold text-white transition-opacity"
								style="background: #6369D1">등록</button>
						</div>
					</div>

					<!-- 댓글 목록 -->
					<div id="scheduleCommentList" class="space-y-5">

						<c:if test="${empty comments}">
							<p class="py-5 text-center text-[12px] text-gray-400">아직 댓글이
								없습니다.</p>
						</c:if>

						<c:forEach var="comment" items="${comments}">

							<article class="flex items-start gap-3">

								<!-- 작성자 사진 -->
								<div
									class="w-10 h-10 rounded-full overflow-hidden shrink-0 flex items-center justify-center"
									style="background: #F0F0FF; color: #6369D1">

									<c:choose>
										<c:when test="${not empty comment.profileImg}">

											<c:choose>
												<c:when
													test="${comment.profileImg.startsWith('https://')
                                    or comment.profileImg.startsWith('http://')}">
													<c:set var="commentProfileUrl"
														value="${comment.profileImg}" />
												</c:when>

												<c:when test="${comment.profileImg.startsWith('/')}">
													<c:url var="commentProfileUrl"
														value="${comment.profileImg}" />
												</c:when>

												<c:otherwise>
													<c:url var="commentProfileUrl"
														value="/${comment.profileImg}" />
												</c:otherwise>
											</c:choose>

											<img src="<c:out value='${commentProfileUrl}'/>"
												alt="작성자 프로필" class="w-full h-full object-cover">
										</c:when>

										<c:otherwise>
											<svg width="22" height="22" viewBox="0 0 24 24" fill="none"
												stroke="currentColor" stroke-width="2" aria-hidden="true">
                                <circle cx="12" cy="8" r="4" />
                                <path d="M4 21v-2a8 8 0 0 1 16 0v2" />
                            </svg>
										</c:otherwise>
									</c:choose>
								</div>

								<div class="flex-1 min-w-0">

									<div class="flex items-center gap-2 flex-wrap">
										<span class="font-bold text-[13px] text-gray-900"> <c:out
												value="${comment.nickname}" />
										</span> <span class="text-[11px] text-gray-400"> <fmt:formatDate
												value="${comment.createdAt}" pattern="yyyy.MM.dd HH:mm" />
										</span>

										<c:if
											test="${not empty sessionScope.user
                            and comment.userId eq sessionScope.user.userId}">
											<button type="button" data-comment-delete
												data-comment-id="${comment.commentId}"
												class="ml-auto text-[11px] text-gray-400 hover:text-red-500">
												삭제</button>
										</c:if>
									</div>

									<p class="mt-1 text-[13px] text-gray-600"
										style="white-space: pre-wrap; overflow-wrap: anywhere;">
										<c:out value="${comment.content}" />
									</p>
								</div>
							</article>

						</c:forEach>
					</div>
				</section>
				<div id="detailSchedulePanel" class="p-4 space-y-3">
					<div class="rounded-2xl border overflow-hidden"
						style="border-color: #D1D2F9">
						<div
							class="flex items-center gap-3 px-4 py-3 cursor-pointer hover:opacity-90 transition-opacity"
							style="background: rgba(99, 105, 209, .071)">
							<div
								class="w-8 h-8 rounded-full flex items-center justify-center text-white text-[13px] font-black shrink-0"
								style="background: #6369D1">1</div>
							<div class="flex-1 min-w-0">
								<span class="font-black text-[13.5px]" style="color: #6369D1">Day
									1</span><span class="text-gray-400 text-[11px] ml-2">2026.10.03
									(토)</span>
							</div>
							<button data-toast="1일차 일정을 장바구니에 담았어요!"
								class="flex items-center gap-1 text-[8px] font-bold px-2.5 py-1 rounded-full border transition-all shrink-0"
								style="border-color: #e4e4f0; color: #94a3b8; background: white">
								<svg class="w-3 h-3" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2.5"
										d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13 5.4 5M7 13l-2.3 2.3c-.6.6-.2 1.7.7 1.7H17m0 0a2 2 0 100 4 2 2 0 000-4Zm-8 2a2 2 0 11-4 0 2 2 0 014 0Z" /></svg>
								담기
							</button>
							<svg class="w-4 h-4 text-gray-400 transition-transform shrink-0"
								style="transform: rotate(180deg)" fill="none"
								stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round"
									stroke-width="2" d="M19 9l-7 7-7-7" /></svg>
						</div>
						<div class="px-4 pb-3 pt-1">
							<div class="flex gap-3 relative pt-3">
								<div class="flex flex-col items-center shrink-0"
									style="width: 18px">
									<div
										class="w-3 h-3 rounded-full border-2 border-white shrink-0"
										style="background: #6369D1; box-shadow: 0 0 0 2px #6369D140; margin-top: 2px"></div>
									<div class="flex-1 w-0.5 mt-1"
										style="background: #6369D130; min-height: 28px"></div>
								</div>
								<div class="flex-1 min-w-0 pb-1">
									<div class="flex items-start gap-2">
										<div class="flex-1 min-w-0">
											<div class="flex items-center gap-2 mb-0.5 flex-wrap">
												<span
													class="text-[10.5px] font-mono shrink-0 px-1.5 py-0.5 rounded-md font-bold"
													style="background: #6369D115; color: #6369D1">11:00</span><span
													class="font-bold text-[13px] text-gray-900 leading-tight">제주공항
													도착</span>
											</div>
											<p class="text-[11.5px] text-gray-500 leading-relaxed">렌터카
												수령 후 출발!</p>
											<a href="https://www.airport.co.kr" target="_blank"
												rel="noopener noreferrer"
												class="inline-flex items-center gap-1 text-[10.5px] mt-1 font-medium transition-colors hover:underline"
												style="color: #6369D1"><svg class="w-3 h-3" fill="none"
													stroke="currentColor" viewBox="0 0 24 24">
													<path stroke-linecap="round" stroke-linejoin="round"
														stroke-width="2"
														d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" /></svg>공식
												사이트</a>
										</div>
										<div class="flex flex-col items-end gap-2 shrink-0">
											<img
												src="https://images.unsplash.com/photo-1628411848698-e3b3249a272a?w=120&h=80&fit=crop"
												alt="제주공항 도착" class="rounded-xl object-cover"
												style="width: 72px; height: 52px">
											<button data-toast="&quot;제주공항 도착&quot;을(를) 장바구니에 담았어요!"
												class="flex items-center gap-1 text-[8px] font-bold px-2 py-1 rounded-full border transition-all"
												style="border-color: #e4e4f0; color: #94a3b8; background: white">
												<svg class="w-2.5 h-2.5" fill="none" stroke="currentColor"
													viewBox="0 0 24 24">
													<path stroke-linecap="round" stroke-linejoin="round"
														stroke-width="2.5" d="M12 4v16m8-8H4" /></svg>
												담기
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="flex gap-3 relative pt-3">
								<div class="flex flex-col items-center shrink-0"
									style="width: 18px">
									<div
										class="w-3 h-3 rounded-full border-2 border-white shrink-0"
										style="background: #6369D1; box-shadow: 0 0 0 2px #6369D140; margin-top: 2px"></div>
									<div class="flex-1 w-0.5 mt-1"
										style="background: #6369D130; min-height: 28px"></div>
								</div>
								<div class="flex-1 min-w-0 pb-1">
									<div class="flex items-start gap-2">
										<div class="flex-1 min-w-0">
											<div class="flex items-center gap-2 mb-0.5 flex-wrap">
												<span
													class="text-[10.5px] font-mono shrink-0 px-1.5 py-0.5 rounded-md font-bold"
													style="background: #6369D115; color: #6369D1">12:00</span><span
													class="font-bold text-[13px] text-gray-900 leading-tight">흑돼지
													맛집 점심</span>
											</div>
											<p class="text-[11.5px] text-gray-500 leading-relaxed">제주
												돈사돈 본점 · 웨이팅 있지만 기다릴만해요.</p>
										</div>
										<div class="flex flex-col items-end gap-2 shrink-0">
											<img
												src="https://images.unsplash.com/photo-1544025162-d76694265947?w=120&h=80&fit=crop"
												alt="흑돼지 맛집 점심" class="rounded-xl object-cover"
												style="width: 72px; height: 52px">
											<button data-toast="&quot;흑돼지 맛집 점심&quot;을(를) 장바구니에 담았어요!"
												class="flex items-center gap-1 text-[8px] font-bold px-2 py-1 rounded-full border transition-all"
												style="border-color: #e4e4f0; color: #94a3b8; background: white">
												<svg class="w-2.5 h-2.5" fill="none" stroke="currentColor"
													viewBox="0 0 24 24">
													<path stroke-linecap="round" stroke-linejoin="round"
														stroke-width="2.5" d="M12 4v16m8-8H4" /></svg>
												담기
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="flex gap-3 relative pt-3">
								<div class="flex flex-col items-center shrink-0"
									style="width: 18px">
									<div
										class="w-3 h-3 rounded-full border-2 border-white shrink-0"
										style="background: #6369D1; box-shadow: 0 0 0 2px #6369D140; margin-top: 2px"></div>
									<div class="flex-1 w-0.5 mt-1"
										style="background: #6369D130; min-height: 28px"></div>
								</div>
								<div class="flex-1 min-w-0 pb-1">
									<div class="flex items-start gap-2">
										<div class="flex-1 min-w-0">
											<div class="flex items-center gap-2 mb-0.5 flex-wrap">
												<span
													class="text-[10.5px] font-mono shrink-0 px-1.5 py-0.5 rounded-md font-bold"
													style="background: #6369D115; color: #6369D1">14:00</span><span
													class="font-bold text-[13px] text-gray-900 leading-tight">성산일출봉</span>
											</div>
											<p class="text-[11.5px] text-gray-500 leading-relaxed">유네스코
												세계유산! 탁 트인 파노라마 뷰.</p>
											<a href="https://www.jeju.go.kr" target="_blank"
												rel="noopener noreferrer"
												class="inline-flex items-center gap-1 text-[10.5px] mt-1 font-medium transition-colors hover:underline"
												style="color: #6369D1"><svg class="w-3 h-3" fill="none"
													stroke="currentColor" viewBox="0 0 24 24">
													<path stroke-linecap="round" stroke-linejoin="round"
														stroke-width="2"
														d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" /></svg>공식
												사이트</a>
										</div>
										<div class="flex flex-col items-end gap-2 shrink-0">
											<img
												src="https://images.unsplash.com/photo-1599840386256-807f9707efe2?w=120&h=80&fit=crop"
												alt="성산일출봉" class="rounded-xl object-cover"
												style="width: 72px; height: 52px">
											<button data-toast="&quot;성산일출봉&quot;을(를) 장바구니에 담았어요!"
												class="flex items-center gap-1 text-[8px] font-bold px-2 py-1 rounded-full border transition-all"
												style="border-color: #e4e4f0; color: #94a3b8; background: white">
												<svg class="w-2.5 h-2.5" fill="none" stroke="currentColor"
													viewBox="0 0 24 24">
													<path stroke-linecap="round" stroke-linejoin="round"
														stroke-width="2.5" d="M12 4v16m8-8H4" /></svg>
												담기
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="flex gap-3 relative pt-3">
								<div class="flex flex-col items-center shrink-0"
									style="width: 18px">
									<div
										class="w-3 h-3 rounded-full border-2 border-white shrink-0"
										style="background: #6369D1; box-shadow: 0 0 0 2px #6369D140; margin-top: 2px"></div>
								</div>
								<div class="flex-1 min-w-0 pb-1">
									<div class="flex items-start gap-2">
										<div class="flex-1 min-w-0">
											<div class="flex items-center gap-2 mb-0.5 flex-wrap">
												<span
													class="text-[10.5px] font-mono shrink-0 px-1.5 py-0.5 rounded-md font-bold"
													style="background: #6369D115; color: #6369D1">17:00</span><span
													class="font-bold text-[13px] text-gray-900 leading-tight">광치기해변
													산책</span>
											</div>
											<p class="text-[11.5px] text-gray-500 leading-relaxed">노을
												질 때 방문하면 정말 예뻐요.</p>
										</div>
										<div class="flex flex-col items-end gap-2 shrink-0">
											<img
												src="https://images.unsplash.com/photo-1674606042265-c9f03a77e286?w=120&h=80&fit=crop"
												alt="광치기해변 산책" class="rounded-xl object-cover"
												style="width: 72px; height: 52px">
											<button data-toast="&quot;광치기해변 산책&quot;을(를) 장바구니에 담았어요!"
												class="flex items-center gap-1 text-[8px] font-bold px-2 py-1 rounded-full border transition-all"
												style="border-color: #e4e4f0; color: #94a3b8; background: white">
												<svg class="w-2.5 h-2.5" fill="none" stroke="currentColor"
													viewBox="0 0 24 24">
													<path stroke-linecap="round" stroke-linejoin="round"
														stroke-width="2.5" d="M12 4v16m8-8H4" /></svg>
												담기
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="rounded-2xl border overflow-hidden"
						style="border-color: #D1D2F9">
						<div
							class="flex items-center gap-3 px-4 py-3 cursor-pointer hover:opacity-90 transition-opacity"
							style="background: rgba(239, 68, 68, .071)">
							<div
								class="w-8 h-8 rounded-full flex items-center justify-center text-white text-[13px] font-black shrink-0"
								style="background: #ef4444">2</div>
							<div class="flex-1 min-w-0">
								<span class="font-black text-[13.5px]" style="color: #ef4444">Day
									2</span><span class="text-gray-400 text-[11px] ml-2">2026.10.04
									(일)</span>
							</div>
							<button data-toast="2일차 일정을 장바구니에 담았어요!"
								class="flex items-center gap-1 text-[8px] font-bold px-2.5 py-1 rounded-full border transition-all shrink-0"
								style="border-color: #e4e4f0; color: #94a3b8; background: white">
								<svg class="w-3 h-3" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2.5"
										d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13 5.4 5M7 13l-2.3 2.3c-.6.6-.2 1.7.7 1.7H17m0 0a2 2 0 100 4 2 2 0 000-4Zm-8 2a2 2 0 11-4 0 2 2 0 014 0Z" /></svg>
								담기
							</button>
							<svg class="w-4 h-4 text-gray-400 transition-transform shrink-0"
								style="transform: rotate(180deg)" fill="none"
								stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round"
									stroke-width="2" d="M19 9l-7 7-7-7" /></svg>
						</div>
						<div class="px-4 pb-3 pt-1">
							<div class="flex gap-3 relative pt-3">
								<div class="flex flex-col items-center shrink-0"
									style="width: 18px">
									<div
										class="w-3 h-3 rounded-full border-2 border-white shrink-0"
										style="background: #ef4444; box-shadow: 0 0 0 2px #ef444440; margin-top: 2px"></div>
									<div class="flex-1 w-0.5 mt-1"
										style="background: #ef444430; min-height: 28px"></div>
								</div>
								<div class="flex-1 min-w-0 pb-1">
									<div class="flex items-start gap-2">
										<div class="flex-1 min-w-0">
											<div class="flex items-center gap-2 mb-0.5 flex-wrap">
												<span
													class="text-[10.5px] font-mono shrink-0 px-1.5 py-0.5 rounded-md font-bold"
													style="background: #ef444415; color: #ef4444">09:00</span><span
													class="font-bold text-[13px] text-gray-900 leading-tight">섭지코지
													일출</span>
											</div>
											<p class="text-[11.5px] text-gray-500 leading-relaxed">이른
												아침의 섭지코지는 환상적이에요.</p>
										</div>
										<div class="flex flex-col items-end gap-2 shrink-0">
											<img
												src="https://images.unsplash.com/photo-1678284949334-5f9edb02e55e?w=120&h=80&fit=crop"
												alt="섭지코지 일출" class="rounded-xl object-cover"
												style="width: 72px; height: 52px">
											<button data-toast="&quot;섭지코지 일출&quot;을(를) 장바구니에 담았어요!"
												class="flex items-center gap-1 text-[8px] font-bold px-2 py-1 rounded-full border transition-all"
												style="border-color: #e4e4f0; color: #94a3b8; background: white">
												<svg class="w-2.5 h-2.5" fill="none" stroke="currentColor"
													viewBox="0 0 24 24">
													<path stroke-linecap="round" stroke-linejoin="round"
														stroke-width="2.5" d="M12 4v16m8-8H4" /></svg>
												담기
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="flex gap-3 relative pt-3">
								<div class="flex flex-col items-center shrink-0"
									style="width: 18px">
									<div
										class="w-3 h-3 rounded-full border-2 border-white shrink-0"
										style="background: #ef4444; box-shadow: 0 0 0 2px #ef444440; margin-top: 2px"></div>
									<div class="flex-1 w-0.5 mt-1"
										style="background: #ef444430; min-height: 28px"></div>
								</div>
								<div class="flex-1 min-w-0 pb-1">
									<div class="flex items-start gap-2">
										<div class="flex-1 min-w-0">
											<div class="flex items-center gap-2 mb-0.5 flex-wrap">
												<span
													class="text-[10.5px] font-mono shrink-0 px-1.5 py-0.5 rounded-md font-bold"
													style="background: #ef444415; color: #ef4444">11:00</span><span
													class="font-bold text-[13px] text-gray-900 leading-tight">카페
													오션뷰</span>
											</div>
											<p class="text-[11.5px] text-gray-500 leading-relaxed">바다가
												보이는 감성 카페에서 브런치!</p>
										</div>
										<div class="flex flex-col items-end gap-2 shrink-0">
											<img
												src="https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=120&h=80&fit=crop"
												alt="카페 오션뷰" class="rounded-xl object-cover"
												style="width: 72px; height: 52px">
											<button data-toast="&quot;카페 오션뷰&quot;을(를) 장바구니에 담았어요!"
												class="flex items-center gap-1 text-[8px] font-bold px-2 py-1 rounded-full border transition-all"
												style="border-color: #e4e4f0; color: #94a3b8; background: white">
												<svg class="w-2.5 h-2.5" fill="none" stroke="currentColor"
													viewBox="0 0 24 24">
													<path stroke-linecap="round" stroke-linejoin="round"
														stroke-width="2.5" d="M12 4v16m8-8H4" /></svg>
												담기
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="flex gap-3 relative pt-3">
								<div class="flex flex-col items-center shrink-0"
									style="width: 18px">
									<div
										class="w-3 h-3 rounded-full border-2 border-white shrink-0"
										style="background: #ef4444; box-shadow: 0 0 0 2px #ef444440; margin-top: 2px"></div>
									<div class="flex-1 w-0.5 mt-1"
										style="background: #ef444430; min-height: 28px"></div>
								</div>
								<div class="flex-1 min-w-0 pb-1">
									<div class="flex items-start gap-2">
										<div class="flex-1 min-w-0">
											<div class="flex items-center gap-2 mb-0.5 flex-wrap">
												<span
													class="text-[10.5px] font-mono shrink-0 px-1.5 py-0.5 rounded-md font-bold"
													style="background: #ef444415; color: #ef4444">14:00</span><span
													class="font-bold text-[13px] text-gray-900 leading-tight">한라산
													국립공원 트래킹</span>
											</div>
											<p class="text-[11.5px] text-gray-500 leading-relaxed">영실코스
												추천! 약 3시간 소요.</p>
											<a href="https://www.hallasan.go.kr" target="_blank"
												rel="noopener noreferrer"
												class="inline-flex items-center gap-1 text-[10.5px] mt-1 font-medium transition-colors hover:underline"
												style="color: #6369D1"><svg class="w-3 h-3" fill="none"
													stroke="currentColor" viewBox="0 0 24 24">
													<path stroke-linecap="round" stroke-linejoin="round"
														stroke-width="2"
														d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" /></svg>공식
												사이트</a>
										</div>
										<div class="flex flex-col items-end gap-2 shrink-0">
											<img
												src="https://images.unsplash.com/photo-1674606042265-c9f03a77e286?w=120&h=80&fit=crop"
												alt="한라산 국립공원 트래킹" class="rounded-xl object-cover"
												style="width: 72px; height: 52px">
											<button data-toast="&quot;한라산 국립공원 트래킹&quot;을(를) 장바구니에 담았어요!"
												class="flex items-center gap-1 text-[8px] font-bold px-2 py-1 rounded-full border transition-all"
												style="border-color: #e4e4f0; color: #94a3b8; background: white">
												<svg class="w-2.5 h-2.5" fill="none" stroke="currentColor"
													viewBox="0 0 24 24">
													<path stroke-linecap="round" stroke-linejoin="round"
														stroke-width="2.5" d="M12 4v16m8-8H4" /></svg>
												담기
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="flex gap-3 relative pt-3">
								<div class="flex flex-col items-center shrink-0"
									style="width: 18px">
									<div
										class="w-3 h-3 rounded-full border-2 border-white shrink-0"
										style="background: #ef4444; box-shadow: 0 0 0 2px #ef444440; margin-top: 2px"></div>
								</div>
								<div class="flex-1 min-w-0 pb-1">
									<div class="flex items-start gap-2">
										<div class="flex-1 min-w-0">
											<div class="flex items-center gap-2 mb-0.5 flex-wrap">
												<span
													class="text-[10.5px] font-mono shrink-0 px-1.5 py-0.5 rounded-md font-bold"
													style="background: #ef444415; color: #ef4444">18:00</span><span
													class="font-bold text-[13px] text-gray-900 leading-tight">흑돼지거리
													저녁</span>
											</div>
											<p class="text-[11.5px] text-gray-500 leading-relaxed">제주
												흑돼지거리에서 즐기는 저녁.</p>
										</div>
										<div class="flex flex-col items-end gap-2 shrink-0">
											<img
												src="https://images.unsplash.com/photo-1544025162-d76694265947?w=120&h=80&fit=crop"
												alt="흑돼지거리 저녁" class="rounded-xl object-cover"
												style="width: 72px; height: 52px">
											<button data-toast="&quot;흑돼지거리 저녁&quot;을(를) 장바구니에 담았어요!"
												class="flex items-center gap-1 text-[8px] font-bold px-2 py-1 rounded-full border transition-all"
												style="border-color: #e4e4f0; color: #94a3b8; background: white">
												<svg class="w-2.5 h-2.5" fill="none" stroke="currentColor"
													viewBox="0 0 24 24">
													<path stroke-linecap="round" stroke-linejoin="round"
														stroke-width="2.5" d="M12 4v16m8-8H4" /></svg>
												담기
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="rounded-2xl border overflow-hidden"
						style="border-color: #D1D2F9">
						<div
							class="flex items-center gap-3 px-4 py-3 cursor-pointer hover:opacity-90 transition-opacity"
							style="background: rgba(16, 185, 129, .071)">
							<div
								class="w-8 h-8 rounded-full flex items-center justify-center text-white text-[13px] font-black shrink-0"
								style="background: #10b981">3</div>
							<div class="flex-1 min-w-0">
								<span class="font-black text-[13.5px]" style="color: #10b981">Day
									3</span><span class="text-gray-400 text-[11px] ml-2">2026.10.05
									(월)</span>
							</div>
							<button data-toast="3일차 일정을 장바구니에 담았어요!"
								class="flex items-center gap-1 text-[8px] font-bold px-2.5 py-1 rounded-full border transition-all shrink-0"
								style="border-color: #e4e4f0; color: #94a3b8; background: white">
								<svg class="w-3 h-3" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2.5"
										d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13 5.4 5M7 13l-2.3 2.3c-.6.6-.2 1.7.7 1.7H17m0 0a2 2 0 100 4 2 2 0 000-4Zm-8 2a2 2 0 11-4 0 2 2 0 014 0Z" /></svg>
								담기
							</button>
							<svg class="w-4 h-4 text-gray-400 transition-transform shrink-0"
								style="transform: rotate(180deg)" fill="none"
								stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round"
									stroke-width="2" d="M19 9l-7 7-7-7" /></svg>
						</div>
						<div class="px-4 pb-3 pt-1">
							<div class="flex gap-3 relative pt-3">
								<div class="flex flex-col items-center shrink-0"
									style="width: 18px">
									<div
										class="w-3 h-3 rounded-full border-2 border-white shrink-0"
										style="background: #10b981; box-shadow: 0 0 0 2px #10b98140; margin-top: 2px"></div>
									<div class="flex-1 w-0.5 mt-1"
										style="background: #10b98130; min-height: 28px"></div>
								</div>
								<div class="flex-1 min-w-0 pb-1">
									<div class="flex items-start gap-2">
										<div class="flex-1 min-w-0">
											<div class="flex items-center gap-2 mb-0.5 flex-wrap">
												<span
													class="text-[10.5px] font-mono shrink-0 px-1.5 py-0.5 rounded-md font-bold"
													style="background: #10b98115; color: #10b981">10:00</span><span
													class="font-bold text-[13px] text-gray-900 leading-tight">협재해변</span>
											</div>
											<p class="text-[11.5px] text-gray-500 leading-relaxed">에메랄드빛
												제주 바다!</p>
										</div>
										<div class="flex flex-col items-end gap-2 shrink-0">
											<img
												src="https://images.unsplash.com/photo-1616798249081-30877e213b16?w=120&h=80&fit=crop"
												alt="협재해변" class="rounded-xl object-cover"
												style="width: 72px; height: 52px">
											<button data-toast="&quot;협재해변&quot;을(를) 장바구니에 담았어요!"
												class="flex items-center gap-1 text-[8px] font-bold px-2 py-1 rounded-full border transition-all"
												style="border-color: #e4e4f0; color: #94a3b8; background: white">
												<svg class="w-2.5 h-2.5" fill="none" stroke="currentColor"
													viewBox="0 0 24 24">
													<path stroke-linecap="round" stroke-linejoin="round"
														stroke-width="2.5" d="M12 4v16m8-8H4" /></svg>
												담기
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="flex gap-3 relative pt-3">
								<div class="flex flex-col items-center shrink-0"
									style="width: 18px">
									<div
										class="w-3 h-3 rounded-full border-2 border-white shrink-0"
										style="background: #10b981; box-shadow: 0 0 0 2px #10b98140; margin-top: 2px"></div>
								</div>
								<div class="flex-1 min-w-0 pb-1">
									<div class="flex items-start gap-2">
										<div class="flex-1 min-w-0">
											<div class="flex items-center gap-2 mb-0.5 flex-wrap">
												<span
													class="text-[10.5px] font-mono shrink-0 px-1.5 py-0.5 rounded-md font-bold"
													style="background: #10b98115; color: #10b981">13:00</span><span
													class="font-bold text-[13px] text-gray-900 leading-tight">우도
													당일치기</span>
											</div>
											<p class="text-[11.5px] text-gray-500 leading-relaxed">배
												타고 우도로! 땅콩아이스크림 필수.</p>
										</div>
										<div class="flex flex-col items-end gap-2 shrink-0">
											<img
												src="https://images.unsplash.com/photo-1599840386256-807f9707efe2?w=120&h=80&fit=crop"
												alt="우도 당일치기" class="rounded-xl object-cover"
												style="width: 72px; height: 52px">
											<button data-toast="&quot;우도 당일치기&quot;을(를) 장바구니에 담았어요!"
												class="flex items-center gap-1 text-[8px] font-bold px-2 py-1 rounded-full border transition-all"
												style="border-color: #e4e4f0; color: #94a3b8; background: white">
												<svg class="w-2.5 h-2.5" fill="none" stroke="currentColor"
													viewBox="0 0 24 24">
													<path stroke-linecap="round" stroke-linejoin="round"
														stroke-width="2.5" d="M12 4v16m8-8H4" /></svg>
												담기
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<script>
		(function() {
			var panel = document.getElementById('detailLeftPanel'), btn = document
					.getElementById('detailPanelToggle'), chev = document
					.getElementById('detailPanelChevron'), open = true;
			if (btn)
				btn.addEventListener('click', function() {
					open = !open;
					panel.style.width = open ? '40%' : '0%';
					panel.style.boxShadow = open ? '4px 0 24px rgba(0,0,0,.12)'
							: 'none';
					panel.style.pointerEvents = open ? 'auto' : 'none';
					btn.style.left = open ? '40%' : '0';
					btn.title = open ? '패널 접기' : '패널 펼치기';
					btn.setAttribute('aria-label', btn.title);
					chev.setAttribute('d', open ? 'M15 6l-6 6 6 6'
							: 'M9 6l6 6-6 6');
				});
			var data = [
					{
						day : 1,
						color : '#6369D1',
						items : [ [ '제주공항 도착', 33.5069, 126.4927 ],
								[ '흑돼지 맛집 점심', 33.4996, 126.5267 ],
								[ '성산일출봉', 33.4582, 126.9427 ],
								[ '광치기해변 산책', 33.4569, 126.9199 ] ]
					},
					{
						day : 2,
						color : '#ef4444',
						items : [ [ '섭지코지 일출', 33.4265, 126.9303 ],
								[ '카페 오션뷰', 33.2508, 126.5643 ],
								[ '한라산 국립공원 트래킹', 33.3617, 126.5292 ],
								[ '흑돼지거리 저녁', 33.4958, 126.5312 ] ]
					},
					{
						day : 3,
						color : '#10b981',
						items : [ [ '협재해변', 33.3942, 126.2397 ],
								[ '우도 당일치기', 33.5013, 126.9516 ] ]
					} ];
			function initDetailMap() {
				if (!window.google || !google.maps
						|| !document.getElementById('detailGoogleMap'))
					return;
				var all = [];
				data.forEach(function(d) {
					d.items.forEach(function(x) {
						all.push({
							lat : x[1],
							lng : x[2]
						})
					})
				});
				var map = new google.maps.Map(document
						.getElementById('detailGoogleMap'), {
					center : {
						lat : 33.38,
						lng : 126.55
					},
					zoom : 11,
					mapTypeControl : false,
					streetViewControl : false,
					fullscreenControl : false
				});
				var bounds = new google.maps.LatLngBounds();
				all.forEach(function(c) {
					bounds.extend(c)
				});
				map.fitBounds(bounds, 48);
				var ds = new google.maps.DirectionsService(), num = 1;
				data
						.forEach(function(d) {
							d.items
									.forEach(function(x) {
										var svg = encodeURIComponent('<svg xmlns="http://www.w3.org/2000/svg" width="28" height="28"><circle cx="14" cy="14" r="12" fill="'+d.color+'" stroke="white" stroke-width="2.5"/><text x="14" y="19" text-anchor="middle" font-size="11" font-weight="bold" font-family="Arial,sans-serif" fill="white">'
												+ (num++) + '</text></svg>');
										new google.maps.Marker(
												{
													position : {
														lat : x[1],
														lng : x[2]
													},
													map : map,
													icon : {
														url : 'data:image/svg+xml;charset=UTF-8,'
																+ svg,
														scaledSize : new google.maps.Size(
																28, 28),
														anchor : new google.maps.Point(
																14, 14)
													},
													title : x[0]
												});
									});
							if (d.items.length > 1) {
								ds
										.route(
												{
													origin : {
														lat : d.items[0][1],
														lng : d.items[0][2]
													},
													destination : {
														lat : d.items[d.items.length - 1][1],
														lng : d.items[d.items.length - 1][2]
													},
													waypoints : d.items
															.slice(1, -1)
															.map(
																	function(x) {
																		return {
																			location : {
																				lat : x[1],
																				lng : x[2]
																			},
																			stopover : true
																		}
																	}),
													travelMode : google.maps.TravelMode.DRIVING,
													optimizeWaypoints : false
												},
												function(res, status) {
													if (status === 'OK' && res)
														new google.maps.Polyline(
																{
																	path : res.routes[0].overview_path,
																	strokeColor : d.color,
																	strokeOpacity : .88,
																	strokeWeight : 5,
																	map : map
																});
												});
							}
						});
			}
			window.initDetailMap = initDetailMap;
			if (window.google && google.maps)
				initDetailMap();
			else {
				var sc = document.createElement('script');
				sc.src = 'https://maps.googleapis.com/maps/api/js?key=AIzaSyB7ioaQS08aAzCl7gZPk6SyE1w7EeIrYhI&language=ko&loading=async&callback=initDetailMap';
				sc.async = true;
				document.head.appendChild(sc);
			}
		})();
	</script>
	<script
		src="${pageContext.request.contextPath}/view/assets/js/auth/tripily.js"></script>

	<script
		src="${pageContext.request.contextPath}/view/assets/js/travel/scheduleDetail.js?v=3"></script>
</body>
</html>