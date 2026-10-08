<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link
	rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/mates/mateList.css">

<c:forEach var="mate" items="${mateList}">

	<a
		href="${pageContext.request.contextPath}/mateDetail?mateId=${mate.mateId}"
		class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all cursor-pointer group p-5 hover:border-[#D1D2F9]">

		<!-- 국가 / 모집 상태 -->
		<div class="flex items-center justify-between gap-2 mb-3">

			<!-- 국가 -->
			<span
				class="flex items-center gap-1 text-xs font-bold px-2.5 py-1 rounded-full"
				style="background: var(--brand-soft); color: var(--brand)">

				<svg
					width="10"
					height="10"
					viewBox="0 0 24 24"
					fill="none"
					stroke="currentColor"
					stroke-width="2">

					<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" />
					<circle cx="12" cy="10" r="3" />

				</svg>

				<c:out value="${mate.country}" />

			</span>


			<!-- 모집 상태 -->
			<c:choose>

				<c:when test="${mate.recruitStatus eq 'OPEN'}">

					<span
						class="inline-flex items-center gap-1 text-[11px] font-bold px-2.5 py-1 rounded-full"
						style="background: #ecfdf5; color: #059669">

						<span
							class="inline-block w-1.5 h-1.5 rounded-full"
							style="background: #10b981">
						</span>

						모집중

					</span>

				</c:when>

				<c:otherwise>

					<span
						class="inline-flex items-center gap-1 text-[11px] font-bold px-2.5 py-1 rounded-full"
						style="background: #f3f4f6; color: #6b7280">

						<span
							class="inline-block w-1.5 h-1.5 rounded-full"
							style="background: #9ca3af">
						</span>

						모집완료

					</span>

				</c:otherwise>

			</c:choose>

		</div>


		<!-- 제목 -->
		<h3
			class="font-bold text-[15px] text-gray-900 leading-snug mb-4 group-hover:text-brand transition-colors">

			<c:out value="${mate.title}" />

		</h3>


		<!-- 모집 인원 -->
		<div class="flex items-center gap-2 mb-4 flex-wrap">

			<span
				class="text-[11px] font-semibold px-2.5 py-1 rounded-full"
				style="background: var(--brand-light); color: var(--brand)">

				👥 ${mate.recruitCount}명 모집

			</span>

		</div>


		<hr class="line">


		<!-- 작성자 / 작성시간 / 조회수 -->
		<div class="flex items-center justify-between text-xs text-gray-400 border-t border-gray-50 pt-3">

			<!-- 작성자 / 작성시간 -->
			<div class="flex items-center gap-1.5">
		
				<span class="text-gray-600 font-medium">
					<c:out value="${mate.nickname}" />
				</span>
		
				<span class="text-[11px] text-gray-400 flex items-center gap-1">
					· ${mate.timeAgo}
				</span>
		
			</div>
		
		
			<!-- 좋아요 / 댓글 / 조회수 -->
			<div class="flex items-center gap-3 text-[11px] text-gray-400">
		
				<!-- 좋아요 -->
				<span class="flex items-center gap-1">
		
					<svg
						width="12"
						height="12"
						viewBox="0 0 24 24"
						fill="none"
						stroke="currentColor"
						stroke-width="2">
		
						<path d="M20.8 4.6a5.5 5.5 0 0 0-7.8 0L12 5.6l-1-1a5.5 5.5 0 0 0-7.8 7.8l1 1L12 21l7.8-7.6 1-1a5.5 5.5 0 0 0 0-7.8Z" />
		
					</svg>
		
					${mate.likeCount}
		
				</span>
		
		
				<!-- 댓글 -->
				<span class="flex items-center gap-1">
		
					<svg
						width="12"
						height="12"
						viewBox="0 0 24 24"
						fill="none"
						stroke="currentColor"
						stroke-width="2">
		
						<path d="M21 15a4 4 0 0 1-4 4H8l-5 3V7a4 4 0 0 1 4-4h10a4 4 0 0 1 4 4Z" />
		
					</svg>
		
					${mate.commentCount}
		
				</span>
		
		
				<!-- 조회수 -->
				<span class="flex items-center gap-1">
		
					<svg
						width="13"
						height="13"
						viewBox="0 0 24 24"
						fill="none"
						stroke="currentColor"
						stroke-width="2">
		
						<path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12Z" />
						<circle cx="12" cy="12" r="3" />
		
					</svg>
		
					${mate.viewCount}
		
				</span>
		
			</div>
		
		</div>

	</a>

</c:forEach>