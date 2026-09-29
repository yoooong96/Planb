<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage", "auth");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>로그인 · Tripily</title><jsp:include page="/common/headStyles.jsp" /></head>
<body class="site-shell"><jsp:include page="/common/header.jsp" />
	<main class="min-h-screen flex items-center justify-center px-4"
		style="background-color: #f5f5fb">
		<div class="w-full max-w-md">
			<div class="text-center mb-8">
				<a href="${pageContext.request.contextPath}/view/home/home.jsp"
					class="inline-flex items-center gap-2 mb-4"><span
					class="tripily-mark" aria-hidden="true"><svg width="22"
							height="22" viewBox="0 0 24 24" fill="none">
							<path
								d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7Z"
								fill="var(--brand)" />
							<circle cx="12" cy="9" r="2.6" fill="white" /></svg></span><span
					class="text-2xl font-extrabold" style="color: var(- -brand)">Tripily</span></a>
				<h1 class="text-2xl font-extrabold text-gray-900 mb-1">로그인</h1>
				<p class="text-sm text-gray-500">여행 일정을 공유하고 메이트를 찾아보세요.</p>
			</div>
			<div
				class="bg-white rounded-3xl shadow-sm border border-gray-100 p-8">
				<form class="flex flex-col gap-4" action="#" method="post"
					data-auth-form>
					<div>
						<label class="block text-sm font-semibold text-gray-700 mb-1.5">이메일</label><input
							type="email" name="email" placeholder="example@email.com"
							class="jsp-focus w-full border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 placeholder-gray-400 outline-none transition-all">
					</div>
					<div>
						<label class="block text-sm font-semibold text-gray-700 mb-1.5">비밀번호</label><input
							type="password" name="password" placeholder="비밀번호를 입력하세요"
							class="jsp-focus w-full border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 placeholder-gray-400 outline-none transition-all">
					</div>
					<p class="text-sm text-red-500 font-medium jsp-hidden"
						data-auth-error>이메일과 비밀번호를 입력해주세요.</p>
					<button type="submit"
						class="w-full py-3.5 rounded-xl text-white font-bold text-sm transition-all mt-1"
						style="background-color: var(- -brand)">로그인</button>
				</form>
				<div class="flex items-center gap-3 my-6">
					<div class="flex-1 h-px bg-gray-100"></div>
					<span class="text-xs text-gray-400 font-medium">또는</span>
					<div class="flex-1 h-px bg-gray-100"></div>
				</div>
				<p class="text-center text-sm text-gray-500">
					아직 회원이 아니신가요? <a
						href="${pageContext.request.contextPath}/view/auth/signup.jsp"
						class="font-bold" style="color: var(- -brand)">회원가입</a>
				</p>
			</div>
			<p class="text-center text-xs text-gray-400 mt-6">
				로그인 시 <span class="underline cursor-pointer">이용약관</span> 및 <span
					class="underline cursor-pointer">개인정보처리방침</span>에 동의하는 것으로 간주합니다.
			</p>
		</div>
	</main><jsp:include page="/common/footer.jsp" /></body>
</html>
