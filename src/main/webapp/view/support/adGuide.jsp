<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

request.setAttribute(
        "activePage",
        "profile"
);

request.setAttribute(
        "settingsPage",
        "support"
);

String ctx =
        request.getContextPath();

%>


<!DOCTYPE html>

<html lang="ko">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<title>광고 안내 · Planb</title>


<jsp:include page="/common/headStyles.jsp" />


<link rel="stylesheet"
	href="<%=ctx%>/view/assets/css/setting/settings.css">


<link rel="stylesheet"
	href="<%=ctx%>/view/assets/css/support/support.css">


</head>


<body class="site-shell">


	<jsp:include page="/common/header.jsp" />


	<div class="settings-page">


		<div class="settings-shell">


			<jsp:include page="/common/settingsSidebar.jsp" />



			<main class="settings-main">


				<div class="settings-content ad-guide-content">


					<!-- =====================================================
                     상단 제목
                ====================================================== -->

					<header class="settings-title">

						<span class="settings-eyebrow"> ADVERTISEMENT </span>


						<h1>광고 안내</h1>


						<p>Planb를 이용하는 여행자에게 브랜드와 서비스를 소개해보세요.</p>

					</header>



					<a class="support-back" href="<%=ctx%>/support/support">

						‹ 고객지원 </a>



					<!-- =====================================================
                     HERO
                ====================================================== -->

					<section class="ad-guide-hero">


						<div class="ad-guide-hero-copy">


							<span class="ad-guide-chip"> Planb Advertisement </span>


							<h2>

								여행을 준비하는 순간에<br> <strong> 브랜드를 자연스럽게 노출하세요. </strong>

							</h2>


							<p>숙박, 관광, 음식점, 여행상품 등 여행과 관련된 다양한 서비스를 Planb 사용자에게 소개할 수
								있습니다.</p>



							<div class="ad-guide-hero-actions">


								<a href="#adPlacement" class="ad-guide-btn ad-guide-btn-primary">

									광고 영역 살펴보기 </a> <a href="<%=ctx%>/support/adInquiry"
									class="ad-guide-btn ad-guide-btn-soft"> 바로 문의하기 </a>


							</div>


						</div>



						<!-- 우측 광고 미리보기 -->

						<div class="ad-guide-hero-preview">


							<div class="ad-browser">


								<div class="ad-browser-top">

									<span></span> <span></span> <span></span>

								</div>


								<div class="ad-browser-content">


									<div class="ad-browser-logo">Planb</div>


									<div class="ad-browser-banner">

										<span> MAIN BANNER </span> <strong> 여기에 광고가 노출됩니다 </strong>

									</div>


									<div class="ad-browser-cards">


										<div></div>

										<div class="ad-browser-ad-card">AD</div>

										<div></div>


									</div>


								</div>


							</div>


						</div>


					</section>



					<!-- =====================================================
                     광고 영역
                ====================================================== -->

					<section class="ad-guide-section" id="adPlacement">


						<div class="ad-guide-section-head">


							<span class="ad-guide-section-number"> 01 </span>


							<div>

								<h2>광고 영역</h2>


								<p>광고 목적에 맞는 노출 위치를 선택하세요.</p>

							</div>


						</div>



						<div class="ad-placement-grid">


							<!-- 메인 배너 -->

							<article class="ad-placement-card">


								<div class="ad-placement-preview ad-placement-preview-main">


									<div class="ad-preview-header">

										<span> Planb </span>


										<div></div>
										<div></div>
										<div></div>

									</div>


									<div class="ad-main-banner">

										<span class="ad-preview-label"> AD </span> <strong>
											MAIN BANNER </strong> <small> 메인 화면 상단 </small>


									</div>


									<div class="ad-preview-line"></div>

									<div class="ad-preview-line short"></div>


								</div>



								<div class="ad-placement-copy">


									<div class="ad-placement-title-row">

										<h3>메인 배너</h3>


										<span> MAIN_BANNER </span>

									</div>


									<p>홈 화면 상단의 넓은 영역에 노출되는 대표 광고입니다.</p>



									<div class="ad-placement-tags">

										<span> 높은 노출도 </span> <span> 브랜드 홍보 </span> <span> 프로모션
										</span>

									</div>


									<ul>

										<li>메인 화면에서 즉시 노출</li>

										<li>넓은 이미지 활용 가능</li>

										<li>브랜드·여행상품 홍보에 적합</li>

									</ul>


									<a class="ad-placement-select"
										href="<%=ctx%>/support/adInquiry?adPosition=MAIN_BANNER">

										메인 배너 문의하기 → </a>


								</div>


							</article>



							<!-- 여행 카드 광고 -->

							<article class="ad-placement-card">


								<div class="ad-placement-preview">


									<div class="ad-card-preview-grid">


										<div class="ad-card-preview-item">

											<div></div>

											<span> 여행 일정 </span>

										</div>


										<div class="ad-card-preview-item active">

											<div>

												<span> AD </span>

											</div>

											<strong> TRIP CARD </strong>

										</div>


										<div class="ad-card-preview-item">

											<div></div>

											<span> 여행 일정 </span>

										</div>


										<div class="ad-card-preview-item">

											<div></div>

											<span> 여행 일정 </span>

										</div>


									</div>


								</div>



								<div class="ad-placement-copy">


									<div class="ad-placement-title-row">

										<h3>여행 카드 광고</h3>


										<span> TRIP_CARD </span>

									</div>


									<p>여행 일정 목록 사이에 자연스럽게 노출되는 카드형 광고입니다.</p>



									<div class="ad-placement-tags">

										<span> 자연스러운 노출 </span> <span> 여행 관심 사용자 </span> <span>
											지역 광고 </span>

									</div>


									<ul>

										<li>여행 콘텐츠와 함께 노출</li>

										<li>관광지·숙박·음식점에 적합</li>

										<li>지역 기반 광고에 활용 가능</li>

									</ul>


									<a class="ad-placement-select"
										href="<%=ctx%>/support/adInquiry?adPosition=TRIP_CARD">

										여행 카드 문의하기 → </a>


								</div>


							</article>


						</div>


					</section>



					<!-- =====================================================
                     가격
                ====================================================== -->

					<section class="ad-guide-section">


						<div class="ad-guide-section-head">


							<span class="ad-guide-section-number"> 02 </span>


							<div>

								<h2>광고 가격 안내</h2>


								<p>원하는 광고 위치와 기간을 확인하세요.</p>

							</div>


						</div>



						<div class="ad-price-panel">


							<div class="ad-price-table-wrap">


								<table class="ad-price-table">


									<thead>

										<tr>

											<th>광고 상품</th>

											<th>7일</th>

											<th>14일</th>

											<th>30일</th>

										</tr>

									</thead>


									<tbody>


										<tr>

											<td><strong> 메인 배너 </strong> <small> MAIN_BANNER
											</small></td>


											<td>50,000원</td>


											<td class="ad-price-popular"><span> 추천 </span> 90,000원</td>


											<td>160,000원</td>

										</tr>



										<tr>

											<td><strong> 여행 카드 </strong> <small> TRIP_CARD </small>

											</td>


											<td>30,000원</td>


											<td class="ad-price-popular"><span> 추천 </span> 50,000원</td>


											<td>90,000원</td>

										</tr>


									</tbody>


								</table>


							</div>



							<div class="ad-price-notice">


								<svg width="18" height="18" viewBox="0 0 24 24" fill="none"
									stroke="currentColor" stroke-width="1.8">

                                <circle cx="12" cy="12" r="9">
                                </circle>

                                <path d="M12 11v5">
                                </path>

                                <path d="M12 8h.01">
                                </path>

                            </svg>


								<div>

									<strong> 가격 안내 </strong>


									<p>

										표시된 가격은 기본 광고 비용입니다. 노출 위치, 지역 및 요청 내용에 따라 최종 금액이 달라질 수 있습니다.

										<br> 문의 접수 후 담당자가 광고 내용을 검토하여 최종 금액을 안내드립니다.

									</p>

								</div>


							</div>


						</div>


					</section>



					<!-- =====================================================
                     진행 절차
                ====================================================== -->

					<section class="ad-guide-section">


						<div class="ad-guide-section-head">


							<span class="ad-guide-section-number"> 03 </span>


							<div>

								<h2>광고 진행 절차</h2>


								<p>문의 접수부터 광고 게시까지의 과정입니다.</p>

							</div>


						</div>



						<div class="ad-process-grid">


							<article class="ad-process-item">


								<span class="ad-process-number"> 01 </span>


								<div class="ad-process-icon">

									<svg width="22" height="22" viewBox="0 0 24 24" fill="none"
										stroke="currentColor" stroke-width="1.7">

                                    <path d="M4 4h16v16H4z">
                                    </path>

                                    <path d="M8 9h8M8 13h8M8 17h5">
                                    </path>

                                </svg>

								</div>


								<h3>광고 문의 접수</h3>


								<p>업체 정보와 광고 이미지, 희망 기간 및 위치를 입력합니다.</p>


							</article>



							<div class="ad-process-arrow">→</div>



							<article class="ad-process-item">


								<span class="ad-process-number"> 02 </span>


								<div class="ad-process-icon">

									<svg width="22" height="22" viewBox="0 0 24 24" fill="none"
										stroke="currentColor" stroke-width="1.7">

                                    <circle cx="11" cy="11" r="6">
                                    </circle>

                                    <path d="m16 16 4 4">
                                    </path>

                                </svg>

								</div>


								<h3>관리자 검토</h3>


								<p>광고 이미지와 내용, 희망 노출 기간을 검토합니다.</p>


							</article>



							<div class="ad-process-arrow">→</div>



							<article class="ad-process-item">


								<span class="ad-process-number"> 03 </span>


								<div class="ad-process-icon">

									<svg width="22" height="22" viewBox="0 0 24 24" fill="none"
										stroke="currentColor" stroke-width="1.7">

                                    <path d="m5 12 4 4L19 6">
                                    </path>

                                </svg>

								</div>


								<h3>광고 승인</h3>


								<p>검토가 완료되면 담당자가 승인 결과를 안내합니다.</p>


							</article>



							<div class="ad-process-arrow">→</div>



							<article class="ad-process-item">


								<span class="ad-process-number"> 04 </span>


								<div class="ad-process-icon">

									<svg width="22" height="22" viewBox="0 0 24 24" fill="none"
										stroke="currentColor" stroke-width="1.7">

                                    <path d="M4 5h16v11H4z">
                                    </path>

                                    <path d="M9 20h6">
                                    </path>

                                    <path d="M12 16v4">
                                    </path>

                                </svg>

								</div>


								<h3>광고 게시</h3>


								<p>승인된 광고는 지정된 시작일부터 노출됩니다.</p>


							</article>


						</div>


					</section>



					<!-- =====================================================
                     준비 사항
                ====================================================== -->

					<section class="ad-guide-section">


						<div class="ad-guide-section-head">


							<span class="ad-guide-section-number"> 04 </span>


							<div>

								<h2>광고 신청 전 준비사항</h2>


								<p>아래 내용을 미리 준비하면 빠르게 접수할 수 있습니다.</p>

							</div>


						</div>



						<div class="ad-prepare-grid">


							<div class="ad-prepare-item">

								<span>✓</span>

								<div>

									<strong> 업체 정보 </strong> <small> 업체명과 담당자명 </small>

								</div>

							</div>



							<div class="ad-prepare-item">

								<span>✓</span>

								<div>

									<strong> 연락처 </strong> <small> 전화번호와 이메일 </small>

								</div>

							</div>



							<div class="ad-prepare-item">

								<span>✓</span>

								<div>

									<strong> 광고 이미지 </strong> <small> 실제 노출할 광고 이미지 </small>

								</div>

							</div>



							<div class="ad-prepare-item">

								<span>✓</span>

								<div>

									<strong> 광고 내용 </strong> <small> 홍보하려는 상품 또는 서비스 </small>

								</div>

							</div>



							<div class="ad-prepare-item">

								<span>✓</span>

								<div>

									<strong> 연결 주소 </strong> <small> 광고 클릭 시 이동할 URL </small>

								</div>

							</div>



							<div class="ad-prepare-item">

								<span>✓</span>

								<div>

									<strong> 희망 기간 </strong> <small> 광고 시작일과 종료일 </small>

								</div>

							</div>


						</div>


					</section>



					<!-- =====================================================
                     마지막 CTA
                ====================================================== -->

					<section class="ad-guide-final">


						<span> READY TO ADVERTISE? </span>


						<h2>광고를 시작해 볼까요?</h2>


						<p>원하는 광고 위치와 기간을 선택하고 광고 문의를 접수해주세요.</p>


						<a href="<%=ctx%>/support/adInquiry"
							class="ad-guide-final-button"> 광고 문의하기 <svg width="17"
								height="17" viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="2">

                            <path d="m9 18 6-6-6-6">
                            </path>

                        </svg>

						</a>


					</section>


				</div>


			</main>


		</div>


	</div>


	<jsp:include page="/common/footer.jsp" />


</body>

</html>