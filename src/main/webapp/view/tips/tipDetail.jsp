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
<title>여행꿀팁 상세 · Tripily</title><jsp:include
	page="/common/headStyles.jsp" /></head>
<body class="site-shell"><jsp:include page="/common/header.jsp" />
	<div class="pt-16 min-h-screen" style="background-color: #f5f5fb">
		<div class="max-w-5xl mx-auto px-4 py-8">
			<a href="${pageContext.request.contextPath}/view/tips/tipList.jsp"
				class="flex items-center gap-2 px-4 py-2 rounded-full bg-white border border-gray-200 text-sm font-semibold text-gray-600 hover:border-gray-400 hover:text-gray-800 transition-colors shadow-sm mb-6"><svg
					width="14" height="14" viewBox="0 0 24 24" fill="none"
					stroke="currentColor" stroke-width="2">
					<path d="M15 18l-6-6 6-6" /></svg>목록으로</a>
			<div class="flex gap-6 items-start">
				<div
					class="hidden lg:flex flex-col items-center justify-center gap-3 rounded-2xl shrink-0"
					style="width: 160px; min-height: 600px; background-color: var(- -brand-light); color: var(- -brand)">
					<div
						class="w-12 h-12 rounded-full flex items-center justify-center font-extrabold text-sm text-white"
						style="background-color: var(- -brand)">AD</div>
					<p class="text-xs font-semibold text-center px-3"
						style="color: var(- -brand)">
						좌측 광고 영역<br>
						<span class="text-[10px] font-normal opacity-60">(예:
							160x600)</span>
					</p>
				</div>
				<div class="flex-1 min-w-0">
					<div
						class="bg-white rounded-3xl shadow-sm border border-gray-100 overflow-hidden">
						<div class="relative overflow-hidden" style="height: 280px">
							<img
								src="https://images.unsplash.com/photo-1585208798174-6cedd86e019a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx0cmFtJTIwbGlzYm9uJTIwc3RyZWV0JTIwdHJhbnNwb3J0YXRpb258ZW58MXx8fHwxNzg5MjgzNjU4fDA&ixlib=rb-4.1.0&q=80&w=600"
								alt="리스본 대중교통 완벽 가이드 (트램, 지하철, 교통카드)"
								class="absolute inset-0 w-full h-full object-cover">
							<div class="absolute inset-0"
								style="background: linear-gradient(to top, rgba(0, 0, 0, .72) 0%, rgba(0, 0, 0, .18) 55%, transparent 100%)"></div>
							<div class="absolute bottom-6 left-7 right-7">
								<span
									class="inline-block text-xs font-bold px-3 py-1 rounded-full mb-3"
									style="color: #EC4899; background-color: #FDF2F8">교통</span>
								<h1
									class="text-white text-2xl md:text-3xl font-extrabold leading-snug">리스본
									대중교통 완벽 가이드 (트램, 지하철, 교통카드)</h1>
							</div>
						</div>
						<div class="p-7">
							<div
								class="flex items-center justify-between mb-7 pb-6 border-b border-gray-100">
								<div class="flex items-center gap-3">
									<div
										class="w-10 h-10 rounded-full flex items-center justify-center text-white font-bold"
										style="background-color: #8B5CF6">지</div>
									<div>
										<p class="font-bold text-sm text-gray-900">지민</p>
										<p class="text-xs text-gray-400">2시간 전</p>
									</div>
								</div>
								<div class="flex items-center gap-4 text-sm text-gray-400">
									<button
										class="flex items-center gap-1.5 hover:text-red-400 transition-colors">
										<svg width="16" height="16" viewBox="0 0 24 24" fill="none"
											stroke="currentColor" stroke-width="2">
											<path
												d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" /></svg>
										24
									</button>
									<span class="flex items-center gap-1.5"><svg width="16"
											height="16" viewBox="0 0 24 24" fill="none"
											stroke="currentColor" stroke-width="2">
											<path
												d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" /></svg>8</span>
								</div>
							</div>
							<div class="prose prose-gray max-w-none">
								<p class="text-gray-700 text-base leading-relaxed mb-6">리스본
									여행을 준비하면서 가장 궁금했던 교통편을 정리했어요. 트램 이용 꿀팁부터 지하철 노선까지 자세히 설명해 드릴게요.
									특히 28번 트램은 꼭 타보세요!</p>
								<p class="text-gray-600 text-sm leading-relaxed">여행을 준비할 때
									가장 중요한 것 중 하나는 현지 정보를 미리 파악하는 것입니다. 이 글에서 소개한 내용들이 여러분의 여행에 도움이
									되길 바랍니다.</p>
								<br>
								<p class="text-gray-600 text-sm leading-relaxed">혹시 더 궁금한 점이
									있으시면 댓글로 남겨주세요. 제가 직접 경험한 것들을 최대한 자세히 답변드리겠습니다. 좋은 여행 되세요! 🌍</p>
							</div>
							<div
								class="flex flex-wrap gap-2 mt-8 pt-6 border-t border-gray-100">
								<span class="text-xs font-semibold px-3 py-1 rounded-full"
									style="background-color: var(- -brand-light); color: var(- -brand)">#여행꿀팁</span><span
									class="text-xs font-semibold px-3 py-1 rounded-full"
									style="background-color: var(- -brand-light); color: var(- -brand)">#교통</span><span
									class="text-xs font-semibold px-3 py-1 rounded-full"
									style="background-color: var(- -brand-light); color: var(- -brand)">#실전정보</span>
							</div>
							<div class="flex items-center justify-center gap-4 mt-8">
								<button type="button"
									class="flex items-center gap-2 px-8 py-3 rounded-full font-semibold text-sm border-2 transition-all"
									style="border-color: var(- -brand); color: var(- -brand)">
									<svg width="16" height="16" viewBox="0 0 24 24" fill="none"
										stroke="currentColor" stroke-width="2">
										<path
											d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" /></svg>
									좋아요 24
								</button>
								<button type="button"
									class="flex items-center gap-2 px-8 py-3 rounded-full font-semibold text-sm border-2 border-gray-200 text-gray-500 hover:border-gray-400 transition-all">
									<svg width="16" height="16" viewBox="0 0 24 24" fill="none"
										stroke="currentColor" stroke-width="2">
										<circle cx="18" cy="5" r="3" />
										<circle cx="6" cy="12" r="3" />
										<circle cx="18" cy="19" r="3" />
										<line x1="8.59" y1="13.51" x2="15.42" y2="17.49" />
										<line x1="15.41" y1="6.51" x2="8.59" y2="10.49" /></svg>
									공유하기
								</button>
							</div>
						</div>
					</div>
					<div
						class="bg-white rounded-3xl shadow-sm border border-gray-100 p-7 mt-4">
						<h3
							class="flex items-center gap-2 text-base font-extrabold text-gray-900 mb-6">
							<svg width="18" height="18" viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="2.2"
								style="color: var(- -brand)">
								<path
									d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" /></svg>
							댓글 3
						</h3>
						<div class="flex flex-col gap-5 mb-8">
							<div class="flex gap-3">
								<div
									class="w-9 h-9 rounded-full shrink-0 flex items-center justify-center text-white text-sm font-bold"
									style="background-color: #6369D1">수</div>
								<div class="flex-1 min-w-0">
									<div class="flex items-center gap-2 mb-1">
										<span class="text-sm font-bold text-gray-900">수빈</span><span
											class="text-xs text-gray-400">2026.09.11</span>
									</div>
									<p class="text-sm text-gray-700 leading-relaxed">덕분에 여행 준비가
										훨씬 수월해졌어요! 특히 교통 정보가 정말 유용했습니다 🙏</p>
									<button type="button"
										class="flex items-center gap-1 mt-2 text-xs transition-colors"
										style="color: #9ca3af">
										<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
											stroke="currentColor" stroke-width="2">
											<path
												d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" /></svg>
										좋아요 12
									</button>
								</div>
							</div>
							<div class="flex gap-3">
								<div
									class="w-9 h-9 rounded-full shrink-0 flex items-center justify-center text-white text-sm font-bold"
									style="background-color: #10B981">도</div>
								<div class="flex-1 min-w-0">
									<div class="flex items-center gap-2 mb-1">
										<span class="text-sm font-bold text-gray-900">도현</span><span
											class="text-xs text-gray-400">2026.09.12</span>
									</div>
									<p class="text-sm text-gray-700 leading-relaxed">저도 비슷한 경험이
										있는데 정말 공감돼요. 다음번엔 꼭 이 팁 활용해볼게요!</p>
									<button type="button"
										class="flex items-center gap-1 mt-2 text-xs transition-colors"
										style="color: #9ca3af">
										<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
											stroke="currentColor" stroke-width="2">
											<path
												d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" /></svg>
										좋아요 8
									</button>
								</div>
							</div>
							<div class="flex gap-3">
								<div
									class="w-9 h-9 rounded-full shrink-0 flex items-center justify-center text-white text-sm font-bold"
									style="background-color: #F59E0B">나</div>
								<div class="flex-1 min-w-0">
									<div class="flex items-center gap-2 mb-1">
										<span class="text-sm font-bold text-gray-900">나연</span><span
											class="text-xs text-gray-400">2026.09.13</span>
									</div>
									<p class="text-sm text-gray-700 leading-relaxed">사진도 첨부해주시면
										더 좋을 것 같아요. 아무튼 꿀팁 감사합니다 😊</p>
									<button type="button"
										class="flex items-center gap-1 mt-2 text-xs transition-colors"
										style="color: #9ca3af">
										<svg width="13" height="13" viewBox="0 0 24 24" fill="none"
											stroke="currentColor" stroke-width="2">
											<path
												d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" /></svg>
										좋아요 4
									</button>
								</div>
							</div>
						</div>
						<div class="flex items-center gap-3 pt-5 border-t border-gray-100">
							<div
								class="w-9 h-9 rounded-full shrink-0 flex items-center justify-center text-white text-sm font-bold"
								style="background-color: var(- -brand)">나</div>
							<input type="text" placeholder="댓글을 입력해주세요..."
								class="jsp-focus flex-1 text-sm text-gray-700 placeholder-gray-400 outline-none border border-gray-200 rounded-full px-4 py-2.5 transition-all">
							<button type="button"
								class="jsp-brand-hover shrink-0 px-5 py-2.5 rounded-full text-white text-sm font-semibold transition-colors"
								style="background-color: var(- -brand)">등록</button>
						</div>
					</div>
					<div class="mt-6 mb-10">
						<h3 class="text-lg font-extrabold text-gray-900 mb-4">비슷한 꿀팁</h3>
						<div class="grid grid-cols-1 md:grid-cols-2 gap-4">
							<a
								href="${pageContext.request.contextPath}/view/tips/tipDetail.jsp?id=7"
								class="flex gap-3 p-4 bg-white rounded-2xl border border-gray-100 shadow-sm text-left w-full group hover:border-[#D1D2F9] transition-all"><img
								src="https://images.unsplash.com/photo-1572414323397-e7918784a4b7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxuZXclMjB5b3JrJTIwc3Vid2F5JTIwbWV0cm8lMjB0cmFuc3BvcnRhdGlvbnxlbnwxfHx8fDE3ODkyODM2NjB8MA&ixlib=rb-4.1.0&q=80&w=600"
								alt="뉴욕 지하철 이용 방법 (메트로카드, 노선, 주의사항)"
								class="shrink-0 w-16 h-14 rounded-xl object-cover">
							<div class="min-w-0">
									<h4
										class="font-bold text-sm text-gray-900 line-clamp-2 group-hover:text-[#6369D1] transition-colors">뉴욕
										지하철 이용 방법 (메트로카드, 노선, 주의사항)</h4>
									<p class="text-[10px] text-gray-400 mt-1">나 · 3일 전</p>
								</div></a>
						</div>
					</div>
				</div>
				<div
					class="hidden lg:flex flex-col items-center justify-center gap-3 rounded-2xl shrink-0"
					style="width: 160px; min-height: 600px; background-color: var(- -brand-light); color: var(- -brand)">
					<div
						class="w-12 h-12 rounded-full flex items-center justify-center font-extrabold text-sm text-white"
						style="background-color: var(- -brand)">AD</div>
					<p class="text-xs font-semibold text-center px-3"
						style="color: var(- -brand)">
						우측 광고 영역<br>
						<span class="text-[10px] font-normal opacity-60">(예:
							160x600)</span>
					</p>
				</div>
			</div>
		</div>
	</div><jsp:include page="/common/footer.jsp" /></body>
</html>