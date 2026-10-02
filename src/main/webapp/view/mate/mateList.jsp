<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage", "mate");
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
	<div class="min-h-screen bg-white">
		
		<div class="flex" style="min-height: calc(100vh - 68px)">
			<aside
		    class="shrink-0 w-48 hidden md:flex flex-col gap-1 bg-white py-5 px-2 border-r overflow-y-auto"
		    style="border-color: #ebebf5">
			<div class="text-xs font-bold text-gray-400 uppercase tracking-widest px-3 mb-1">여행 메이트</div>
				<a href="${pageContext.request.contextPath}/view/mate/mateList.jsp?mine=1"
					class="flex items-center justify-between px-3 py-2.5 rounded-lg transition-colors group">
					<span class="flex items-center gap-2 text-sm font-semibold text-gray-700">
						<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
							<path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
							<polyline points="14 2 14 8 20 8" />
						</svg>
						내가 작성한 글
					</span>
					<span class="text-xs rounded-full px-2 py-0.5 font-semibold"
						style="background: var(--brand-light); color: var(--brand)">
						3
					</span>
				</a>
				
				<div class="border-t border-gray-100 mb-3"></div>
				<button
					class="w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all mb-1 bg-[#6369D1] text-white">
					<span class="flex items-center gap-2 text-sm font-semibold"><svg
							width="16" height="16" viewBox="0 0 24 24" fill="none"
							stroke="#fff" stroke-width="2">
							<circle cx="12" cy="12" r="10" />
							<line x1="2" y1="12" x2="22" y2="12" />
							<path
								d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" /></svg>전체보기</span><span
						class="text-xs rounded-full px-2 py-0.5 font-semibold bg-white/25 text-white">9</span>
				</button>
				<div class="text-xs font-bold text-gray-400 uppercase tracking-widest px-3 mb-1 mt-1">여행 지역</div>
				
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
				<!-- 여행 메이트 검색 -->
			    <div class="mb-6 relative max-w-2xl">
			        <div id="scheduleSearchBar"
			            class="flex items-center gap-2.5 bg-white border-2 rounded-xl px-4 py-2.5 shadow-sm transition-all cursor-text"
			            style="border-color: #D1D2F9">
			            <svg class="w-4 h-4 shrink-0" style="color: #94a3b8" fill="none"
			                stroke="currentColor" viewBox="0 0 24 24">
				            <path
				                stroke-linecap="round"
				                stroke-linejoin="round"
				                stroke-width="2"
				                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" 
				            />
			            </svg>
			            <input
			                class="flex-1 min-w-0 text-[13px] outline-none text-gray-800 placeholder-gray-400 bg-transparent"
			                placeholder="어떤 여행을 함께하고 싶으신가요?">
			            <button type="button"
			                id="scheduleFilterToggle"
			                class="shrink-0 flex items-center gap-1 text-[11px] font-medium transition-colors"
			                style="color: #94a3b8">
			                <svg class="w-4 h-4 transition-transform"
			                    fill="none"
			                    stroke="currentColor"
			                    viewBox="0 0 24 24">
			                    <path
			                        stroke-linecap="round"
			                        stroke-linejoin="round"
			                        stroke-width="2"
			                        d="M19 9l-7 7-7-7" 
			                    />
			                </svg>
			                상세조건
			            </button>
			        </div>
			    </div>
				<div class="flex items-center justify-between mb-5 gap-4 flex-wrap">
				    <!-- 왼쪽 : 전체 게시글 수 -->
				    <p class="text-[12px] font-medium text-gray-500">
				        총 <span class="font-bold" style="color: #6369D1">9</span>개의 여행 메이트
				    </p>
				    <!-- 오른쪽 : 정렬 + 글쓰기 -->
				    <div class="flex items-center gap-4 flex-wrap">
				        <!-- 정렬 -->
				        <div class="flex gap-4">
				            <button class="text-sm pb-0.5 transition-colors" style="color: #6369D1; font-weight: 600; border-bottom: 2px solid #6369D1">
				                최신순
				            </button>
				            <button class="text-sm pb-0.5 transition-colors" style="color: #9ca3af">
				                조회순
				            </button>
				            <button class="text-sm pb-0.5 transition-colors" style="color: #9ca3af">
				                댓글순
				            </button>
				        </div>
				        <!-- 기존 글쓰기 -->
				        <a href="${pageContext.request.contextPath}/view/mate/mateWrite.jsp"
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
				<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
					<a
						href="${pageContext.request.contextPath}/view/mate/mateDetail.jsp?id=1"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all cursor-pointer group p-5 hover:border-[#D1D2F9]"><div
							class="flex items-center gap-2 mb-3">
							<span
								class="flex items-center gap-1 text-xs font-bold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-soft); color: var(- -brand)"><svg
									width="10" height="10" viewBox="0 0 24 24" fill="none"
									stroke="currentColor" stroke-width="2">
									<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" />
									<circle cx="12" cy="10" r="3" /></svg>일본</span><span
								class="text-xs text-gray-500 font-medium">도쿄</span>
						</div>
						<h3
							class="font-bold text-[15px] text-gray-900 leading-snug mb-4 group-hover:text-brand transition-colors">🗼
							11/10-14 도쿄 4박 · 맛집+카페+쇼핑 동행 1명</h3>
						<div class="flex items-center gap-2 mb-4 flex-wrap">
							<span class="text-[11px] font-semibold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-light); color: var(- -brand)">👥
								1명 모집</span><span
								class="text-[11px] text-gray-400 flex items-center gap-1">▣
								2026.09.10</span>
						</div>
						<div
							class="flex items-center justify-between text-xs text-gray-400 border-t border-gray-50 pt-3">
							<div class="flex items-center gap-1.5">
								<div
									class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold"
									style="background: #8B5CF6">지</div>
								<span class="text-gray-600 font-medium">지민</span>
							</div>
							<div class="flex items-center gap-3">
								<span>◉ 124</span><span>▢ 7</span>
							</div>
						</div></a><a
						href="${pageContext.request.contextPath}/view/mate/mateDetail.jsp?id=2"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all cursor-pointer group p-5 hover:border-[#D1D2F9]"><div
							class="flex items-center gap-2 mb-3">
							<span
								class="flex items-center gap-1 text-xs font-bold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-soft); color: var(- -brand)"><svg
									width="10" height="10" viewBox="0 0 24 24" fill="none"
									stroke="currentColor" stroke-width="2">
									<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" />
									<circle cx="12" cy="10" r="3" /></svg>베트남</span><span
								class="text-xs text-gray-500 font-medium">다낭</span>
						</div>
						<h3
							class="font-bold text-[15px] text-gray-900 leading-snug mb-4 group-hover:text-brand transition-colors">✈️
							12월 다낭 · 항공+숙소 같이 알아볼 분 (최대 3명)</h3>
						<div class="flex items-center gap-2 mb-4 flex-wrap">
							<span class="text-[11px] font-semibold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-light); color: var(- -brand)">👥
								3명 모집</span><span
								class="text-[11px] text-gray-400 flex items-center gap-1">▣
								2026.09.10</span>
						</div>
						<div
							class="flex items-center justify-between text-xs text-gray-400 border-t border-gray-50 pt-3">
							<div class="flex items-center gap-1.5">
								<div
									class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold"
									style="background: #3B82F6">하</div>
								<span class="text-gray-600 font-medium">하늘</span>
							</div>
							<div class="flex items-center gap-3">
								<span>◉ 86</span><span>▢ 5</span>
							</div>
						</div></a><a
						href="${pageContext.request.contextPath}/view/mate/mateDetail.jsp?id=3"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all cursor-pointer group p-5 hover:border-[#D1D2F9]"><div
							class="flex items-center gap-2 mb-3">
							<span
								class="flex items-center gap-1 text-xs font-bold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-soft); color: var(- -brand)"><svg
									width="10" height="10" viewBox="0 0 24 24" fill="none"
									stroke="currentColor" stroke-width="2">
									<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" />
									<circle cx="12" cy="10" r="3" /></svg>태국</span><span
								class="text-xs text-gray-500 font-medium">방콕</span>
						</div>
						<h3
							class="font-bold text-[15px] text-gray-900 leading-snug mb-4 group-hover:text-brand transition-colors">🛺
							11월 초 방콕 아속역 숙소 셰어 · 비용 50% 절약</h3>
						<div class="flex items-center gap-2 mb-4 flex-wrap">
							<span class="text-[11px] font-semibold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-light); color: var(- -brand)">👥
								2명 모집</span><span
								class="text-[11px] text-gray-400 flex items-center gap-1">▣
								2026.09.09</span>
						</div>
						<div
							class="flex items-center justify-between text-xs text-gray-400 border-t border-gray-50 pt-3">
							<div class="flex items-center gap-1.5">
								<div
									class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold"
									style="background: #F59E0B">민</div>
								<span class="text-gray-600 font-medium">민수</span>
							</div>
							<div class="flex items-center gap-3">
								<span>◉ 97</span><span>▢ 4</span>
							</div>
						</div></a><a
						href="${pageContext.request.contextPath}/view/mate/mateDetail.jsp?id=4"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all cursor-pointer group p-5 hover:border-[#D1D2F9]"><div
							class="flex items-center gap-2 mb-3">
							<span
								class="flex items-center gap-1 text-xs font-bold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-soft); color: var(- -brand)"><svg
									width="10" height="10" viewBox="0 0 24 24" fill="none"
									stroke="currentColor" stroke-width="2">
									<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" />
									<circle cx="12" cy="10" r="3" /></svg>이탈리아</span><span
								class="text-xs text-gray-500 font-medium">로마</span>
						</div>
						<h3
							class="font-bold text-[15px] text-gray-900 leading-snug mb-4 group-hover:text-brand transition-colors">🍕
							10/15-22 로마·피렌체·베네치아 맛집 여행 동행</h3>
						<div class="flex items-center gap-2 mb-4 flex-wrap">
							<span class="text-[11px] font-semibold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-light); color: var(- -brand)">👥
								2명 모집</span><span
								class="text-[11px] text-gray-400 flex items-center gap-1">▣
								2026.09.09</span>
						</div>
						<div
							class="flex items-center justify-between text-xs text-gray-400 border-t border-gray-50 pt-3">
							<div class="flex items-center gap-1.5">
								<div
									class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold"
									style="background: #EC4899">서</div>
								<span class="text-gray-600 font-medium">서연</span>
							</div>
							<div class="flex items-center gap-3">
								<span>◉ 203</span><span>▢ 12</span>
							</div>
						</div></a><a
						href="${pageContext.request.contextPath}/view/mate/mateDetail.jsp?id=5"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all cursor-pointer group p-5 hover:border-[#D1D2F9]"><div
							class="flex items-center gap-2 mb-3">
							<span
								class="flex items-center gap-1 text-xs font-bold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-soft); color: var(- -brand)"><svg
									width="10" height="10" viewBox="0 0 24 24" fill="none"
									stroke="currentColor" stroke-width="2">
									<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" />
									<circle cx="12" cy="10" r="3" /></svg>영국</span><span
								class="text-xs text-gray-500 font-medium">런던</span>
						</div>
						<h3
							class="font-bold text-[15px] text-gray-900 leading-snug mb-4 group-hover:text-brand transition-colors">🎓
							11월 런던 어학연수 · 영어 회화 파트너 구해요</h3>
						<div class="flex items-center gap-2 mb-4 flex-wrap">
							<span class="text-[11px] font-semibold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-light); color: var(- -brand)">👥
								3명 모집</span><span
								class="text-[11px] text-gray-400 flex items-center gap-1">▣
								2026.09.08</span>
						</div>
						<div
							class="flex items-center justify-between text-xs text-gray-400 border-t border-gray-50 pt-3">
							<div class="flex items-center gap-1.5">
								<div
									class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold"
									style="background: #10B981">도</div>
								<span class="text-gray-600 font-medium">도현</span>
							</div>
							<div class="flex items-center gap-3">
								<span>◉ 152</span><span>▢ 6</span>
							</div>
						</div></a><a
						href="${pageContext.request.contextPath}/view/mate/mateDetail.jsp?id=6"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all cursor-pointer group p-5 hover:border-[#D1D2F9]"><div
							class="flex items-center gap-2 mb-3">
							<span
								class="flex items-center gap-1 text-xs font-bold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-soft); color: var(- -brand)"><svg
									width="10" height="10" viewBox="0 0 24 24" fill="none"
									stroke="currentColor" stroke-width="2">
									<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" />
									<circle cx="12" cy="10" r="3" /></svg>한국</span><span
								class="text-xs text-gray-500 font-medium">제주도</span>
						</div>
						<h3
							class="font-bold text-[15px] text-gray-900 leading-snug mb-4 group-hover:text-brand transition-colors">🌿
							10/28-30 제주 2박3일 렌터카 여행 · 동행 1명</h3>
						<div class="flex items-center gap-2 mb-4 flex-wrap">
							<span class="text-[11px] font-semibold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-light); color: var(- -brand)">👥
								1명 모집</span><span
								class="text-[11px] text-gray-400 flex items-center gap-1">▣
								2026.09.07</span>
						</div>
						<div
							class="flex items-center justify-between text-xs text-gray-400 border-t border-gray-50 pt-3">
							<div class="flex items-center gap-1.5">
								<div
									class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold"
									style="background: #3B82F6">수</div>
								<span class="text-gray-600 font-medium">수빈</span>
							</div>
							<div class="flex items-center gap-3">
								<span>◉ 110</span><span>▢ 4</span>
							</div>
						</div></a><a
						href="${pageContext.request.contextPath}/view/mate/mateDetail.jsp?id=7"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all cursor-pointer group p-5 hover:border-[#D1D2F9]"><div
							class="flex items-center gap-2 mb-3">
							<span
								class="flex items-center gap-1 text-xs font-bold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-soft); color: var(- -brand)"><svg
									width="10" height="10" viewBox="0 0 24 24" fill="none"
									stroke="currentColor" stroke-width="2">
									<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" />
									<circle cx="12" cy="10" r="3" /></svg>스페인</span><span
								class="text-xs text-gray-500 font-medium">바르셀로나</span>
						</div>
						<h3
							class="font-bold text-[15px] text-gray-900 leading-snug mb-4 group-hover:text-brand transition-colors">🏰
							11/28-12/5 바르셀로나+마드리드 · 동행 2명</h3>
						<div class="flex items-center gap-2 mb-4 flex-wrap">
							<span class="text-[11px] font-semibold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-light); color: var(- -brand)">👥
								2명 모집</span><span
								class="text-[11px] text-gray-400 flex items-center gap-1">▣
								2026.09.07</span>
						</div>
						<div
							class="flex items-center justify-between text-xs text-gray-400 border-t border-gray-50 pt-3">
							<div class="flex items-center gap-1.5">
								<div
									class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold"
									style="background: #8B5CF6">나</div>
								<span class="text-gray-600 font-medium">나연</span>
							</div>
							<div class="flex items-center gap-3">
								<span>◉ 91</span><span>▢ 5</span>
							</div>
						</div></a><a
						href="${pageContext.request.contextPath}/view/mate/mateDetail.jsp?id=8"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all cursor-pointer group p-5 hover:border-[#D1D2F9]"><div
							class="flex items-center gap-2 mb-3">
							<span
								class="flex items-center gap-1 text-xs font-bold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-soft); color: var(- -brand)"><svg
									width="10" height="10" viewBox="0 0 24 24" fill="none"
									stroke="currentColor" stroke-width="2">
									<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" />
									<circle cx="12" cy="10" r="3" /></svg>대만</span><span
								class="text-xs text-gray-500 font-medium">타이베이</span>
						</div>
						<h3
							class="font-bold text-[15px] text-gray-900 leading-snug mb-4 group-hover:text-brand transition-colors">🧋
							10월 타이베이 · 야시장+마트 쇼핑 정보 모아요</h3>
						<div class="flex items-center gap-2 mb-4 flex-wrap">
							<span class="text-[11px] font-semibold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-light); color: var(- -brand)">👥
								4명 모집</span><span
								class="text-[11px] text-gray-400 flex items-center gap-1">▣
								2026.09.06</span>
						</div>
						<div
							class="flex items-center justify-between text-xs text-gray-400 border-t border-gray-50 pt-3">
							<div class="flex items-center gap-1.5">
								<div
									class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold"
									style="background: #F59E0B">헌</div>
								<span class="text-gray-600 font-medium">헌우</span>
							</div>
							<div class="flex items-center gap-3">
								<span>◉ 74</span><span>▢ 2</span>
							</div>
						</div></a><a
						href="${pageContext.request.contextPath}/view/mate/mateDetail.jsp?id=9"
						class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all cursor-pointer group p-5 hover:border-[#D1D2F9]"><div
							class="flex items-center gap-2 mb-3">
							<span
								class="flex items-center gap-1 text-xs font-bold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-soft); color: var(- -brand)"><svg
									width="10" height="10" viewBox="0 0 24 24" fill="none"
									stroke="currentColor" stroke-width="2">
									<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" />
									<circle cx="12" cy="10" r="3" /></svg>프랑스</span><span
								class="text-xs text-gray-500 font-medium">파리</span>
						</div>
						<h3
							class="font-bold text-[15px] text-gray-900 leading-snug mb-4 group-hover:text-brand transition-colors">🚂
							12월 파리발 유럽 기차여행 · 숙소+교통 셰어 1명</h3>
						<div class="flex items-center gap-2 mb-4 flex-wrap">
							<span class="text-[11px] font-semibold px-2.5 py-1 rounded-full"
								style="background: var(- -brand-light); color: var(- -brand)">👥
								1명 모집</span><span
								class="text-[11px] text-gray-400 flex items-center gap-1">▣
								2026.09.06</span>
						</div>
						<div
							class="flex items-center justify-between text-xs text-gray-400 border-t border-gray-50 pt-3">
							<div class="flex items-center gap-1.5">
								<div
									class="w-5 h-5 rounded-full flex items-center justify-center text-white text-[9px] font-bold"
									style="background: #EC4899">지</div>
								<span class="text-gray-600 font-medium">지은</span>
							</div>
							<div class="flex items-center gap-3">
								<span>◉ 68</span><span>▢ 3</span>
							</div>
						</div></a>
				</div>
				<div class="h-12 flex items-center justify-center mt-4">
					<span class="text-xs text-gray-300">모든 게시글을 확인했어요.</span>
				</div>
			</main>
		</div>
	</div>
	<jsp:include page="/common/footer.jsp" />
</body>
</html>
