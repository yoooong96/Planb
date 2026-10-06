<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%request.setAttribute("activePage", "tips");%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>내가 작성한 글 | Tripily</title>
	<jsp:include page="/common/headStyles.jsp" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/view/assets/css/tips/tipWriteList.css">
</head>
<body class="site-shell">
	<jsp:include page="/common/header.jsp" />
	<!-- ================================
	     상단 배너
	================================ -->
	<section class="tip-my-banner">
		<div class="tip-my-banner-inner">
			<div class="tip-my-banner-text">
				<p class="tip-my-breadcrumb">
					여행꿀팁<span>›</span>내가 작성한 글
				</p>
				<h1>내가 작성한 글</h1>
				<p class="tip-my-description">
					총 <strong>${totalCount}</strong>개의 여행 꿀팁을 작성했습니다.
				</p>
			</div>
			<div class="tip-my-banner-actions"> 
				<!-- 여행꿀팁 목록 -->
				<a href="${pageContext.request.contextPath}/tips" class="tip-list-btn"> 
					<svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
					</svg>
					여행꿀팁 목록
				</a>
				<!-- 새 글 작성 -->
				<a href="${pageContext.request.contextPath}/tipWrite" class="tip-write-btn">
					<svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
					</svg>
					새 글 쓰기
				</a>
			</div>
		</div>
	</section>
	<!-- ================================
	     내가 작성한 글 목록
	================================ -->
	<main class="tip-my-main">
		<div class="tip-my-list">
			<!-- 작성 글 없음 -->
			<c:if test="${empty tipList}">
				<div class="tip-my-empty">
					<div class="tip-my-empty-icon">✏️</div>
					<h2>아직 작성한 여행 꿀팁이 없습니다.</h2>
					<p>여행에서 알게 된 유용한 정보를 공유해보세요.
					<a href="${pageContext.request.contextPath}/tipWrite">첫 여행 꿀팁 작성하기</a>
				</div>
			</c:if>
			<!-- 작성 글 목록 -->
			<c:forEach var="tip" items="${tipList}">
				<article class="tip-my-card">
					<div class="tip-my-card-content">
						<!-- 해시태그 -->
						<c:if test="${not empty tip.hashtag}">
							<div class="tip-my-tags">
								<c:forEach var="tag" items="${tip.hashtagList}">
									<span>${tag}</span>
								</c:forEach>
							</div>
						</c:if>
						<!-- 제목 -->
						<h2 class="tip-my-title">
							${tip.title}
						</h2>
						<!-- 게시글 정보 -->
						<div class="tip-my-meta"> 
							<span>${tip.timeAgo}</span> 
							<span class="tip-my-meta-item"> 
								<svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
									<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
										d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z" />
									<circle cx="12" cy="12" r="3" />
								</svg>
								${tip.viewCount}
							</span>
							<span class="tip-my-meta-item">
								<svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
									<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
										d="M21 15a4 4 0 01-4 4H8l-5 3V7a4 4 0 014-4h10a4 4 0 014 4z" />
								</svg>
								${tip.commentCount}
							</span>
						</div>
					</div>
					<!-- 수정 / 삭제 버튼 -->
					<div class="tip-my-card-actions">
						<a href="${pageContext.request.contextPath}/tipModify?tipId=${tip.tipId}" class="tip-edit-btn">
						    <svg xmlns="http://www.w3.org/2000/svg"
						         width="16"
						         height="16"
						         viewBox="0 0 24 24"
						         fill="none"
						         stroke="currentColor"
						         stroke-width="2"
						         stroke-linecap="round"
						         stroke-linejoin="round">
						        <path d="M12 20h9"/>
						        <path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4Z"/>
						    </svg>
						    수정하기
						</a>
						<button type="button" class="tip-delete-btn" data-tip-id="${tip.tipId}">
							<svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
									d="M3 6h18M8 6V4h8v2m-9 0 1 14h8l1-14M10 11v5M14 11v5" />
							</svg>
							삭제하기
						</button>
					</div>
				</article>
			</c:forEach>
			<!-- ========================================
			     페이지네이션
			======================================== -->
			<c:if test="${totalPages > 0}">
			    <nav class="tip-write-pagination" aria-label="페이지 이동">
			        <c:choose>
			            <c:when test="${currentPage > 1}">
			                <a href="${pageContext.request.contextPath}/tipWriteList?page=${currentPage - 1}"
			                   class="tip-page-btn tip-page-arrow"
			                   aria-label="이전 페이지">
			                    ‹
			                </a>
			            </c:when>
			            <c:otherwise>
			                <span class="tip-page-btn tip-page-arrow disabled">
			                    ‹
			                </span>
			            </c:otherwise>
			        </c:choose>
			        <c:forEach var="pageNum" begin="1" end="${totalPages}">
			            <c:choose>
			                <c:when test="${pageNum == currentPage}">
			                    <span class="tip-page-btn active">
			                        ${pageNum}
			                    </span>
			                </c:when>
			                <c:otherwise>
			                    <a href="${pageContext.request.contextPath}/tipWriteList?page=${pageNum}"
			                       class="tip-page-btn">
			                        ${pageNum}
			                    </a>
			                </c:otherwise>
			            </c:choose>
			        </c:forEach>
			        <c:choose>
			            <c:when test="${currentPage < totalPages}">
			                <a href="${pageContext.request.contextPath}/tipWriteList?page=${currentPage + 1}"
			                   class="tip-page-btn tip-page-arrow"
			                   aria-label="다음 페이지">
			                    ›
			                </a>
			            </c:when>
			            <c:otherwise>
			                <span class="tip-page-btn tip-page-arrow disabled">
			                    ›
			                </span>
			            </c:otherwise>
			        </c:choose>
			    </nav>
			</c:if>
		</div>
	</main>
	<jsp:include page="/common/footer.jsp" />
</body>
</html>