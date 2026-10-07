<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="mate" items="${mateList}">
	<a
		href="${pageContext.request.contextPath}/mateDetail?mateId=${mate.mateId}"
		class="relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all cursor-pointer group p-5 hover:border-[#D1D2F9]">

		<div class="flex items-center gap-2 mb-3">
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

				${mate.country}
			</span>
		</div>

		<h3
			class="font-bold text-[15px] text-gray-900 leading-snug mb-4 group-hover:text-brand transition-colors">
			${mate.title}
		</h3>

		<div class="flex items-center gap-2 mb-4 flex-wrap">
			<span
				class="text-[11px] font-semibold px-2.5 py-1 rounded-full"
				style="background: var(--brand-light); color: var(--brand)">
				👥 ${mate.recruitCount}명 모집
			</span>

			<span class="text-[11px] text-gray-400 flex items-center gap-1">
				▣ ${mate.createdAt}
			</span>
		</div>

		<div
			class="flex items-center justify-between text-xs text-gray-400 border-t border-gray-50 pt-3">

			<div class="flex items-center gap-1.5">
				<span class="text-gray-600 font-medium">
					작성자 #${mate.userId}
				</span>
			</div>

			<div class="flex items-center gap-3">
				<span>◉ ${mate.viewCount}</span>
			</div>
		</div>
	</a>
</c:forEach>