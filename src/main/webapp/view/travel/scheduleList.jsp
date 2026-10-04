<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/view/assets/css/travel/scheduleList.css">
	<title>여행일정 | Tripily</title>
	<jsp:include page="/common/headStyles.jsp" />
</head>
<body class="site-shell">
	<jsp:include page="/common/header.jsp" />
	<div class="flex" style="min-height: calc(100vh - 68px)">
		<aside class="travel-list-sidebar shrink-0 w-48 flex-col gap-1 bg-white py-5 px-2 border-r overflow-y-auto" style="border-color: #ebebf5">
			<div class="text-xs font-bold text-gray-400 uppercase tracking-widest px-3 mb-1">여행 일정</div>
			<a href="${pageContext.request.contextPath}/view/profile/myProfile.jsp"
			class="flex items-center justify-between px-3 py-2.5 rounded-lg transition-colors group">
				<span class="flex items-center gap-2 text-sm font-semibold text-gray-700">
					<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
						<path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
						<polyline points="14 2 14 8 20 8" />
					</svg>내가 작성한 글
				</span>
				<span class="text-xs rounded-full px-2 py-0.5 font-semibold" style="background: var(--brand-light); color: var(--brand)">
					3
				</span>
			</a>
			<div class="border-t border-gray-100 mb-3">
			</div>
			
			<!-- 전체보기 버튼 -->
			<a href="${pageContext.request.contextPath}/schedules"
			class="w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all mb-1"
			style="background: #6369D1; color: #fff">
			    <span class="flex items-center gap-2 text-sm font-semibold">
			        <svg width="16" height="16"
			            viewBox="0 0 24 24"
			            fill="none"
			            stroke="#fff"
			            stroke-width="2">
			
			            <circle cx="12" cy="12" r="10" />
			            <line x1="2" y1="12" x2="22" y2="12" />
			            <path d="M12 2a15.3 15.3 0 0 1 4 10
			                     15.3 15.3 0 0 1-4 10
			                     15.3 15.3 0 0 1-4-10
			                     15.3 15.3 0 0 1 4-10z" />
			        </svg>
			        전체보기
			    </span>
			</a>
			
			<div class="text-xs font-bold text-gray-400 uppercase tracking-widest px-3 mb-1 mt-1">
				여행 지역
			</div>
			
			<div class="border-t border-gray-100 mb-3"></div>
			
			<div class="text-xs font-bold text-gray-400 uppercase tracking-widest px-3 mb-1">
				국가별 보기
			</div>
			
			<div>
				<!-- 아시아 버튼 -->
				<button type="button" class="continent-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all" data-continent-toggle>
					<span class="flex items-center gap-2.5 text-sm font-semibold">
						<svg viewBox="0 0 48 48" width="24" height="24" aria-hidden="true">
							<path d="M10 8L18 5L27 6L36 9L40 15L37 21L40 27L34 32L29 38L22 40L17 35L11 34L7 27L6 19Z" fill="#6369D1" opacity=".88" />
						</svg>
						아시아
					</span>
					<svg class="continent-chevron w-3.5 h-3.5 shrink-0 transition-transform" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" stroke-width="2.5">
						<path d="m6 9 6 6 6-6" />
					</svg>
				</button>
				<!-- 아시아 국가별 버튼 -->
				<div class="continent-panel ml-2 mb-1 flex-col gap-0.5 border-l-2 pl-3 pt-1"
					style="border-color: var(--brand-light)">
					<button type="button" data-schedule-country="대한민국" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">대한민국</button>
					<button type="button" data-schedule-country="일본" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">일본</button>
					<button type="button" data-schedule-country="태국" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">태국</button>
					<button type="button" data-schedule-country="베트남" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">베트남</button>
					<button type="button" data-schedule-country="중국" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">중국</button>
					<button type="button" data-schedule-country="대만" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">대만</button>
					<button type="button" data-schedule-country="싱가포르" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">싱가포르</button>
				</div>
			</div>
			
			<div>
				<!-- 유럽 버튼 -->
				<button type="button" class="continent-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all" data-continent-toggle>
					<span class="flex items-center gap-2.5 text-sm font-semibold">
						<svg viewBox="0 0 48 48" width="24" height="24" aria-hidden="true">
							<path d="M10 8L18 5L27 6L36 9L40 15L37 21L40 27L34 32L29 38L22 40L17 35L11 34L7 27L6 19Z" fill="#8B5CF6" opacity=".88" />
						</svg>
						유럽
					</span>
					<svg class="continent-chevron w-3.5 h-3.5 shrink-0 transition-transform" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" stroke-width="2.5">
						<path d="m6 9 6 6 6-6" />
					</svg>
				</button>
				<!-- 유럽 국가별 버튼 -->
				<div class="continent-panel ml-2 mb-1 flex-col gap-0.5 border-l-2 pl-3 pt-1" style="border-color: var(--brand-light)">
					<button type="button" data-schedule-country="프랑스" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">프랑스</button>
					<button type="button" data-schedule-country="영국" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">영국</button>
					<button type="button" data-schedule-country="이탈리아" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">이탈리아</button>
					<button type="button" data-schedule-country="스페인" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">스페인</button>
					<button type="button" data-schedule-country="독일" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">독일</button>
					<button type="button" data-schedule-country="포르투갈" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">포르투갈</button>
					<button type="button" data-schedule-country="그리스" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">그리스</button>
				</div>
			</div>
			
			<div>
				<!-- 북아메리카 버튼 -->
				<button type="button" class="continent-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all" data-continent-toggle>
					<span class="flex items-center gap-2.5 text-sm font-semibold">
						<svg viewBox="0 0 48 48" width="24" height="24" aria-hidden="true">
							<path d="M10 8L18 5L27 6L36 9L40 15L37 21L40 27L34 32L29 38L22 40L17 35L11 34L7 27L6 19Z" fill="#10B981" opacity=".88" />
						</svg>
						북아메리카
					</span>
					<svg class="continent-chevron w-3.5 h-3.5 shrink-0 transition-transform" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" stroke-width="2.5">
						<path d="m6 9 6 6 6-6" />
					</svg>
				</button>
				<!-- 북아메리카 국가별 버튼 -->
				<div class="continent-panel ml-2 mb-1 flex-col gap-0.5 border-l-2 pl-3 pt-1" style="border-color: var(--brand-light)">
					<button type="button" data-schedule-country="미국" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">미국</button>
					<button type="button" data-schedule-country="캐나다" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">캐나다</button>
					<button type="button" data-schedule-country="멕시코" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">멕시코</button>
				</div>
			</div>
			
			<div>
				<!-- 남아메리카 버튼 -->
				<button type="button" class="continent-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all" data-continent-toggle>
					<span class="flex items-center gap-2.5 text-sm font-semibold">
						<svg viewBox="0 0 48 48" width="24" height="24" aria-hidden="true">
							<path d="M10 8L18 5L27 6L36 9L40 15L37 21L40 27L34 32L29 38L22 40L17 35L11 34L7 27L6 19Z" fill="#F59E0B" opacity=".88" />
						</svg>
						남아메리카
					</span>
					<svg class="continent-chevron w-3.5 h-3.5 shrink-0 transition-transform" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" stroke-width="2.5">
						<path d="m6 9 6 6 6-6" />
					</svg>
				</button>
				<!-- 남아메리카 국가별 버튼 -->
				<div class="continent-panel ml-2 mb-1 flex-col gap-0.5 border-l-2 pl-3 pt-1" style="border-color: var(--brand-light)">
					<button type="button" data-schedule-country="브라질" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">브라질</button>
					<button type="button" data-schedule-country="페루" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">페루</button>
					<button type="button" data-schedule-country="아르헨티나" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">아르헨티나</button>
					<button type="button" data-schedule-country="칠레" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">칠레</button>
				</div>
			</div>
			
			<div>
				<!-- 아프리카 버튼 -->
				<button type="button" class="continent-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all" data-continent-toggle>
					<span class="flex items-center gap-2.5 text-sm font-semibold">
						<svg viewBox="0 0 48 48" width="24" height="24" aria-hidden="true">
							<path d="M10 8L18 5L27 6L36 9L40 15L37 21L40 27L34 32L29 38L22 40L17 35L11 34L7 27L6 19Z" fill="#EF4444" opacity=".88" />
						</svg>
						아프리카
					</span>
					<svg class="continent-chevron w-3.5 h-3.5 shrink-0 transition-transform" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" stroke-width="2.5">
						<path d="m6 9 6 6 6-6" />
					</svg>
				</button>
				<!-- 아프리카 국가별 버튼 -->
				<div class="continent-panel ml-2 mb-1 flex-col gap-0.5 border-l-2 pl-3 pt-1" style="border-color: var(--brand-light)">
					<button type="button" data-schedule-country="이집트" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">이집트</button>
					<button type="button" data-schedule-country="모로코" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">모로코</button>
					<button type="button" data-schedule-country="남아프리카" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">남아프리카</button>
					<button type="button" data-schedule-country="케냐" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">케냐</button>
				</div>
			</div>
			
			<div>
				<!-- 오세아니아 버튼 -->
				<button type="button" class="continent-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all" data-continent-toggle>
					<span class="flex items-center gap-2.5 text-sm font-semibold">
						<svg viewBox="0 0 48 48" width="24" height="24" aria-hidden="true">
							<path d="M10 8L18 5L27 6L36 9L40 15L37 21L40 27L34 32L29 38L22 40L17 35L11 34L7 27L6 19Z" fill="#06B6D4" opacity=".88" />
						</svg>
						오세아니아
					</span>
					<svg class="continent-chevron w-3.5 h-3.5 shrink-0 transition-transform" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" stroke-width="2.5">
						<path d="m6 9 6 6 6-6" />
					</svg>
				</button>
				<!-- 오세아니아 국가별 버튼 -->
				<div class="continent-panel ml-2 mb-1 flex-col gap-0.5 border-l-2 pl-3 pt-1" style="border-color: var(--brand-light)">
					<button type="button" data-schedule-country="호주" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">호주</button>
					<button type="button" data-schedule-country="뉴질랜드" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">뉴질랜드</button>
					<button type="button" data-schedule-country="피지" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">피지</button>
				</div>
			</div>
			
			<div>
				<!-- 중동 버튼 -->
				<button type="button" class="continent-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-xl transition-all" data-continent-toggle>
					<span class="flex items-center gap-2.5 text-sm font-semibold">
						<svg viewBox="0 0 48 48" width="24" height="24" aria-hidden="true">
							<path d="M10 8L18 5L27 6L36 9L40 15L37 21L40 27L34 32L29 38L22 40L17 35L11 34L7 27L6 19Z" fill="#D97706" opacity=".88" />
						</svg>
						중동
					</span>
					<svg class="continent-chevron w-3.5 h-3.5 shrink-0 transition-transform" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" stroke-width="2.5">
						<path d="m6 9 6 6 6-6" />
					</svg>
				</button>
				<!-- 중동 국가별 버튼 -->
				<div class="continent-panel ml-2 mb-1 flex-col gap-0.5 border-l-2 pl-3 pt-1" style="border-color: var(--brand-light)">
					<button type="button" data-schedule-country="UAE" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">UAE</button>
					<button type="button" data-schedule-country="터키" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">터키</button>
					<button type="button" data-schedule-country="이스라엘" class="text-left text-sm py-1.5 px-2 rounded-md text-gray-500 hover:text-[#6369D1]">이스라엘</button>
				</div>
			</div>
		</aside>
		
		<main class="flex-1 px-6 py-8 min-w-0">
			<form id="scheduleSearchForm"
      			action="${pageContext.request.contextPath}/schedules"
      			method="get"
      			class="mb-6 relative max-w-2xl">
      			<input type="hidden"
       				id="scheduleCountry"
       				name="country"
       				value="<c:out value='${country}'/>">
				<div id="scheduleSearchBar"
					class="flex items-center gap-2.5 bg-white border-2 rounded-xl px-4 py-2.5 shadow-sm transition-all cursor-text"
					style="border-color: #D1D2F9">
					<svg class="w-4 h-4 shrink-0" style="color: #94a3b8" fill="none"
						stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round"
							stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" /></svg>
					<input type="text" id="scheduleKeyword" name="keyword" value="<c:out value='${keyword}'/>"
   						class="flex-1 text-[13px] outline-none text-gray-800 placeholder-gray-400 bg-transparent"
    					placeholder="제목, 닉네임, 인원, 예산 검색">
					<!-- <input
						class="flex-1 text-[13px] outline-none text-gray-800 placeholder-gray-400 bg-transparent"
						placeholder="어디로 여행을 떠나고 싶으신가요? (예: 제주도, 도쿄, 파리...)"> -->
					<button type="button"
        					id="scheduleFilterToggle"
        					aria-expanded="false"
        					aria-controls="scheduleFilterPanel"
        					class="shrink-0 flex items-center gap-1 text-[11px] font-medium transition-colors"
        					style="color: #94a3b8">
						<svg class="w-4 h-4 transition-transform" fill="none"
							stroke="currentColor" viewBox="0 0 24 24">
							<path stroke-linecap="round" stroke-linejoin="round"
								stroke-width="2" d="M19 9l-7 7-7-7" /></svg>
						상세조건
					</button>
				</div>
				<div id="scheduleFilterPanel"
					class="hidden absolute left-0 right-0 top-full mt-1.5 bg-white border rounded-2xl shadow-xl z-30 overflow-hidden"
					style="border-color: #D1D2F9">
					<div class="p-5 grid grid-cols-3 gap-6 border-b"
						style="border-color: #D1D2F9">
						<div>
							<p class="text-[10px] font-bold text-gray-500 uppercase tracking-wider mb-3">여행 기간</p>
							<div class="flex flex-col gap-2">
    							<label class="flex items-center gap-2.5 cursor-pointer">
        							<input type="checkbox" name="durations" value="1">
        							<span class="text-[12px]">당일치기</span>
    							</label>		

    							<label class="flex items-center gap-2.5 cursor-pointer">
        							<input type="checkbox" name="durations" value="2">
        							<span class="text-[12px]">1박 2일</span>
    							</label>
				
    							<label class="flex items-center gap-2.5 cursor-pointer">
        							<input type="checkbox" name="durations" value="3">
        							<span class="text-[12px]">2박 3일</span>
    							</label>

    							<label class="flex items-center gap-2.5 cursor-pointer">
        							<input type="checkbox" name="durations" value="4">
        							<span class="text-[12px]">3박 4일</span>
    							</label>

    							<label class="flex items-center gap-2.5 cursor-pointer">
        							<input type="checkbox" name="durations" value="5">
        							<span class="text-[12px]">4박 5일</span>
    							</label>
    							
    							<label class="flex items-center gap-2.5 cursor-pointer">
        							<input type="checkbox" name="durations" value="6">
        							<span class="text-[12px]">5박 이상</span>
    							</label>
							</div>
						</div>
						<div>
							<p class="text-[10px] font-bold text-gray-500 uppercase tracking-wider mb-3">여행 경비</p>
							<div class="flex flex-col gap-2">
								<label class="flex items-center gap-2.5 cursor-pointer">
									<input type="checkbox" name="budgets" value="1">
									<span class="text-[12px]">100만원 이하</span>
								</label>
								
								<label class="flex items-center gap-2.5 cursor-pointer">
									<input type="checkbox" name="budgets" value="2">
									<span class="text-[12px]">100만원 초과~200만원 이하</span>
    							</label>
    							
    							<label class="flex items-center gap-2.5 cursor-pointer">
	        						<input type="checkbox" name="budgets" value="3">
        							<span class="text-[12px]">200만원 초과~300만원 이하</span>
    							</label>
    							
    							<label class="flex items-center gap-2.5 cursor-pointer">
	        						<input type="checkbox" name="budgets" value="4">
        							<span class="text-[12px]">300만원 초과~400만원 이하</span>
    							</label>
    							
    							<label class="flex items-center gap-2.5 cursor-pointer">
	        						<input type="checkbox" name="budgets" value="5">
        							<span class="text-[12px]">400만원 초과~500만원 이하</span>
    							</label>
    							
    							<label class="flex items-center gap-2.5 cursor-pointer">
	        						<input type="checkbox" name="budgets" value="6">
        							<span class="text-[12px]">500만원 초과</span>
    							</label>
							</div>
						</div>
						<div>
							<p class="text-[10px] font-bold text-gray-500 uppercase tracking-wider mb-3">여행 인원</p>
							<div class="flex flex-col gap-2">
    							<label class="flex items-center gap-2.5 cursor-pointer">
        							<input type="checkbox" name="travelers" value="1">
        							<span class="text-[12px]">1인</span>
    							</label>

    							<label class="flex items-center gap-2.5 cursor-pointer">
        							<input type="checkbox" name="travelers" value="2">
        							<span class="text-[12px]">2인</span>
    							</label>
		
    							<label class="flex items-center gap-2.5 cursor-pointer">
        							<input type="checkbox" name="travelers" value="3">
        							<span class="text-[12px]">3인</span>
    							</label>

    							<label class="flex items-center gap-2.5 cursor-pointer">
        							<input type="checkbox" name="travelers" value="4">
        							<span class="text-[12px]">4인</span>
    							</label>
	
							    <label class="flex items-center gap-2.5 cursor-pointer">
        							<input type="checkbox" name="travelers" value="5">
        							<span class="text-[12px]">5인</span>
    							</label>
			
    							<label class="flex items-center gap-2.5 cursor-pointer">
        							<input type="checkbox" name="travelers" value="6">
        							<span class="text-[12px]">6인 이상</span>
    							</label>
		
							</div>
						</div>
					</div>
					<div
						class="px-5 py-3.5 flex items-center justify-between bg-gray-50">
						<button type="button" id="scheduleFilterReset" class="text-[12px] text-gray-400 hover:text-gray-600 font-medium flex items-center gap-1.5">
    						초기화
						</button>
						<button type="submit"
							class="px-6 py-2 text-[12px] font-bold text-white rounded-xl"
							style="background: #6369D1">검색하기</button>
					</div>
				</div>
			</form>
			
			
			<div class="flex items-center justify-between mb-5">
				<p class="text-[12px] font-medium text-gray-500">
					총 <span class="font-bold" style="color: #6369D1">16</span>개의 여행 일정
				</p>
				<div class="flex gap-4">
					<button class="text-sm pb-0.5 transition-colors"
						style="color: #6369D1; font-weight: 600; border-bottom: 2px solid #6369D1">인기순</button>
					<button class="text-sm pb-0.5 transition-colors"
						style="color: #9ca3af">최신순</button>
					<button class="text-sm pb-0.5 transition-colors"
						style="color: #9ca3af">좋아요순</button>
				</div>
			</div>
			<div class="grid gap-5"
				style="grid-template-columns: repeat(4, minmax(0, 1fr))">


				<!-- 실제 DB 데이터로 표시하는 여행 일정 카드 -->
				<c:forEach var="schedule" items="${scheduleList}">

					<c:url var="scheduleDetailUrl"
						value="/view/travel/scheduleDetail.jsp">
						<c:param name="id" value="${schedule.itineraryId}" />
					</c:url>

					<article
						class="jsp-schedule-card bg-white rounded-2xl overflow-hidden transition-all duration-200 border group"
						style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">

						<div class="relative overflow-hidden" style="aspect-ratio: 4/3">

							<a href="${scheduleDetailUrl}" class="block w-full h-full"> <c:choose>
									<c:when test="${not empty schedule.thumbnailImg}">

										<!-- 이미지 경로에 프로젝트 경로를 붙임 -->
										<c:choose>
											<c:when test="${schedule.thumbnailImg.startsWith('/')}">
												<c:url var="thumbnailUrl" value="${schedule.thumbnailImg}" />
											</c:when>

											<c:otherwise>
												<c:url var="thumbnailUrl" value="/${schedule.thumbnailImg}" />
											</c:otherwise>
										</c:choose>

										<img src="<c:out value='${thumbnailUrl}'/>"
											alt="<c:out value='${schedule.title}'/>"
											class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">

									</c:when>

									<c:otherwise>
										<div class="w-full h-full flex items-center justify-center"
											style="background: #F0F0FF; color: #6369D1">여행 일정</div>
									</c:otherwise>
								</c:choose>
							</a>

							<!-- 국가·도시 -->
							<span
								class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
								style="background: #6369D1; color: white"> <c:out
									value="${schedule.country}" /> · <c:out
									value="${schedule.city}" />
							</span>

							<!-- 비로그인 또는 타인 일정에서만 북마크 버튼 표시 -->
							<c:if
								test="${empty sessionScope.user or schedule.userId ne sessionScope.user.userId}">
								<button type="button" data-schedule-bookmark
									data-bookmark-url="${pageContext.request.contextPath}/itinerary/bookmark"
									data-itinerary-id="${schedule.itineraryId}"
									data-logged-in="${not empty sessionScope.user}"
									aria-pressed="${schedule.bookmarked}" aria-label="북마크"
									class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110">

									<svg width="13" height="13" viewBox="0 0 24 24"
										fill="${schedule.bookmarked ? '#6369D1' : 'none'}"
										stroke="${schedule.bookmarked ? '#6369D1' : '#9ca3af'}"
										stroke-width="2">

                        <path stroke-linecap="round"
											stroke-linejoin="round"
											d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" />
                    </svg>
								</button>
							</c:if>

							<!-- 여행 기간: n박 m일 -->
							<span
								class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">
								<c:out value="${schedule.durationText}" />
							</span>

						</div>

						<div class="p-3.5">

							<a href="${scheduleDetailUrl}">
								<h3
									class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
									style="color: #18181b">
									<c:out value="${schedule.title}" />
								</h3>
							</a>

							<p class="text-gray-500 text-[12px] mb-2.5"
   								style="height: 20px;
          							line-height: 20px;
          							white-space: nowrap;
          							overflow: hidden;
          							text-overflow: ellipsis;">
								<c:out value="${schedule.summary}" />
							</p>

							<!-- 좋아요·댓글·조회수 -->
							<div
								class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">

								<span
									class="schedule-card-stat inline-flex items-center gap-1 whitespace-nowrap"
									title="좋아요"> <svg width="12" height="12"
										viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
										stroke-width="2" aria-hidden="true">

                        <path stroke-linecap="round"
											stroke-linejoin="round"
											d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78Z" />
                    </svg> <fmt:formatNumber value="${schedule.likeCount}"
										pattern="#,##0" />
								</span> <span
									class="schedule-card-stat inline-flex items-center gap-1 whitespace-nowrap"
									title="댓글"> <svg width="12" height="12"
										viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
										stroke-width="2" aria-hidden="true">

                        <path stroke-linecap="round"
											stroke-linejoin="round" d="M7.9 20A9 9 0 1 0 4 16.1L2 22Z" />
                    </svg> <fmt:formatNumber value="${schedule.commentCount}"
										pattern="#,##0" />
								</span> <span
									class="schedule-card-stat inline-flex items-center gap-1 whitespace-nowrap"
									title="조회"> <svg width="12" height="12"
										viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
										stroke-width="2" aria-hidden="true">

                        <path stroke-linecap="round"
											stroke-linejoin="round"
											d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0" />

                        <circle cx="12" cy="12" r="3" />
                    </svg> <fmt:formatNumber
										value="${empty schedule.viewCount ? 0 : schedule.viewCount}"
										pattern="#,##0" />
								</span>

							</div>

							<!-- 작성자·작성일 -->
							<div class="flex items-center justify-between border-t pt-2.5"
								style="border-color: #D1D2F9">

								<span class="text-[11px] text-gray-500 font-medium"> <c:out
										value="${schedule.nickname}" />
								</span> <span class="text-[10px] text-gray-400"> <fmt:formatDate
										value="${schedule.createdAt}" pattern="yyyy.MM.dd" />
								</span>

							</div>

						</div>
					</article>

				</c:forEach>


				<%-- <!-- 아래는 예시데이터 코드들 -->
				<a
					href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=9"
					class="jsp-schedule-card bg-white rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 border group"
					style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">
					<div class="relative overflow-hidden" style="aspect-ratio: 4/3">
						<img
							src="https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=600&amp;h=400&amp;fit=crop"
							alt="파리 5박 6일 예술 &amp; 낭만"
							class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
						<div
							class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent"></div>
						<span
							class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
							style="background: #6369D1; color: white">파리</span>
						<button type="button" data-itinerary-id="${schedule.itineraryId}"
							aria-pressed="${schedule.bookmarked}"
							class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110"
							data-bookmark aria-label="북마크">
							<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
								stroke="#9ca3af" stroke-width="2">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg>
						</button>
						<span
							class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">5박
							6일</span>
					</div>
					<div class="p-3.5">
						<h3
							class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
							style="color: #18181b">파리 5박 6일 예술 &amp; 낭만</h3>
						<p
							class="text-gray-500 text-[12px] line-clamp-1 mb-2.5 leading-relaxed">에펠탑,
							루브르, 몽마르트! 낭만의 도시 파리를 온전히 즐기는 일정.</p>
						<div
							class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">
							<span class="flex items-center gap-1"><svg width="12"
									height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
									stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg><span
								class="font-medium">1,234</span></span> <span
								class="flex items-center gap-1"><svg width="12"
									height="12" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>5,670</span>
						</div>
						<div class="flex items-center justify-between border-t pt-2.5"
							style="border-color: #D1D2F9">
							<span class="flex items-center gap-1.5"><img
								src="https://i.pravatar.cc/40?img=17" alt="파리지앵"
								class="w-5 h-5 rounded-full object-cover"><span
								class="text-[11px] text-gray-500 font-medium">파리지앵</span></span> <span
								class="text-[10px] text-gray-400">2026.07.10</span>
						</div>
					</div>
				</a><a
					href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=16"
					class="jsp-schedule-card bg-white rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 border group"
					style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">
					<div class="relative overflow-hidden" style="aspect-ratio: 4/3">
						<img
							src="https://images.unsplash.com/photo-1589452271712-64b8a66c7b71?w=600&amp;h=400&amp;fit=crop"
							alt="오사카 2박 3일 먹방 여행"
							class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
						<div
							class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent"></div>
						<span
							class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
							style="background: #6369D1; color: white">오사카</span>
						<button type="button"
							class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110"
							data-bookmark aria-label="북마크">
							<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
								stroke="#9ca3af" stroke-width="2">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg>
						</button>
						<span
							class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">2박
							3일</span>
					</div>
					<div class="p-3.5">
						<h3
							class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
							style="color: #18181b">오사카 2박 3일 먹방 여행</h3>
						<p
							class="text-gray-500 text-[12px] line-clamp-1 mb-2.5 leading-relaxed">도톤보리,
							구로몬시장, 오사카 성! 먹고 먹고 또 먹는 오사카.</p>
						<div
							class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">
							<span class="flex items-center gap-1"><svg width="12"
									height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
									stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg><span
								class="font-medium">1,102</span></span> <span
								class="flex items-center gap-1"><svg width="12"
									height="12" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>5,100</span>
						</div>
						<div class="flex items-center justify-between border-t pt-2.5"
							style="border-color: #D1D2F9">
							<span class="flex items-center gap-1.5"><img
								src="https://i.pravatar.cc/40?img=31" alt="오사카마니아"
								class="w-5 h-5 rounded-full object-cover"><span
								class="text-[11px] text-gray-500 font-medium">오사카마니아</span></span> <span
								class="text-[10px] text-gray-400">2026.09.08</span>
						</div>
					</div>
				</a><a
					href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=11"
					class="jsp-schedule-card bg-white rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 border group"
					style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">
					<div class="relative overflow-hidden" style="aspect-ratio: 4/3">
						<img
							src="https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=600&amp;h=400&amp;fit=crop"
							alt="뉴욕 6박 7일 도시 탐험"
							class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
						<div
							class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent"></div>
						<span
							class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
							style="background: #6369D1; color: white">뉴욕</span>
						<button type="button"
							class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110"
							data-bookmark aria-label="북마크">
							<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
								stroke="#9ca3af" stroke-width="2">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg>
						</button>
						<span
							class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">6박
							7일</span>
					</div>
					<div class="p-3.5">
						<h3
							class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
							style="color: #18181b">뉴욕 6박 7일 도시 탐험</h3>
						<p
							class="text-gray-500 text-[12px] line-clamp-1 mb-2.5 leading-relaxed">타임스퀘어,
							센트럴파크, 브루클린 브리지! 잠들지 않는 도시 뉴욕.</p>
						<div
							class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">
							<span class="flex items-center gap-1"><svg width="12"
									height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
									stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg><span
								class="font-medium">987</span></span> <span
								class="flex items-center gap-1"><svg width="12"
									height="12" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>4,520</span>
						</div>
						<div class="flex items-center justify-between border-t pt-2.5"
							style="border-color: #D1D2F9">
							<span class="flex items-center gap-1.5"><img
								src="https://i.pravatar.cc/40?img=21" alt="NYC러버"
								class="w-5 h-5 rounded-full object-cover"><span
								class="text-[11px] text-gray-500 font-medium">NYC러버</span></span> <span
								class="text-[10px] text-gray-400">2026.07.28</span>
						</div>
					</div>
				</a><a
					href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=7"
					class="jsp-schedule-card bg-white rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 border group"
					style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">
					<div class="relative overflow-hidden" style="aspect-ratio: 4/3">
						<img
							src="https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=600&amp;h=400&amp;fit=crop"
							alt="도쿄 3박 4일 완전 정복"
							class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
						<div
							class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent"></div>
						<span
							class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
							style="background: #6369D1; color: white">도쿄</span>
						<button type="button"
							class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110"
							data-bookmark aria-label="북마크">
							<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
								stroke="#9ca3af" stroke-width="2">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg>
						</button>
						<span
							class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">3박
							4일</span>
					</div>
					<div class="p-3.5">
						<h3
							class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
							style="color: #18181b">도쿄 3박 4일 완전 정복</h3>
						<p
							class="text-gray-500 text-[12px] line-clamp-1 mb-2.5 leading-relaxed">시부야,
							아키하바라, 아사쿠사! 도쿄의 모든 것을 담은 알찬 일정.</p>
						<div
							class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">
							<span class="flex items-center gap-1"><svg width="12"
									height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
									stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg><span
								class="font-medium">921</span></span> <span
								class="flex items-center gap-1"><svg width="12"
									height="12" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>4,210</span>
						</div>
						<div class="flex items-center justify-between border-t pt-2.5"
							style="border-color: #D1D2F9">
							<span class="flex items-center gap-1.5"><img
								src="https://i.pravatar.cc/40?img=13" alt="재팬러버"
								class="w-5 h-5 rounded-full object-cover"><span
								class="text-[11px] text-gray-500 font-medium">재팬러버</span></span> <span
								class="text-[10px] text-gray-400">2026.08.05</span>
						</div>
					</div>
				</a><a
					href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=10"
					class="jsp-schedule-card bg-white rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 border group"
					style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">
					<div class="relative overflow-hidden" style="aspect-ratio: 4/3">
						<img
							src="https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=600&amp;h=400&amp;fit=crop"
							alt="발리 5박 6일 힐링 휴양"
							class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
						<div
							class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent"></div>
						<span
							class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
							style="background: #6369D1; color: white">발리</span>
						<button type="button"
							class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110"
							data-bookmark aria-label="북마크">
							<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
								stroke="#9ca3af" stroke-width="2">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg>
						</button>
						<span
							class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">5박
							6일</span>
					</div>
					<div class="p-3.5">
						<h3
							class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
							style="color: #18181b">발리 5박 6일 힐링 휴양</h3>
						<p
							class="text-gray-500 text-[12px] line-clamp-1 mb-2.5 leading-relaxed">우붓
							라이스테라스, 울루와뚜 사원, 짱구 카페까지 발리 완전정복.</p>
						<div
							class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">
							<span class="flex items-center gap-1"><svg width="12"
									height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
									stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg><span
								class="font-medium">892</span></span> <span
								class="flex items-center gap-1"><svg width="12"
									height="12" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>3,890</span>
						</div>
						<div class="flex items-center justify-between border-t pt-2.5"
							style="border-color: #D1D2F9">
							<span class="flex items-center gap-1.5"><img
								src="https://i.pravatar.cc/40?img=19" alt="발리덕후"
								class="w-5 h-5 rounded-full object-cover"><span
								class="text-[11px] text-gray-500 font-medium">발리덕후</span></span> <span
								class="text-[10px] text-gray-400">2026.08.22</span>
						</div>
					</div>
				</a><a
					href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=14"
					class="jsp-schedule-card bg-white rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 border group"
					style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">
					<div class="relative overflow-hidden" style="aspect-ratio: 4/3">
						<img
							src="https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=600&amp;h=400&amp;fit=crop"
							alt="다낭 3박 4일 바다 &amp; 리조트"
							class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
						<div
							class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent"></div>
						<span
							class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
							style="background: #6369D1; color: white">다낭</span>
						<button type="button"
							class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110"
							data-bookmark aria-label="북마크">
							<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
								stroke="#9ca3af" stroke-width="2">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg>
						</button>
						<span
							class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">3박
							4일</span>
					</div>
					<div class="p-3.5">
						<h3
							class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
							style="color: #18181b">다낭 3박 4일 바다 &amp; 리조트</h3>
						<p
							class="text-gray-500 text-[12px] line-clamp-1 mb-2.5 leading-relaxed">미케
							비치, 바나힐, 호이안 올드타운까지! 베트남 중부의 진주.</p>
						<div
							class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">
							<span class="flex items-center gap-1"><svg width="12"
									height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
									stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg><span
								class="font-medium">712</span></span> <span
								class="flex items-center gap-1"><svg width="12"
									height="12" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>3,200</span>
						</div>
						<div class="flex items-center justify-between border-t pt-2.5"
							style="border-color: #D1D2F9">
							<span class="flex items-center gap-1.5"><img
								src="https://i.pravatar.cc/40?img=27" alt="다낭러버"
								class="w-5 h-5 rounded-full object-cover"><span
								class="text-[11px] text-gray-500 font-medium">다낭러버</span></span> <span
								class="text-[10px] text-gray-400">2026.09.01</span>
						</div>
					</div>
				</a><a
					href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=8"
					class="jsp-schedule-card bg-white rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 border group"
					style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">
					<div class="relative overflow-hidden" style="aspect-ratio: 4/3">
						<img
							src="https://images.unsplash.com/photo-1506665531195-3566af2b548e?w=600&amp;h=400&amp;fit=crop"
							alt="방콕 4박 5일 사원 &amp; 야시장"
							class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
						<div
							class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent"></div>
						<span
							class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
							style="background: #6369D1; color: white">방콕</span>
						<button type="button"
							class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110"
							data-bookmark aria-label="북마크">
							<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
								stroke="#9ca3af" stroke-width="2">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg>
						</button>
						<span
							class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">4박
							5일</span>
					</div>
					<div class="p-3.5">
						<h3
							class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
							style="color: #18181b">방콕 4박 5일 사원 &amp; 야시장</h3>
						<p
							class="text-gray-500 text-[12px] line-clamp-1 mb-2.5 leading-relaxed">왕궁,
							왓포, 차오프라야강과 야시장까지! 방콕의 매력에 빠져봐요.</p>
						<div
							class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">
							<span class="flex items-center gap-1"><svg width="12"
									height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
									stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg><span
								class="font-medium">678</span></span> <span
								class="flex items-center gap-1"><svg width="12"
									height="12" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>3,100</span>
						</div>
						<div class="flex items-center justify-between border-t pt-2.5"
							style="border-color: #D1D2F9">
							<span class="flex items-center gap-1.5"><img
								src="https://i.pravatar.cc/40?img=15" alt="태국덕후"
								class="w-5 h-5 rounded-full object-cover"><span
								class="text-[11px] text-gray-500 font-medium">태국덕후</span></span> <span
								class="text-[10px] text-gray-400">2026.08.18</span>
						</div>
					</div>
				</a><a
					href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=12"
					class="jsp-schedule-card bg-white rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 border group"
					style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">
					<div class="relative overflow-hidden" style="aspect-ratio: 4/3">
						<img
							src="https://images.unsplash.com/photo-1539037116277-4db20889f2d4?w=600&amp;h=400&amp;fit=crop"
							alt="바르셀로나 4박 5일 가우디 투어"
							class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
						<div
							class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent"></div>
						<span
							class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
							style="background: #6369D1; color: white">바르셀로나</span>
						<button type="button"
							class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110"
							data-bookmark aria-label="북마크">
							<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
								stroke="#9ca3af" stroke-width="2">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg>
						</button>
						<span
							class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">4박
							5일</span>
					</div>
					<div class="p-3.5">
						<h3
							class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
							style="color: #18181b">바르셀로나 4박 5일 가우디 투어</h3>
						<p
							class="text-gray-500 text-[12px] line-clamp-1 mb-2.5 leading-relaxed">사그라다
							파밀리아, 구엘공원, 바르셀로나 해변까지 가우디의 도시.</p>
						<div
							class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">
							<span class="flex items-center gap-1"><svg width="12"
									height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
									stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg><span
								class="font-medium">634</span></span> <span
								class="flex items-center gap-1"><svg width="12"
									height="12" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>2,890</span>
						</div>
						<div class="flex items-center justify-between border-t pt-2.5"
							style="border-color: #D1D2F9">
							<span class="flex items-center gap-1.5"><img
								src="https://i.pravatar.cc/40?img=23" alt="스페인러버"
								class="w-5 h-5 rounded-full object-cover"><span
								class="text-[11px] text-gray-500 font-medium">스페인러버</span></span> <span
								class="text-[10px] text-gray-400">2026.08.08</span>
						</div>
					</div>
				</a><a
					href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=3"
					class="jsp-schedule-card bg-white rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 border group"
					style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">
					<div class="relative overflow-hidden" style="aspect-ratio: 4/3">
						<img
							src="https://images.unsplash.com/photo-1538485399081-7191377e8241?w=600&amp;h=400&amp;fit=crop"
							alt="부산 1박 2일 바다 여행"
							class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
						<div
							class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent"></div>
						<span
							class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
							style="background: #6369D1; color: white">부산</span>
						<button type="button"
							class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110"
							data-bookmark aria-label="북마크">
							<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
								stroke="#9ca3af" stroke-width="2">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg>
						</button>
						<span
							class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">1박
							2일</span>
					</div>
					<div class="p-3.5">
						<h3
							class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
							style="color: #18181b">부산 1박 2일 바다 여행</h3>
						<p
							class="text-gray-500 text-[12px] line-clamp-1 mb-2.5 leading-relaxed">해운대와
							광안리, 자갈치시장까지! 부산 핵심 코스.</p>
						<div
							class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">
							<span class="flex items-center gap-1"><svg width="12"
									height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
									stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg><span
								class="font-medium">512</span></span> <span
								class="flex items-center gap-1"><svg width="12"
									height="12" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>2,341</span>
						</div>
						<div class="flex items-center justify-between border-t pt-2.5"
							style="border-color: #D1D2F9">
							<span class="flex items-center gap-1.5"><img
								src="https://i.pravatar.cc/40?img=5" alt="바다러버"
								class="w-5 h-5 rounded-full object-cover"><span
								class="text-[11px] text-gray-500 font-medium">바다러버</span></span> <span
								class="text-[10px] text-gray-400">2026.08.10</span>
						</div>
					</div>
				</a><a
					href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=13"
					class="jsp-schedule-card bg-white rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 border group"
					style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">
					<div class="relative overflow-hidden" style="aspect-ratio: 4/3">
						<img
							src="https://images.unsplash.com/photo-1758327740354-9c918c10fe47?w=600&amp;h=400&amp;fit=crop"
							alt="여수 2박 3일 낭만 여행"
							class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
						<div
							class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent"></div>
						<span
							class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
							style="background: #6369D1; color: white">여수</span>
						<button type="button"
							class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110"
							data-bookmark aria-label="북마크">
							<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
								stroke="#9ca3af" stroke-width="2">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg>
						</button>
						<span
							class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">2박
							3일</span>
					</div>
					<div class="p-3.5">
						<h3
							class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
							style="color: #18181b">여수 2박 3일 낭만 여행</h3>
						<p
							class="text-gray-500 text-[12px] line-clamp-1 mb-2.5 leading-relaxed">밤바다와
							케이블카, 오동도까지! 낭만의 도시 여수 완전 정복.</p>
						<div
							class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">
							<span class="flex items-center gap-1"><svg width="12"
									height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
									stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg><span
								class="font-medium">398</span></span> <span
								class="flex items-center gap-1"><svg width="12"
									height="12" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>2,100</span>
						</div>
						<div class="flex items-center justify-between border-t pt-2.5"
							style="border-color: #D1D2F9">
							<span class="flex items-center gap-1.5"><img
								src="https://i.pravatar.cc/40?img=25" alt="낭만여행자"
								class="w-5 h-5 rounded-full object-cover"><span
								class="text-[11px] text-gray-500 font-medium">낭만여행자</span></span> <span
								class="text-[10px] text-gray-400">2026.08.25</span>
						</div>
					</div>
				</a><a
					href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=5"
					class="jsp-schedule-card bg-white rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 border group"
					style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">
					<div class="relative overflow-hidden" style="aspect-ratio: 4/3">
						<img
							src="https://images.unsplash.com/photo-1674606042265-c9f03a77e286?w=600&amp;h=400&amp;fit=crop"
							alt="강릉 1박 2일 커피 &amp; 바다"
							class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
						<div
							class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent"></div>
						<span
							class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
							style="background: #6369D1; color: white">강릉</span>
						<button type="button"
							class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110"
							data-bookmark aria-label="북마크">
							<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
								stroke="#9ca3af" stroke-width="2">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg>
						</button>
						<span
							class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">1박
							2일</span>
					</div>
					<div class="p-3.5">
						<h3
							class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
							style="color: #18181b">강릉 1박 2일 커피 &amp; 바다</h3>
						<p
							class="text-gray-500 text-[12px] line-clamp-1 mb-2.5 leading-relaxed">안목해변
							커피거리와 강릉 바다의 아름다움을 즐기는 힐링 코스.</p>
						<div
							class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">
							<span class="flex items-center gap-1"><svg width="12"
									height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
									stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg><span
								class="font-medium">445</span></span> <span
								class="flex items-center gap-1"><svg width="12"
									height="12" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>1,890</span>
						</div>
						<div class="flex items-center justify-between border-t pt-2.5"
							style="border-color: #D1D2F9">
							<span class="flex items-center gap-1.5"><img
								src="https://i.pravatar.cc/40?img=9" alt="커피향"
								class="w-5 h-5 rounded-full object-cover"><span
								class="text-[11px] text-gray-500 font-medium">커피향</span></span> <span
								class="text-[10px] text-gray-400">2026.08.01</span>
						</div>
					</div>
				</a><a
					href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=1"
					class="jsp-schedule-card bg-white rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 border group"
					style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">
					<div class="relative overflow-hidden" style="aspect-ratio: 4/3">
						<img
							src="https://images.unsplash.com/photo-1628411848698-e3b3249a272a?w=600&amp;h=400&amp;fit=crop"
							alt="제주도 2박 3일 힐링 여행"
							class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
						<div
							class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent"></div>
						<span
							class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
							style="background: #6369D1; color: white">제주도</span>
						<button type="button"
							class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110"
							data-bookmark aria-label="북마크">
							<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
								stroke="#9ca3af" stroke-width="2">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg>
						</button>
						<span
							class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">2박
							3일</span>
					</div>
					<div class="p-3.5">
						<h3
							class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
							style="color: #18181b">제주도 2박 3일 힐링 여행</h3>
						<p
							class="text-gray-500 text-[12px] line-clamp-1 mb-2.5 leading-relaxed">바다,
							맛집, 자연까지! 처음 가는 분들도 따라가기 쉬운 코스.</p>
						<div
							class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">
							<span class="flex items-center gap-1"><svg width="12"
									height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
									stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg><span
								class="font-medium">328</span></span> <span
								class="flex items-center gap-1"><svg width="12"
									height="12" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>1,234</span>
						</div>
						<div class="flex items-center justify-between border-t pt-2.5"
							style="border-color: #D1D2F9">
							<span class="flex items-center gap-1.5"><img
								src="https://i.pravatar.cc/40?img=12" alt="여행좋아"
								class="w-5 h-5 rounded-full object-cover"><span
								class="text-[11px] text-gray-500 font-medium">여행좋아</span></span> <span
								class="text-[10px] text-gray-400">2026.08.20</span>
						</div>
					</div>
				</a><a
					href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=6"
					class="jsp-schedule-card bg-white rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 border group"
					style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">
					<div class="relative overflow-hidden" style="aspect-ratio: 4/3">
						<img
							src="https://images.unsplash.com/photo-1758327740327-61826f744965?w=600&amp;h=400&amp;fit=crop"
							alt="전주 1박 2일 한옥 &amp; 맛집"
							class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
						<div
							class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent"></div>
						<span
							class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
							style="background: #6369D1; color: white">전주</span>
						<button type="button"
							class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110"
							data-bookmark aria-label="북마크">
							<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
								stroke="#9ca3af" stroke-width="2">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg>
						</button>
						<span
							class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">1박
							2일</span>
					</div>
					<div class="p-3.5">
						<h3
							class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
							style="color: #18181b">전주 1박 2일 한옥 &amp; 맛집</h3>
						<p
							class="text-gray-500 text-[12px] line-clamp-1 mb-2.5 leading-relaxed">전주한옥마을과
							비빔밥, 콩나물국밥! 미식가를 위한 전주 완전정복.</p>
						<div
							class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">
							<span class="flex items-center gap-1"><svg width="12"
									height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
									stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg><span
								class="font-medium">267</span></span> <span
								class="flex items-center gap-1"><svg width="12"
									height="12" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>1,102</span>
						</div>
						<div class="flex items-center justify-between border-t pt-2.5"
							style="border-color: #D1D2F9">
							<span class="flex items-center gap-1.5"><img
								src="https://i.pravatar.cc/40?img=11" alt="맛집탐방"
								class="w-5 h-5 rounded-full object-cover"><span
								class="text-[11px] text-gray-500 font-medium">맛집탐방</span></span> <span
								class="text-[10px] text-gray-400">2026.07.20</span>
						</div>
					</div>
				</a><a
					href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=15"
					class="jsp-schedule-card bg-white rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 border group"
					style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">
					<div class="relative overflow-hidden" style="aspect-ratio: 4/3">
						<img
							src="https://images.unsplash.com/photo-1583833008338-31a6657917ab?w=600&amp;h=400&amp;fit=crop"
							alt="속초 1박 2일 설악산"
							class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
						<div
							class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent"></div>
						<span
							class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
							style="background: #6369D1; color: white">속초</span>
						<button type="button"
							class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110"
							data-bookmark aria-label="북마크">
							<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
								stroke="#9ca3af" stroke-width="2">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg>
						</button>
						<span
							class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">1박
							2일</span>
					</div>
					<div class="p-3.5">
						<h3
							class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
							style="color: #18181b">속초 1박 2일 설악산</h3>
						<p
							class="text-gray-500 text-[12px] line-clamp-1 mb-2.5 leading-relaxed">설악산
							단풍과 속초 아바이마을 순대국밥! 가을 여행의 정석.</p>
						<div
							class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">
							<span class="flex items-center gap-1"><svg width="12"
									height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
									stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg><span
								class="font-medium">231</span></span> <span
								class="flex items-center gap-1"><svg width="12"
									height="12" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>987</span>
						</div>
						<div class="flex items-center justify-between border-t pt-2.5"
							style="border-color: #D1D2F9">
							<span class="flex items-center gap-1.5"><img
								src="https://i.pravatar.cc/40?img=29" alt="산악인"
								class="w-5 h-5 rounded-full object-cover"><span
								class="text-[11px] text-gray-500 font-medium">산악인</span></span> <span
								class="text-[10px] text-gray-400">2026.09.05</span>
						</div>
					</div>
				</a><a
					href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=2"
					class="jsp-schedule-card bg-white rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 border group"
					style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">
					<div class="relative overflow-hidden" style="aspect-ratio: 4/3">
						<img
							src="https://images.unsplash.com/photo-1506816561089-5cc37b3aa9b0?w=600&amp;h=400&amp;fit=crop"
							alt="서울 2박 3일 역사 탐방"
							class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
						<div
							class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent"></div>
						<span
							class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
							style="background: #6369D1; color: white">서울</span>
						<button type="button"
							class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110"
							data-bookmark aria-label="북마크">
							<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
								stroke="#9ca3af" stroke-width="2">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg>
						</button>
						<span
							class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">2박
							3일</span>
					</div>
					<div class="p-3.5">
						<h3
							class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
							style="color: #18181b">서울 2박 3일 역사 탐방</h3>
						<p
							class="text-gray-500 text-[12px] line-clamp-1 mb-2.5 leading-relaxed">경복궁부터
							북촌까지, 서울의 숨겨진 역사를 따라가는 특별한 여행.</p>
						<div
							class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">
							<span class="flex items-center gap-1"><svg width="12"
									height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
									stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg><span
								class="font-medium">214</span></span> <span
								class="flex items-center gap-1"><svg width="12"
									height="12" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>876</span>
						</div>
						<div class="flex items-center justify-between border-t pt-2.5"
							style="border-color: #D1D2F9">
							<span class="flex items-center gap-1.5"><img
								src="https://i.pravatar.cc/40?img=3" alt="히스토리맨"
								class="w-5 h-5 rounded-full object-cover"><span
								class="text-[11px] text-gray-500 font-medium">히스토리맨</span></span> <span
								class="text-[10px] text-gray-400">2026.08.15</span>
						</div>
					</div>
				</a><a
					href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=4"
					class="jsp-schedule-card bg-white rounded-2xl overflow-hidden cursor-pointer transition-all duration-200 border group"
					style="border-color: #D1D2F9; box-shadow: 0 2px 8px rgba(0, 0, 0, .07)">
					<div class="relative overflow-hidden" style="aspect-ratio: 4/3">
						<img
							src="https://images.unsplash.com/photo-1597552661064-af143a5f3bee?w=600&amp;h=400&amp;fit=crop"
							alt="경주 1박 2일 문화 여행"
							class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
						<div
							class="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent"></div>
						<span
							class="absolute top-2.5 left-2.5 text-[10px] font-bold px-2 py-0.5 rounded-full"
							style="background: #6369D1; color: white">경주</span>
						<button type="button"
							class="absolute top-2.5 right-2.5 w-7 h-7 rounded-full bg-white/90 backdrop-blur-sm flex items-center justify-center shadow-sm transition-all hover:scale-110"
							data-bookmark aria-label="북마크">
							<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
								stroke="#9ca3af" stroke-width="2">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg>
						</button>
						<span
							class="absolute bottom-2.5 left-2.5 text-white text-[11px] font-bold bg-black/50 rounded-full px-2.5 py-1">1박
							2일</span>
					</div>
					<div class="p-3.5">
						<h3
							class="font-bold text-[14px] leading-snug mb-1 line-clamp-2 transition-colors group-hover:text-[#6369D1]"
							style="color: #18181b">경주 1박 2일 문화 여행</h3>
						<p
							class="text-gray-500 text-[12px] line-clamp-1 mb-2.5 leading-relaxed">천년
							고도 경주에서 신라의 역사와 문화를 만나보세요.</p>
						<div
							class="flex items-center gap-2.5 text-[11px] text-gray-400 mb-3">
							<span class="flex items-center gap-1"><svg width="12"
									height="12" viewBox="0 0 24 24" fill="none" stroke="#9ca3af"
									stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" /></svg><span
								class="font-medium">178</span></span> <span
								class="flex items-center gap-1"><svg width="12"
									height="12" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
									<path stroke-linecap="round" stroke-linejoin="round"
										stroke-width="2"
										d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>654</span>
						</div>
						<div class="flex items-center justify-between border-t pt-2.5"
							style="border-color: #D1D2F9">
							<span class="flex items-center gap-1.5"><img
								src="https://i.pravatar.cc/40?img=7" alt="문화탐험가"
								class="w-5 h-5 rounded-full object-cover"><span
								class="text-[11px] text-gray-500 font-medium">문화탐험가</span></span> <span
								class="text-[10px] text-gray-400">2026.07.28</span>
						</div>
					</div>
				</a> --%>
			</div>
		</main>
	</div>
	<script
		src="${pageContext.request.contextPath}/view/assets/js/auth/tripily.js">
	</script>
	<script
		src="${pageContext.request.contextPath}/view/assets/js/travel/scheduleList.js?v=6">
	</script>
</body>
</html>