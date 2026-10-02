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
	<title>Planb</title>
	<jsp:include page="/common/headStyles.jsp" />
</head>
<body class="site-shell">
	<jsp:include page="/common/header.jsp" />
	<div class="tips-page-layout">
		
		<div class="flex" style="min-height: calc(100vh - 68px)">
		<aside
			class="shrink-0 w-48 hidden md:flex flex-col gap-1 bg-white py-5 px-2 border-r overflow-y-auto"
			style="border-color: #ebebf5">
				<div class="text-xs font-bold text-gray-400 uppercase tracking-widest px-3 mb-1">여행 꿀팁</div>
				<a href="${pageContext.request.contextPath}/view/tips/tipList.jsp?mine=1"
					class="flex items-center justify-between px-3 py-2.5 rounded-lg transition-colors group">
					<span class="flex items-center gap-2 text-sm font-semibold text-gray-700">
						<svg width="16" height="16" viewBox="0 0 24 24" fill="none"
							 stroke="currentColor" stroke-width="2">
							<path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
							<polyline points="14 2 14 8 20 8" />
						</svg>
						내가 작성한 글
					</span>
					<span
						class="text-xs rounded-full px-2 py-0.5 font-semibold"
						style="background: var(--brand-light); color: var(--brand)">
						3
					</span>
				</a>
				
				<div class="border-t border-gray-100 mb-3"></div>
				
				<button type="button" class="w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all mb-1"
				    style="background: var(--brand); color: #fff">
				    <span class="flex items-center gap-2 text-sm font-semibold">
				        <svg width="16" height="16"
				            viewBox="0 0 24 24"
				            fill="none"
				            stroke="#fff"
				            stroke-width="2">
				            <circle cx="12" cy="12" r="10" />
				            <line x1="2" y1="12" x2="22" y2="12" />
				            <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" />
				        </svg>
				        전체보기
				    </span>
				
				    <span
				        class="text-xs rounded-full px-2 py-0.5 font-semibold"
				        style="background: rgba(255, 255, 255, .25); color: #fff">
				        8
				    </span>
				</button>
				<div
					class="text-xs font-bold text-gray-400 uppercase tracking-widest px-3 mb-1 mt-1">여행 지역
				</div>
				
				<div class="border-t border-gray-100 mb-3"></div>
				
				<div class="text-xs font-bold text-gray-400 uppercase tracking-widest px-3 mb-1">대륙별 보기</div>
				
				<div>
					<button type="button"
						class="continent-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all"
						data-continent-toggle>
						<span class="flex items-center gap-2.5 text-sm font-semibold"><svg
								viewBox="0 0 48 48" width="24" height="24" aria-hidden="true">
								<path
									d="M10 8L18 5L27 6L36 9L40 15L37 21L40 27L34 32L29 38L22 40L17 35L11 34L7 27L6 19Z"
									fill="#6369D1" opacity=".88" /></svg>아시아</span>
						<svg
							class="continent-chevron w-3.5 h-3.5 shrink-0 transition-transform"
							viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
							stroke-width="2.5">
							<path d="m6 9 6 6 6-6" /></svg>
					</button>
					<div
						class="continent-panel ml-2 mb-1 flex-col gap-0.5 border-l-2 pl-3 pt-1"
						style="border-color: var(- -brand-light)">
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">대한민국</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">일본</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">태국</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">베트남</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">중국</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">대만</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">싱가포르</button>
					</div>
				</div>
				<div>
					<button type="button"
						class="continent-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all"
						data-continent-toggle>
						<span class="flex items-center gap-2.5 text-sm font-semibold"><svg
								viewBox="0 0 48 48" width="24" height="24" aria-hidden="true">
								<path
									d="M10 8L18 5L27 6L36 9L40 15L37 21L40 27L34 32L29 38L22 40L17 35L11 34L7 27L6 19Z"
									fill="#8B5CF6" opacity=".88" /></svg>유럽</span>
						<svg
							class="continent-chevron w-3.5 h-3.5 shrink-0 transition-transform"
							viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
							stroke-width="2.5">
							<path d="m6 9 6 6 6-6" /></svg>
					</button>
					<div
						class="continent-panel ml-2 mb-1 flex-col gap-0.5 border-l-2 pl-3 pt-1"
						style="border-color: var(- -brand-light)">
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">프랑스</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">영국</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">이탈리아</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">스페인</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">독일</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">포르투갈</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">그리스</button>
					</div>
				</div>
				<div>
					<button type="button"
						class="continent-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all"
						data-continent-toggle>
						<span class="flex items-center gap-2.5 text-sm font-semibold"><svg
								viewBox="0 0 48 48" width="24" height="24" aria-hidden="true">
								<path
									d="M10 8L18 5L27 6L36 9L40 15L37 21L40 27L34 32L29 38L22 40L17 35L11 34L7 27L6 19Z"
									fill="#10B981" opacity=".88" /></svg>북아메리카</span>
						<svg
							class="continent-chevron w-3.5 h-3.5 shrink-0 transition-transform"
							viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
							stroke-width="2.5">
							<path d="m6 9 6 6 6-6" /></svg>
					</button>
					<div
						class="continent-panel ml-2 mb-1 flex-col gap-0.5 border-l-2 pl-3 pt-1"
						style="border-color: var(- -brand-light)">
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">미국</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">캐나다</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">멕시코</button>
					</div>
				</div>
				<div>
					<button type="button"
						class="continent-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all"
						data-continent-toggle>
						<span class="flex items-center gap-2.5 text-sm font-semibold"><svg
								viewBox="0 0 48 48" width="24" height="24" aria-hidden="true">
								<path
									d="M10 8L18 5L27 6L36 9L40 15L37 21L40 27L34 32L29 38L22 40L17 35L11 34L7 27L6 19Z"
									fill="#F59E0B" opacity=".88" /></svg>남아메리카</span>
						<svg
							class="continent-chevron w-3.5 h-3.5 shrink-0 transition-transform"
							viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
							stroke-width="2.5">
							<path d="m6 9 6 6 6-6" /></svg>
					</button>
					<div
						class="continent-panel ml-2 mb-1 flex-col gap-0.5 border-l-2 pl-3 pt-1"
						style="border-color: var(- -brand-light)">
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">브라질</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">페루</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">아르헨티나</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">칠레</button>
					</div>
				</div>
				<div>
					<button type="button"
						class="continent-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all"
						data-continent-toggle>
						<span class="flex items-center gap-2.5 text-sm font-semibold"><svg
								viewBox="0 0 48 48" width="24" height="24" aria-hidden="true">
								<path
									d="M10 8L18 5L27 6L36 9L40 15L37 21L40 27L34 32L29 38L22 40L17 35L11 34L7 27L6 19Z"
									fill="#EF4444" opacity=".88" /></svg>아프리카</span>
						<svg
							class="continent-chevron w-3.5 h-3.5 shrink-0 transition-transform"
							viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
							stroke-width="2.5">
							<path d="m6 9 6 6 6-6" /></svg>
					</button>
					<div
						class="continent-panel ml-2 mb-1 flex-col gap-0.5 border-l-2 pl-3 pt-1"
						style="border-color: var(- -brand-light)">
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">이집트</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">모로코</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">남아프리카</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">케냐</button>
					</div>
				</div>
				<div>
					<button type="button"
						class="continent-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all"
						data-continent-toggle>
						<span class="flex items-center gap-2.5 text-sm font-semibold"><svg
								viewBox="0 0 48 48" width="24" height="24" aria-hidden="true">
								<path
									d="M10 8L18 5L27 6L36 9L40 15L37 21L40 27L34 32L29 38L22 40L17 35L11 34L7 27L6 19Z"
									fill="#06B6D4" opacity=".88" /></svg>오세아니아</span>
						<svg
							class="continent-chevron w-3.5 h-3.5 shrink-0 transition-transform"
							viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
							stroke-width="2.5">
							<path d="m6 9 6 6 6-6" /></svg>
					</button>
					<div
						class="continent-panel ml-2 mb-1 flex-col gap-0.5 border-l-2 pl-3 pt-1"
						style="border-color: var(- -brand-light)">
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">호주</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">뉴질랜드</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">피지</button>
					</div>
				</div>
				<div>
					<button type="button"
						class="continent-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all"
						data-continent-toggle>
						<span class="flex items-center gap-2.5 text-sm font-semibold"><svg
								viewBox="0 0 48 48" width="24" height="24" aria-hidden="true">
								<path
									d="M10 8L18 5L27 6L36 9L40 15L37 21L40 27L34 32L29 38L22 40L17 35L11 34L7 27L6 19Z"
									fill="#D97706" opacity=".88" /></svg>중동</span>
						<svg
							class="continent-chevron w-3.5 h-3.5 shrink-0 transition-transform"
							viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
							stroke-width="2.5">
							<path d="m6 9 6 6 6-6" /></svg>
					</button>
					<div
						class="continent-panel ml-2 mb-1 flex-col gap-0.5 border-l-2 pl-3 pt-1"
						style="border-color: var(- -brand-light)">
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">UAE</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">터키</button>
						<button
							class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">이스라엘</button>
					</div>
				</div>
			</aside>
			<main class="flex-1 px-6 py-8 min-w-0">

				<!-- 여행꿀팁 검색 -->
				<div class="mb-6 relative w-full max-w-2xl">
					<div id="scheduleSearchBar"
				    	class="flex items-center gap-2.5 bg-white border-2 rounded-xl px-4 py-2.5 shadow-sm transition-all cursor-text"
				        style="border-color: #D1D2F9">
						<svg class="w-4 h-4 shrink-0"
				        	style="color: #94a3b8"
				            fill="none"
				            stroke="currentColor"
				            viewBox="0 0 24 24">
			                <path
			                    stroke-linecap="round"
			                    stroke-linejoin="round"
			                    stroke-width="2"
			                    d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
				     	</svg>
						<input
				               class="flex-1 min-w-0 text-[13px] outline-none text-gray-800 placeholder-gray-400 bg-transparent"
				               placeholder="어떤 여행 정보가 궁금하신가요?">
				    </div>
				</div>
				<div class="flex items-center justify-between mb-5 gap-4 flex-wrap">
					<!-- 왼쪽 : 게시글 수 -->
					<p class="text-[12px] font-medium text-gray-500">
				        총 <span class="font-bold" style="color: #6369D1">8</span>개의 여행 꿀팁
				    </p>
				    <!-- 오른쪽 : 정렬 + 글쓰기 -->
				    <div class="flex items-center gap-4 flex-wrap">	
						<!-- 정렬 -->
					    <div class="flex gap-4">
				            <button
				                class="text-sm pb-0.5 transition-colors"
				                style="color: #6369D1; font-weight: 600; border-bottom: 2px solid #6369D1">
				                최신순
				            </button>
							<button
					            class="text-sm pb-0.5 transition-colors"
					            style="color: #9ca3af">
					            조회순
					        </button>
							<button
					            class="text-sm pb-0.5 transition-colors"
					            style="color: #9ca3af">
				                좋아요순
				            </button>
				        </div>
					    <!-- 글쓰기 -->
					    <a href="${pageContext.request.contextPath}/view/tips/tipWrite.jsp"
					        class="flex items-center gap-2 px-4 py-2 text-white text-sm font-semibold rounded-lg transition-colors shrink-0"
					        style="background: #6369D1">
					        <svg width="14" height="14"
					            viewBox="0 0 24 24"
					            fill="none"
					            stroke="currentColor"
					            stroke-width="2.5">
					            <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" />
								<path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" />
							 </svg>
							글쓰기
					    </a>
				    </div>
				</div>
				<div class="grid gap-5" style="grid-template-columns: repeat(4, minmax(0, 1fr))" data-card-grid>
					<a href="${pageContext.request.contextPath}/view/tips/tipDetail.jsp?id=1" data-card-category="교통"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-shadow cursor-pointer group overflow-hidden flex flex-col">
						<div class="relative shrink-0 overflow-hidden" style="aspect-ratio: 4 / 3">
							<img
								src="https://images.unsplash.com/photo-1585208798174-6cedd86e019a?fit=crop&w=600&q=80"
								alt="리스본 대중교통 완벽 가이드 (트램, 지하철, 교통카드)"
								class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300">
						</div>
						<div class="flex flex-col flex-1 p-3 min-h-0">
							<h3
								class="font-bold text-[13px] text-gray-900 leading-snug line-clamp-2 group-hover:text-brand transition-colors mb-1.5"
								style="min-height: 2.6em">리스본 대중교통 완벽 가이드 (트램, 지하철, 교통카드)</h3>
							<p
								class="text-[11px] text-gray-500 leading-relaxed line-clamp-2 flex-1">리스본
								여행을 준비하면서 가장 궁금했던 교통편을 정리했어요. 트램 이용 꿀팁부터 ...</p>
							<div class="pt-2 mt-auto border-t border-gray-50">
								<div class="flex items-center gap-1.5 mb-1.5">
									<div
										class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold shrink-0"
										style="background: #8B5CF6">지</div>
									<span class="text-[10px] text-gray-500">지민</span><span
										class="text-[10px] text-gray-300">·</span><span
										class="text-[10px] text-gray-400">2시간 전</span>
								</div>
								<div class="flex items-center gap-3 text-[10px] text-gray-400">
									<span>♡ 24</span><span>▢ 8</span>
								</div>
							</div>
						</div>
					</a>
					<a href="${pageContext.request.contextPath}/view/tips/tipDetail.jsp?id=2" data-card-category="숙박"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-shadow cursor-pointer group overflow-hidden flex flex-col">
						<div
							class="relative shrink-0 overflow-hidden" style="aspect-ratio: 4 / 3">
							<img
								src="https://images.unsplash.com/photo-1549294413-26f195200c16?fit=crop&w=600&q=80"
								alt="제주도 숙소 추천 오션뷰 가성비 숙소 모음"
								class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300">
						</div>
						<div class="flex flex-col flex-1 p-3 min-h-0">
							<h3
								class="font-bold text-[13px] text-gray-900 leading-snug line-clamp-2 group-hover:text-brand transition-colors mb-1.5"
								style="min-height: 2.6em">제주도 숙소 추천 오션뷰 가성비 숙소 모음</h3>
							<p
								class="text-[11px] text-gray-500 leading-relaxed line-clamp-2 flex-1">제주도
								여행을 여러 번 다녀오면서 좋았던 숙소들을 정리했어요. 가격대별로 ...</p>
							<div class="pt-2 mt-auto border-t border-gray-50">
								<div class="flex items-center gap-1.5 mb-1.5">
									<div
										class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold shrink-0"
										style="background: #3B82F6">나</div>
									<span class="text-[10px] text-gray-500">나</span><span
										class="text-[10px] text-gray-300">·</span><span
										class="text-[10px] text-gray-400">5시간 전</span>
								</div>
								<div class="flex items-center gap-3 text-[10px] text-gray-400">
									<span>♡ 42</span><span>▢ 15</span>
								</div>
							</div>
						</div>
					</a>
					<a href="${pageContext.request.contextPath}/view/tips/tipDetail.jsp?id=3" data-card-category="음식"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-shadow cursor-pointer group overflow-hidden flex flex-col">
						<div class="relative shrink-0 overflow-hidden" style="aspect-ratio: 4 / 3">
							<img
								src="https://images.unsplash.com/photo-1591814468924-caf88d1232e1?fit=crop&w=600&q=80"
								alt="후쿠오카에서 꼭 먹어야 하는 현지 음식 7가지"
								class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300">
						</div>
						<div class="flex flex-col flex-1 p-3 min-h-0">
							<h3
								class="font-bold text-[13px] text-gray-900 leading-snug line-clamp-2 group-hover:text-brand transition-colors mb-1.5"
								style="min-height: 2.6em">후쿠오카에서 꼭 먹어야 하는 현지 음식 7가지</h3>
							<p
								class="text-[11px] text-gray-500 leading-relaxed line-clamp-2 flex-1">직접
								다녀온 후쿠오카 맛집들을 소개해요! 라멘, 모츠나베, 야타이까지 현지에서 ...</p>
							<div class="pt-2 mt-auto border-t border-gray-50">
								<div class="flex items-center gap-1.5 mb-1.5">
									<div
										class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold shrink-0"
										style="background: #F59E0B">민</div>
									<span class="text-[10px] text-gray-500">민수</span><span
										class="text-[10px] text-gray-300">·</span><span
										class="text-[10px] text-gray-400">1일 전</span>
								</div>
								<div class="flex items-center gap-3 text-[10px] text-gray-400">
									<span>♡ 67</span><span>▢ 20</span>
								</div>
							</div>
						</div>
					</a>
					<a href="${pageContext.request.contextPath}/view/tips/tipDetail.jsp?id=4" data-card-category="문화"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-shadow cursor-pointer group overflow-hidden flex flex-col">
						<div class="relative shrink-0 overflow-hidden" style="aspect-ratio: 4 / 3">
							<img
								src="https://images.unsplash.com/photo-1488415032361-b7e238421f1b?fit=crop&w=600&q=80"
								alt="아이슬란드 오로라 여행 팁 (시기, 준비물, 촬영방법)"
								class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300">
						</div>
						<div class="flex flex-col flex-1 p-3 min-h-0">
							<h3
								class="font-bold text-[13px] text-gray-900 leading-snug line-clamp-2 group-hover:text-brand transition-colors mb-1.5"
								style="min-height: 2.6em">아이슬란드 오로라 여행 팁 (시기, 준비물, 촬영방법)</h3>
							<p
								class="text-[11px] text-gray-500 leading-relaxed line-clamp-2 flex-1">아이슬란드에서
								오로라를 보고 왔어요. 시기, 날씨, 옷차림, 촬영 팁까지 정리합니다.</p>
							<div class="pt-2 mt-auto border-t border-gray-50">
								<div class="flex items-center gap-1.5 mb-1.5">
									<div
										class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold shrink-0"
										style="background: #EC4899">나</div>
									<span class="text-[10px] text-gray-500">나</span><span
										class="text-[10px] text-gray-300">·</span><span
										class="text-[10px] text-gray-400">1일 전</span>
								</div>
								<div class="flex items-center gap-3 text-[10px] text-gray-400">
									<span>♡ 53</span><span>▢ 12</span>
								</div>
							</div>
						</div>
					</a>
					<a href="${pageContext.request.contextPath}/view/tips/tipDetail.jsp?id=5" data-card-category="기타"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-shadow cursor-pointer group overflow-hidden flex flex-col">
						<div class="relative shrink-0 overflow-hidden" style="aspect-ratio: 4 / 3">
							<img
								src="https://images.unsplash.com/photo-1619794578892-cbdd3ff81c95?fit=crop&w=600&q=80"
								alt="파리 여행 준비 체크리스트 (비자, 환전, 유심 등)"
								class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300">
						</div>
						<div class="flex flex-col flex-1 p-3 min-h-0">
							<h3
								class="font-bold text-[13px] text-gray-900 leading-snug line-clamp-2 group-hover:text-brand transition-colors mb-1.5"
								style="min-height: 2.6em">파리 여행 준비 체크리스트 (비자, 환전, 유심 등)</h3>
							<p
								class="text-[11px] text-gray-500 leading-relaxed line-clamp-2 flex-1">처음
								가는 파리 여행을 준비하면서 꼭 필요했던 정보들을 정리했어요.</p>
							<div class="pt-2 mt-auto border-t border-gray-50">
								<div class="flex items-center gap-1.5 mb-1.5">
									<div
										class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold shrink-0"
										style="background: #EF4444">지</div>
									<span class="text-[10px] text-gray-500">지수</span><span
										class="text-[10px] text-gray-300">·</span><span
										class="text-[10px] text-gray-400">2일 전</span>
								</div>
								<div class="flex items-center gap-3 text-[10px] text-gray-400">
									<span>♡ 38</span><span>▢ 9</span>
								</div>
							</div>
						</div>
					</a>
					<a
						href="${pageContext.request.contextPath}/view/tips/tipDetail.jsp?id=6" data-card-category="숙박"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-shadow cursor-pointer group overflow-hidden flex flex-col">
						<div
							class="relative shrink-0 overflow-hidden" style="aspect-ratio: 4 / 3">
							<img
								src="https://images.unsplash.com/photo-1561501900-3701fa6a0864?fit=crop&w=600&q=80"
								alt="발리 숙소 지역별 추천 (꾸따, 스미냑, 우붓 비교)"
								class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300">
						</div>
						<div class="flex flex-col flex-1 p-3 min-h-0">
							<h3
								class="font-bold text-[13px] text-gray-900 leading-snug line-clamp-2 group-hover:text-brand transition-colors mb-1.5"
								style="min-height: 2.6em">발리 숙소 지역별 추천 (꾸따, 스미냑, 우붓 비교)</h3>
							<p
								class="text-[11px] text-gray-500 leading-relaxed line-clamp-2 flex-1">발리
								숙소를 어디로 잡을지 고민하시는 분들을 위해 지역별 특징과 추천 숙소들을 정리했어요.</p>
							<div class="pt-2 mt-auto border-t border-gray-50">
								<div class="flex items-center gap-1.5 mb-1.5">
									<div
										class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold shrink-0"
										style="background: #10B981">한</div>
									<span class="text-[10px] text-gray-500">한우</span><span
										class="text-[10px] text-gray-300">·</span><span
										class="text-[10px] text-gray-400">3일 전</span>
								</div>
								<div class="flex items-center gap-3 text-[10px] text-gray-400">
									<span>♡ 61</span><span>▢ 18</span>
								</div>
							</div>
						</div>
					</a>
					<a href="${pageContext.request.contextPath}/view/tips/tipDetail.jsp?id=7" data-card-category="교통"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-shadow cursor-pointer group overflow-hidden flex flex-col">
						<div class="relative shrink-0 overflow-hidden" style="aspect-ratio: 4 / 3">
							<img
								src="https://images.unsplash.com/photo-1572414323397-e7918784a4b7?fit=crop&w=600&q=80"
								alt="뉴욕 지하철 이용 방법 (메트로카드, 노선, 주의사항)"
								class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300">
						</div>
						<div class="flex flex-col flex-1 p-3 min-h-0">
							<h3
								class="font-bold text-[13px] text-gray-900 leading-snug line-clamp-2 group-hover:text-brand transition-colors mb-1.5"
								style="min-height: 2.6em">뉴욕 지하철 이용 방법 (메트로카드, 노선, 주의사항)</h3>
							<p
								class="text-[11px] text-gray-500 leading-relaxed line-clamp-2 flex-1">뉴욕
								지하철은 처음엔 복잡해 보이지만 알고 나면 정말 편해요!</p>
							<div class="pt-2 mt-auto border-t border-gray-50">
								<div class="flex items-center gap-1.5 mb-1.5">
									<div
										class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold shrink-0"
										style="background: #8B5CF6">나</div>
									<span class="text-[10px] text-gray-500">나</span><span
										class="text-[10px] text-gray-300">·</span><span
										class="text-[10px] text-gray-400">3일 전</span>
								</div>
								<div class="flex items-center gap-3 text-[10px] text-gray-400">
									<span>♡ 29</span><span>▢ 7</span>
								</div>
							</div>
						</div>
					</a>
					<a href="${pageContext.request.contextPath}/view/tips/tipDetail.jsp?id=8" data-card-category="문화"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-shadow cursor-pointer group overflow-hidden flex flex-col">
						<div class="relative shrink-0 overflow-hidden" style="aspect-ratio: 4 / 3">
							<img
								src="https://images.unsplash.com/photo-1600520611035-84157ad4084d?fit=crop&w=600&q=80"
								alt="이집트 여행 전 알아두면 좋은 현지 문화와 예절"
								class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300">
						</div>
						<div class="flex flex-col flex-1 p-3 min-h-0">
							<h3
								class="font-bold text-[13px] text-gray-900 leading-snug line-clamp-2 group-hover:text-brand transition-colors mb-1.5"
								style="min-height: 2.6em">이집트 여행 전 알아두면 좋은 현지 문화와 예절</h3>
							<p
								class="text-[11px] text-gray-500 leading-relaxed line-clamp-2 flex-1">이집트
								여행을 준비하면서 알게 된 현지 문화와 주의할 점을 정리했어요.</p>
							<div class="pt-2 mt-auto border-t border-gray-50">
								<div class="flex items-center gap-1.5 mb-1.5">
									<div
										class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold shrink-0"
										style="background: #F59E0B">다</div>
									<span class="text-[10px] text-gray-500">다운</span><span
										class="text-[10px] text-gray-300">·</span><span
										class="text-[10px] text-gray-400">4일 전</span>
								</div>
								<div class="flex items-center gap-3 text-[10px] text-gray-400">
									<span>♡ 45</span><span>▢ 14</span>
								</div>
							</div>
						</div>
					</a>
				</div>
				<div class="mt-10 flex flex-col items-center gap-3">
					<p class="text-xs text-gray-400 py-4">모든 꿀팁을 확인했습니다 ✓</p>
				</div>
			</main>
	</div><jsp:include page="/common/footer.jsp" /></body>
</html>
