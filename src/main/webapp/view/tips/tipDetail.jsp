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

<title>여행꿀팁 상세 | Tripily</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/view/assets/css/tripily.css">
</head>

<body>

	<!-- =========================
         공통 Header
    ========================== -->

	<jsp:include page="/common/header.jsp" />


	<!-- =========================
         Main
    ========================== -->

	<main class="page">

		<!-- =====================
             게시글 대표 이미지
        ====================== -->

		<section class="detail-hero">

			<img
				src="https://images.unsplash.com/photo-1585208798174-6cedd86e019a?w=1600&q=85"
				alt="리스본 트램">

			<div class="detail-title">

				<span class="pill yellow"> TRANSPORT · LISBON </span>

				<h1>리스본 트램, 처음 타도 어렵지 않아요</h1>

				<div>여행좋아 · 2026.09.25 · 조회 682</div>

			</div>

		</section>


		<!-- =====================
             게시글 본문
        ====================== -->

		<div class="content-layout">

			<article class="article">

				<p>리스본의 트램은 여행자에게 아주 매력적인 교통수단이지만, 시간대와 노선을 잘 고르면 훨씬 편하게 이용할 수
					있어요.</p>


				<h2>1. 28번 트램은 오전에</h2>

				<p>점심 이후에는 관광객이 급격히 많아져요. 가능하면 오전 9시 이전에 출발하는 것을 추천합니다.</p>


				<h2>2. 교통카드 미리 충전</h2>

				<p>Viva Viagem 카드를 준비하면 탑승할 때 훨씬 편합니다.</p>


				<!-- 좋아요 / 신고 -->
				<div class="toolbar">

					<button type="button" class="btn secondary">♥ 좋아요 68</button>

					<button type="button" class="btn danger"
						data-modal-open="reportTip">⚑ 신고</button>

				</div>

			</article>


			<!-- =====================
                 작성자 정보
            ====================== -->

			<aside class="sticky-card panel">

				<b> 작성자 </b>

				<p class="page-desc">
					여행좋아 <br> @yeojong_trip
				</p>

				<a class="btn outline" style="width: 100%;"
					href="${pageContext.request.contextPath}/view/profile/userProfile.jsp">
					프로필 보기 </a>


				<hr style="border: 0; border-top: 1px solid #eee; margin: 18px 0;">


				<b> 관련 콘텐츠 </b>

				<p class="page-desc">
					포르투갈 교통패스 정리 <br> 리스본 숙소 위치 추천
				</p>

			</aside>

		</div>

	</main>


	<!-- =========================
         신고 Modal
    ========================== -->

	<div class="modal-backdrop" id="reportTip">

		<div class="modal">

			<div class="modal-head">

				<h3>콘텐츠 신고</h3>

				<button type="button" class="close-btn" data-modal-close="reportTip">
					×</button>

			</div>


			<div class="field">

				<label> 신고 사유 </label> <select>
					<option>부적절한 콘텐츠</option>
					<option>허위 정보</option>
					<option>도배/광고</option>
				</select>

			</div>


			<div class="field">

				<label> 상세 내용 </label>

				<textarea></textarea>

			</div>


			<div class="form-actions">

				<button type="button" class="btn danger"
					onclick="
                        closeModal('reportTip');
                        tripilyToast('신고가 접수되었습니다.');
                    ">
					신고</button>

			</div>

		</div>

	</div>


	<!-- =========================
         공통 Footer
    ========================== -->

	<jsp:include page="/common/footer.jsp" />


	<!-- =========================
         공통 JavaScript
    ========================== -->

	<script
		src="${pageContext.request.contextPath}/view/assets/js/tripily.js"></script>

</body>

</html>