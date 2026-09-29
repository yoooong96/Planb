<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("activePage", "auth"); %>
<!DOCTYPE html><html lang="ko"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>회원가입 · Tripily</title><jsp:include page="/common/headStyles.jsp" /></head>
<body class="site-shell"><jsp:include page="/common/header.jsp" />
<main class="min-h-screen flex items-center justify-center px-4" style="background-color:#f5f5fb">
  <div class="w-full max-w-md">
    <div class="text-center mb-8"><a href="${pageContext.request.contextPath}/view/home/home.jsp" class="inline-flex items-center gap-2 mb-4"><span class="tripily-mark" aria-hidden="true"><svg width="22" height="22" viewBox="0 0 24 24" fill="none"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7Z" fill="var(--brand)"/><circle cx="12" cy="9" r="2.6" fill="white"/></svg></span><span class="text-2xl font-extrabold" style="color:var(--brand)">Tripily</span></a><h1 class="text-2xl font-extrabold text-gray-900 mb-1">회원가입</h1><p class="text-sm text-gray-500">Tripily와 함께 특별한 여행을 시작하세요.</p></div>
    <div class="bg-white rounded-3xl shadow-sm border border-gray-100 p-8">
      <form class="flex flex-col gap-4" action="#" method="post" data-signup-form>
        <div><label class="block text-sm font-semibold text-gray-700 mb-1.5">닉네임</label><input type="text" name="nickname" placeholder="사용할 닉네임을 입력하세요" class="jsp-focus w-full border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 placeholder-gray-400 outline-none transition-all"></div>
        <div><label class="block text-sm font-semibold text-gray-700 mb-1.5">이메일</label><input type="email" name="email" placeholder="example@email.com" class="jsp-focus w-full border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 placeholder-gray-400 outline-none transition-all"></div>
        <div><label class="block text-sm font-semibold text-gray-700 mb-1.5">비밀번호</label><input type="password" name="password" placeholder="8자 이상 입력하세요" class="jsp-focus w-full border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 placeholder-gray-400 outline-none transition-all"></div>
        <p class="text-sm text-red-500 font-medium jsp-hidden" data-signup-error>모든 항목을 입력해주세요.</p>
        <button type="submit" class="w-full py-3.5 rounded-xl text-white font-bold text-sm transition-all mt-1" style="background-color:var(--brand)">회원가입</button>
      </form>
      <p class="text-center text-sm text-gray-500 mt-6">이미 계정이 있으신가요? <a href="${pageContext.request.contextPath}/view/auth/login.jsp" class="font-bold" style="color:var(--brand)">로그인</a></p>
    </div>
  </div>
</main><jsp:include page="/common/footer.jsp" /></body></html>
