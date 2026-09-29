<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("activePage", "home"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Tripily · Travel Plan Share</title>
<jsp:include page="/common/headStyles.jsp" />
</head>
<body class="figma-home-body">
<jsp:include page="/common/header.jsp" />
<main class="home-figma">
  <section class="home-hero">
    <div class="home-hero-image"></div>
    <div class="home-hero-overlay"></div>
    <div class="home-hero-content">
      <div class="home-eyebrow">✈ Travel Plan Share</div>
      <h1>Plan less.&nbsp;<span>Wander</span> more.</h1>
      <p>계획보다 중요한 건, <strong>일단 떠나는 것</strong>&nbsp;·&nbsp;실제로 다녀온 사람들의 진짜 이야기</p>
      <form class="home-search" action="${pageContext.request.contextPath}/view/search/searchResult.jsp" method="get">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/></svg>
        <input name="q" placeholder="여행지, 일정, 꿀팁 등 무엇이든 검색해보세요">
        <button type="submit" aria-label="검색"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2.5"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/></svg></button>
      </form>
    </div>
    <button class="home-scroll-hint" type="button" data-scroll-popular aria-label="아래로 스크롤"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 5v14M5 12l7 7 7-7"/></svg></button>
  </section>

  <section class="home-popular" id="popularPlans">
    <div class="home-section-head centered">
      <p>Popular Travel Plans</p>
      <h2>지금 가장 인기 있는 여행일정</h2>
      <span>전 세계 여행자들이 사랑하는 특별한 일정을 만나보세요.</span>
    </div>
    <div class="home-carousel" data-home-carousel>
      <a class="home-plan-card" href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=7">
        <div class="home-plan-media"><img src="https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=600&h=400&fit=crop" alt="도쿄"><span class="home-region-tag">도쿄</span><button class="home-bookmark" type="button" data-bookmark aria-label="북마크"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z"/></svg></button><span class="home-duration">3박 4일</span></div>
        <div class="home-plan-body"><h3>도쿄 3박 4일 완전 정복</h3><p>시부야, 아키하바라, 아사쿠사! 도쿄의 모든 것을 담은 알찬 일정.</p><div class="home-plan-stats"><span>▰ 921</span><span>◉ 4,210</span></div><div class="home-plan-author"><span><img src="https://i.pravatar.cc/40?img=13" alt="재팬러버">재팬러버</span><time>2026.08.05</time></div></div>
      </a>
      <a class="home-plan-card" href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=3">
        <div class="home-plan-media"><img src="https://images.unsplash.com/photo-1538485399081-7191377e8241?w=600&h=400&fit=crop" alt="부산"><span class="home-region-tag">부산</span><button class="home-bookmark" type="button" data-bookmark aria-label="북마크"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z"/></svg></button><span class="home-duration">1박 2일</span></div>
        <div class="home-plan-body"><h3>부산 1박 2일 바다 여행</h3><p>해운대와 광안리, 자갈치시장까지! 부산 핵심 코스.</p><div class="home-plan-stats"><span>▰ 512</span><span>◉ 2,341</span></div><div class="home-plan-author"><span><img src="https://i.pravatar.cc/40?img=5" alt="바다러버">바다러버</span><time>2026.08.10</time></div></div>
      </a>
      <a class="home-plan-card" href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=5">
        <div class="home-plan-media"><img src="https://images.unsplash.com/photo-1674606042265-c9f03a77e286?w=600&h=400&fit=crop" alt="강릉"><span class="home-region-tag">강릉</span><button class="home-bookmark" type="button" data-bookmark aria-label="북마크"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z"/></svg></button><span class="home-duration">1박 2일</span></div>
        <div class="home-plan-body"><h3>강릉 1박 2일 커피 &amp; 바다</h3><p>안목해변 커피거리와 강릉 바다의 아름다움을 즐기는 힐링 코스.</p><div class="home-plan-stats"><span>▰ 445</span><span>◉ 1,890</span></div><div class="home-plan-author"><span><img src="https://i.pravatar.cc/40?img=9" alt="커피향">커피향</span><time>2026.08.01</time></div></div>
      </a>
      <a class="home-plan-card" href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=1">
        <div class="home-plan-media"><img src="https://images.unsplash.com/photo-1628411848698-e3b3249a272a?w=600&h=400&fit=crop" alt="제주도"><span class="home-region-tag">제주도</span><button class="home-bookmark" type="button" data-bookmark aria-label="북마크"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z"/></svg></button><span class="home-duration">2박 3일</span></div>
        <div class="home-plan-body"><h3>제주도 2박 3일 힐링 여행</h3><p>바다, 맛집, 자연까지! 처음 가는 분들도 따라가기 쉬운 코스.</p><div class="home-plan-stats"><span>▰ 328</span><span>◉ 1,234</span></div><div class="home-plan-author"><span><img src="https://i.pravatar.cc/40?img=12" alt="여행좋아">여행좋아</span><time>2026.08.20</time></div></div>
      </a>
      <a class="home-plan-card" href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=6">
        <div class="home-plan-media"><img src="https://images.unsplash.com/photo-1758327740327-61826f744965?w=600&h=400&fit=crop" alt="전주"><span class="home-region-tag">전주</span><button class="home-bookmark" type="button" data-bookmark aria-label="북마크"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z"/></svg></button><span class="home-duration">1박 2일</span></div>
        <div class="home-plan-body"><h3>전주 1박 2일 한옥 &amp; 맛집</h3><p>전주한옥마을과 비빔밥, 콩나물국밥! 미식가를 위한 전주 완전정복.</p><div class="home-plan-stats"><span>▰ 267</span><span>◉ 1,102</span></div><div class="home-plan-author"><span><img src="https://i.pravatar.cc/40?img=11" alt="맛집탐방">맛집탐방</span><time>2026.07.20</time></div></div>
      </a>
      <a class="home-plan-card" href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=2">
        <div class="home-plan-media"><img src="https://images.unsplash.com/photo-1506816561089-5cc37b3aa9b0?w=600&h=400&fit=crop" alt="서울"><span class="home-region-tag">서울</span><button class="home-bookmark" type="button" data-bookmark aria-label="북마크"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z"/></svg></button><span class="home-duration">2박 3일</span></div>
        <div class="home-plan-body"><h3>서울 2박 3일 역사 탐방</h3><p>경복궁부터 북촌까지, 서울의 숨겨진 역사를 따라가는 특별한 여행.</p><div class="home-plan-stats"><span>▰ 214</span><span>◉ 876</span></div><div class="home-plan-author"><span><img src="https://i.pravatar.cc/40?img=3" alt="히스토리맨">히스토리맨</span><time>2026.08.15</time></div></div>
      </a>
      <a class="home-plan-card" href="${pageContext.request.contextPath}/view/travel/scheduleDetail.jsp?id=4">
        <div class="home-plan-media"><img src="https://images.unsplash.com/photo-1597552661064-af143a5f3bee?w=600&h=400&fit=crop" alt="경주"><span class="home-region-tag">경주</span><button class="home-bookmark" type="button" data-bookmark aria-label="북마크"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z"/></svg></button><span class="home-duration">1박 2일</span></div>
        <div class="home-plan-body"><h3>경주 1박 2일 문화 여행</h3><p>천년 고도 경주에서 신라의 역사와 문화를 만나보세요.</p><div class="home-plan-stats"><span>▰ 178</span><span>◉ 654</span></div><div class="home-plan-author"><span><img src="https://i.pravatar.cc/40?img=7" alt="문화탐험가">문화탐험가</span><time>2026.07.28</time></div></div>
      </a>
    </div>
  </section>

  <section class="home-community-preview">
    <div class="home-preview-column">
      <div class="home-preview-head"><div><p>Travel Tips</p><h2>여행꿀팁</h2><span>여행 고수들의 노하우</span></div><a class="home-more" href="${pageContext.request.contextPath}/view/tips/tipList.jsp">더보기 <b>→</b></a></div>
      <div class="home-preview-list" data-rotating-list="tips">
        <a class="home-preview-card" href="${pageContext.request.contextPath}/view/tips/tipDetail.jsp?id=3"><img src="https://images.unsplash.com/photo-1591814468924-caf88d1232e1?fit=crop&w=300&q=80" alt="후쿠오카"><div><span class="home-category food">음식</span><h3>후쿠오카에서 꼭 먹어야 하는 현지 음식 7가지</h3><small><i style="background:#F59E0B">민</i> 민수 · 1일 전</small></div></a>
        <a class="home-preview-card" href="${pageContext.request.contextPath}/view/tips/tipDetail.jsp?id=6"><img src="https://images.unsplash.com/photo-1561501900-3701fa6a0864?fit=crop&w=300&q=80" alt="발리"><div><span class="home-category stay">숙박</span><h3>발리 숙소 지역별 추천 (꾸따, 스미냑, 우붓 비교)</h3><small><i style="background:#10B981">한</i> 한우 · 3일 전</small></div></a>
        <a class="home-preview-card" href="${pageContext.request.contextPath}/view/tips/tipDetail.jsp?id=4"><img src="https://images.unsplash.com/photo-1488415032361-b7e238421f1b?fit=crop&w=300&q=80" alt="아이슬란드"><div><span class="home-category culture">문화</span><h3>아이슬란드 오로라 여행 팁 (시기, 준비물, 촬영방법)</h3><small><i style="background:#EC4899">나</i> 나 · 1일 전</small></div></a>
      </div>
      <div class="home-progress"><button class="active"><span></span></button><button></button><button></button></div>
    </div>

    <div class="home-preview-column">
      <div class="home-preview-head"><div><p>Travel Mate</p><h2>여행 메이트</h2><span>함께 여행할 동반자</span></div><a class="home-more" href="${pageContext.request.contextPath}/view/mate/mateList.jsp">더보기 <b>→</b></a></div>
      <div class="home-preview-list" data-rotating-list="mates">
        <a class="home-preview-card mate" href="${pageContext.request.contextPath}/view/mate/mateDetail.jsp?id=4"><div class="home-mate-icon">⌖<span>이탈리아</span></div><div><span class="home-mate-meta">이탈리아 · 로마 <em>2명 모집</em></span><h3>🍕 10/15-22 로마·피렌체·베네치아 맛집 여행 동행</h3><small><i style="background:#EC4899">서</i> 서연 · 2026.09.09</small></div></a>
        <a class="home-preview-card mate" href="${pageContext.request.contextPath}/view/mate/mateDetail.jsp?id=5"><div class="home-mate-icon">⌖<span>영국</span></div><div><span class="home-mate-meta">영국 · 런던 <em>3명 모집</em></span><h3>🎓 11월 런던 어학연수 · 영어 회화 파트너 구해요</h3><small><i style="background:#10B981">도</i> 도현 · 2026.09.08</small></div></a>
        <a class="home-preview-card mate" href="${pageContext.request.contextPath}/view/mate/mateDetail.jsp?id=1"><div class="home-mate-icon">⌖<span>일본</span></div><div><span class="home-mate-meta">일본 · 도쿄 <em>1명 모집</em></span><h3>🗼 11/10-14 도쿄 4박 · 맛집+카페+쇼핑 동행 1명</h3><small><i style="background:#8B5CF6">지</i> 지민 · 2026.09.10</small></div></a>
      </div>
      <div class="home-progress"><button class="active"><span></span></button><button></button><button></button></div>
    </div>
  </section>
</main>
<jsp:include page="/common/footer.jsp" />
</body>
</html>
