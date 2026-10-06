<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="dto.member.UserDto"
	import="dto.profile.ProfileFeedDto" import="java.util.List"%>


<%
request.setAttribute("activePage", "profile");

String ctx = request.getContextPath();

/* =========================

   로그인 사용자

========================= */

UserDto user = (UserDto) session.getAttribute("user");

/* 로그인하지 않은 상태에서 직접 접근한 경우 */

if (user == null) {

	response.sendRedirect(ctx + "/view/auth/login.jsp");

	return;

}

/* =========================

   회원 정보

========================= */

String loginId = user.getLoginId() == null ? "" : user.getLoginId();

String name = user.getName() == null ? "" : user.getName();

String nickname = user.getNickName() == null ? "" : user.getNickName();

String bio = user.getBio() == null ? "" : user.getBio();

String region = user.getRegion() == null ? "" : user.getRegion();

String profileImg = user.getProfileImg() == null ? "" : user.getProfileImg();

String phone = user.getPhone() == null ? "" : user.getPhone();

String postcode = user.getPostcode() == null ? "" : user.getPostcode();

String address = user.getAddress() == null ? "" : user.getAddress();

String addressDetail = user.getAddressDetail() == null ? "" : user.getAddressDetail();

String birthDate = user.getBirthDate() == null ? "" : user.getBirthDate().toString();

/* =========================

   프로필 이미지 경로



   CommonFilter:

   profilePath = /profiles

========================= */

String profilePath = (String) application.getAttribute("profilePath");

if (profilePath == null || profilePath.trim().isEmpty()) {

	profilePath = "/profiles";

}

/* =========================
내 여행 일정
========================= */

List<ProfileFeedDto> myItineraries =(List<ProfileFeedDto>) request.getAttribute("myItineraries");

if (myItineraries == null) {
 myItineraries = new java.util.ArrayList<ProfileFeedDto>();
}

List<ProfileFeedDto> bookmarkedItineraries =(List<ProfileFeedDto>) request.getAttribute("bookmarkedItineraries");
if (bookmarkedItineraries == null) {
	bookmarkedItineraries = new java.util.ArrayList<ProfileFeedDto>();
}

List<ProfileFeedDto> likedItineraries =(List<ProfileFeedDto>) request.getAttribute("likedItineraries");
if (likedItineraries == null) {
	likedItineraries = new java.util.ArrayList<ProfileFeedDto>();
}



Integer postCount = (Integer) request.getAttribute("postCount");

Integer likeCount = (Integer) request.getAttribute("likeCount");

Integer bookmarkCount = (Integer) request.getAttribute("bookmarkCount");

if (postCount == null) {

	postCount = 0;

}

if (likeCount == null) {

	likeCount = 0;

}

if (bookmarkCount == null) {

	bookmarkCount = 0;

}
%>



<!DOCTYPE html>



<html lang="ko">



<head>



<meta charset="UTF-8">



<meta name="viewport" content="width=device-width, initial-scale=1">



<title>내 프로필 · Planb</title>





<!-- 공통 CSS -->

<jsp:include page="/common/headStyles.jsp" />





<!--

    실제 profile.css 위치 확인



    현재 기준:

    src/main/webapp/view/assets/css/profile.css

\-->

<link rel="stylesheet" href="<%=ctx%>/view/assets/css/auth/profile.css">



</head>





<body class="site-shell">





	<!-- =========================

     공통 Header

========================= -->



	<jsp:include page="/common/header.jsp" />







	<div class="page profile-page">





		<!-- ==========================================

         프로필 상단

    =========================================== -->



		<section class="profile-hero">



			<div class="profile-hero-inner">





				<!-- =========================

                 프로필 이미지

            ========================== -->



				<div class="profile-avatar-wrap">



					<div class="avatar avatar-xl">





						<%
						if (!profileImg.isEmpty()) {
						%>



						<img src="<%=ctx%><%=profilePath%>/<%=profileImg%>"
							alt="<%=nickname%> 프로필 이미지"
							onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">



						<!-- 이미지 로딩 실패 시 기본 프로필 -->

						<span class="profile-default-avatar" style="display: none;">



							<svg width="48" height="48" viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="1.5">



                                <circle cx="12" cy="8" r="4" />



                                <path
									d="M4 21c0-4.3 3.6-7 8-7s8 2.7 8 7" />



                            </svg>



						</span>





						<%
						} else {
						%>





						<!-- 프로필 이미지 없는 경우 -->



						<span class="profile-default-avatar"> <svg width="48"
								height="48" viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="1.5">



                                <circle cx="12" cy="8" r="4" />



                                <path
									d="M4 21c0-4.3 3.6-7 8-7s8 2.7 8 7" />



                            </svg>



						</span>





						<%
						}
						%>





					</div>



				</div>







				<!-- =========================

                 회원 정보

            ========================== -->



				<div class="profile-copy">





					<div class="profile-topline">





						<div>





							<!-- 닉네임 -->

							<div class="profile-username-row">



								<h1>

									<%=nickname.isEmpty() ? loginId : nickname%>

								</h1>



							</div>





							<!-- 실명 -->

							<%
							if (!name.isEmpty()) {
							%>



							<p class="profile-name">

								<%=name%>

							</p>



							<%
							}
							%>





							<!-- 로그인 아이디 -->

							<%
							if (!loginId.isEmpty()) {
							%>



							<p class="profile-login-id">

								@<%=loginId%>

							</p>



							<%
							}
							%>





						</div>







						<!-- =========================

                         프로필 메뉴

                    ========================== -->



						<div class="profile-actions">





							<button type="button" class="btn-soft" id="openProfileEditModal">



								프로필 편집</button>





							<a class="icon-action" href="<%=ctx%>/profile/edit"
								aria-label="설정" title="설정"> ⚙ </a>





						</div>



					</div>







					<!-- =========================

                     통계

                ========================== -->



					<div class="profile-stats">





						<button type="button">



							<strong> <%=postCount%>

							</strong> <span> 게시물 </span>



						</button>





						<button type="button">



							<strong> <%=likeCount%>

							</strong> <span> 받은 좋아요 </span>



						</button>





						<button type="button">



							<strong> <%=bookmarkCount%>

							</strong> <span> 받은 북마크 </span>



						</button>





					</div>







					<!-- =========================

                     자기소개 / 지역

                ========================== -->



					<div class="profile-bio-block">





						<%-- <% if (!name.isEmpty()) { %>



                        <p>

                            <%=name%>

                        </p>



                    <% } %> --%>





						<%
						if (!bio.isEmpty()) {
						%>



						<p style="font-weight: 400;">

							<%=bio%>

						</p>



						<%
						} else {
						%>



						<p class="profile-empty-bio" style="font-weight: 400;">등록된

							소개글이 없습니다.</p>



						<%
						}
						%>





						<%
						if (!region.isEmpty()) {
						%>



						<span class="profile-location"> <%=region%>

						</span>



						<%
						}
						%>





					</div>





				</div>





			</div>



		</section>







		<!-- ==========================================

         프로필 탭

    =========================================== -->



		<div class="profile-tabs">





			<button type="button" class="active" data-profile-tab="posts">



				▦ <span> 게시물 </span>



			</button>





			<button type="button" data-profile-tab="saved">



				🔖 <span> 북마크한 게시글 </span>



			</button>





			<button type="button" data-profile-tab="liked">



				♡ <span> 좋아요한 게시글 </span>



			</button>





			<button type="button" data-profile-tab="activity">



				◯ <span> 활동 </span>



			</button>





		</div>







		<!-- ==========================================

         프로필 컨텐츠

    =========================================== -->



		<main class="profile-content">

			<div data-profile-panel="posts">

				<div class="feed-grid">

					<%
					if (!myItineraries.isEmpty()) {

						for (ProfileFeedDto item : myItineraries) {

							String country = item.getCountry() == null ? "" : item.getCountry();

							String city = item.getCity() == null ? "" : item.getCity();

							String locationText = "";

							if (!country.isEmpty() && !city.isEmpty()) {

						locationText = country + " · " + city;

							} else if (!country.isEmpty()) {

						locationText = country;

							} else if (!city.isEmpty()) {

						locationText = city;
							}

							String thumbnail = item.getThumbnailImg() == null ? "" : item.getThumbnailImg();
					%>


					<div class="feed-admin-shell">


						<a class="feed-item"
							href="<%=ctx%>/schedules/detail?id=<%=item.getItineraryId()%>">


							<%
							if (!thumbnail.isEmpty()) {
							%> <img src="<%=ctx %><%=thumbnail%>" alt="<%=item.getTitle()%>"> <%
							} else {
							%> <span class="feed-fallback"></span> <%
 }
 %> <span class="feed-hover"> <span class="feed-hover-copy">
									<strong> <%=item.getTitle()%>
								</strong> <%
 if (!locationText.isEmpty()) {
 %> <small> <%=locationText%>
								</small> <%
 }
 %> <%
 if ("PRIVATE".equals(item.getVisibility())) {
 %> <small> 비공개 </small> <%
 }
 %>

							</span> <span class="feed-hover-stats"> <span> ♥ <%=item.getLikeCount()%>
								</span> <span> 🔖 <%=item.getBookmarkCount()%>
								</span> <span> 💬 <%=item.getCommentCount()%>
								</span>

							</span>


						</span>


						</a>


						<!-- 본인 일정 수정 / 삭제 메뉴 -->
						<div class="feed-owner-actions">


							<button type="button" class="feed-owner-more" data-owner-more
								aria-label="게시글 메뉴">•••</button>


							<div class="feed-owner-menu" role="menu">


								<a
									href="<%=ctx%>/view/itinerary/planner.jsp?id=<%=item.getItineraryId()%>">

									수정 </a>


								<button type="button" class="danger">삭제</button>


							</div>


						</div>


					</div>


					<%
					}

					} else {
					%>


					<div class="empty-state">아직 작성한 여행 일정이 없습니다.</div>


					<%
					}
					%>


				</div>

			</div>









			<!-- ======================================
		     북마크
		======================================= -->

			<div data-profile-panel="saved" class="jsp-hidden">

				<div class="feed-grid">

					<%
					if (bookmarkedItineraries != null && !bookmarkedItineraries.isEmpty()) {

						for (ProfileFeedDto item : bookmarkedItineraries) {

							String country = item.getCountry() == null ? "" : item.getCountry();

							String city = item.getCity() == null ? "" : item.getCity();

							String locationText = "";

							if (!country.isEmpty() && !city.isEmpty()) {

						locationText = country + " · " + city;

							} else if (!country.isEmpty()) {

						locationText = country;

							} else if (!city.isEmpty()) {

						locationText = city;
							}

							String thumbnail = item.getThumbnailImg() == null ? "" : item.getThumbnailImg();
					%>


					<div class="feed-admin-shell">

						<a class="feed-item"
							href="<%=ctx%>/schedules/detail?id=<%=item.getItineraryId()%>">


							<%
							if (!thumbnail.isEmpty()) {
							%> <img src="<%=ctx %><%=thumbnail%>"
							alt="<%=item.getTitle()%>"> <%
 } else {
 %> <span class="feed-fallback"></span> <%
 }
 %> <span class="feed-hover"> <span
								class="feed-hover-copy"> <strong> <%=item.getTitle()%>
								</strong> <%
 if (!locationText.isEmpty()) {
 %> <small> <%=locationText%>
								</small> <%
 }
 %>

							</span> <span class="feed-hover-stats"> <span> ♥ <%=item.getLikeCount()%>
								</span> <span> 🔖 <%=item.getBookmarkCount()%>
								</span> <span> 💬 <%=item.getCommentCount()%>
								</span>

							</span>

						</span>

						</a>

					</div>


					<%
					}

					} else {
					%>


					<div class="empty-state">아직 북마크한 여행 일정이 없습니다.</div>


					<%
					}
					%>

				</div>

			</div>



			<!-- ======================================
		     좋아요
		======================================= -->

			<div data-profile-panel="liked" class="jsp-hidden">

				<div class="feed-grid">

					<%
					if (likedItineraries != null && !likedItineraries.isEmpty()) {

						for (ProfileFeedDto item : likedItineraries) {

							String country = item.getCountry() == null ? "" : item.getCountry();

							String city = item.getCity() == null ? "" : item.getCity();

							String locationText = "";

							if (!country.isEmpty() && !city.isEmpty()) {

						locationText = country + " · " + city;

							} else if (!country.isEmpty()) {

						locationText = country;

							} else if (!city.isEmpty()) {

						locationText = city;
							}

							String thumbnail = item.getThumbnailImg() == null ? "" : item.getThumbnailImg();
					%>


					<div class="feed-admin-shell">

						<a class="feed-item"
							href="<%=ctx%>/schedules/detail?id=<%=item.getItineraryId()%>">


							<%
							if (!thumbnail.isEmpty()) {
							%> <img src="<%=ctx %><%=thumbnail%>"
							alt="<%=item.getTitle()%>"> <%
 } else {
 %> <span class="feed-fallback"></span> <%
 }
 %> <span class="feed-hover"> <span
								class="feed-hover-copy"> <strong> <%=item.getTitle()%>
								</strong> <%
 if (!locationText.isEmpty()) {
 %> <small> <%=locationText%>
								</small> <%
 }
 %>

							</span> <span class="feed-hover-stats"> <span> ♥ <%=item.getLikeCount()%>
								</span> <span> 🔖 <%=item.getBookmarkCount()%>
								</span> <span> 💬 <%=item.getCommentCount()%>
								</span>

							</span>

						</span>

						</a>

					</div>


					<%
					}

					} else {
					%>


					<div class="empty-state">아직 좋아요한 여행 일정이 없습니다.</div>


					<%
					}
					%>

				</div>

			</div>



			<!-- ======================================

             활동

        ======================================= -->



			<div data-profile-panel="activity" class="jsp-hidden">





				<div class="activity-panel">





					<div class="segmented-control">





						<button type="button" class="active">전체</button>





						<button type="button">글</button>





						<button type="button">댓글</button>





					</div>







					<div class="activity-list">





						<button type="button" class="activity-item">





							<div>





								<div class="activity-kicker">



									<span> 글 </span> · 여행 이야기



								</div>





								<p>최근 작성한 여행 게시물이 여기에 표시됩니다.</p>





							</div>





							<time> - </time>





						</button>







						<button type="button" class="activity-item">





							<div>





								<div class="activity-kicker">



									<span> 댓글 </span> · 여행 질문



								</div>





								<p>최근 작성한 댓글이 여기에 표시됩니다.</p>





							</div>





							<time> - </time>





						</button>





					</div>





				</div>





			</div>





		</main>





	</div>



	<!-- =========================================================
     프로필 편집 모달
========================================================= -->

	<div class="profile-edit-modal-backdrop" id="profileEditModal"
		aria-hidden="true">

		<div class="profile-edit-modal" role="dialog" aria-modal="true"
			aria-labelledby="profileEditModalTitle">

			<!-- 모달 헤더 -->
			<div class="profile-edit-modal-header">
				<div>
					<h2 id="profileEditModalTitle">프로필 편집</h2>
					<p>내 피드에 표시되는 정보를 수정합니다.</p>
				</div>

				<button type="button" class="profile-edit-modal-close"
					id="closeProfileEditModal" aria-label="닫기">×</button>
			</div>

			<form id="profileEditModalForm" action="<%=ctx%>/profile/edit"
				method="post" enctype="multipart/form-data">

				<!--
					ProfileEdit Servlet은 회원정보 전체를 UPDATE하므로
					모달에서 직접 수정하지 않는 값도 같이 전송합니다.
				-->
				<input type="hidden" name="birthDate" value="<%=birthDate%>">
				<input type="hidden" name="phone" value="<%=phone%>"> <input
					type="hidden" name="postcode" value="<%=postcode%>"> <input
					type="hidden" name="address" value="<%=address%>"> <input
					type="hidden" name="addressDetail" value="<%=addressDetail%>">

				<div class="profile-edit-modal-body">

					<!-- 프로필 이미지 -->
					<div class="profile-edit-photo-row">

						<div class="profile-edit-preview">
							<img id="profileEditPreviewImage"
								<%if (!profileImg.isEmpty()) {%>
								src="<%=ctx%><%=profilePath%>/<%=profileImg%>" <%}%>
								alt="<%=nickname%> 프로필 이미지"
								style="display:<%=profileImg.isEmpty() ? "none" : "block"%>;">

							<div class="profile-edit-preview-empty"
								id="profileEditPreviewEmpty"
								style="display:<%=profileImg.isEmpty() ? "flex" : "none"%>;">
								<svg width="34" height="34" viewBox="0 0 24 24" fill="none"
									stroke="currentColor" stroke-width="1.6">
									<circle cx="12" cy="8" r="4" />
									<path d="M4 21c0-4.3 3.6-7 8-7s8 2.7 8 7" />
								</svg>
							</div>
						</div>

						<div class="profile-edit-photo-copy">
							<strong><%=nickname%></strong> <span>프로필 사진을 변경할 수 있습니다.</span> <label
								class="profile-edit-photo-btn"> 사진 변경 <input type="file"
								name="profileImage" id="profileEditImageInput"
								accept="image/jpeg,image/png,image/webp,image/gif">
							</label>
						</div>
					</div>

					<!-- 닉네임 -->
					<label class="profile-edit-field"> <span>닉네임</span> <input
						type="text" name="nickname" value="<%=nickname%>" maxlength="50"
						required>
					</label>

					<!-- 이름 -->
					<label class="profile-edit-field"> <span>이름</span> <input
						type="text" name="name" value="<%=name%>" maxlength="50" required>
					</label>

					<!-- 소개 -->
					<label class="profile-edit-field"> <span>소개</span> <textarea
							name="bio" rows="4" maxlength="300"><%=bio%></textarea> <small>프로필에
							공개되는 소개글입니다.</small>
					</label>

					<!-- 지역 -->
					<label class="profile-edit-field"> <span>지역</span> <input
						type="text" name="region" value="<%=region%>" maxlength="100">
					</label>
				</div>

				<!-- 모달 하단 -->
				<div class="profile-edit-modal-actions">
					<button type="button" class="profile-edit-cancel-btn"
						id="cancelProfileEditModal">취소</button>

					<button type="submit" class="profile-edit-save-btn">저장</button>
				</div>
			</form>
		</div>
	</div>


	<!-- =========================

     Footer

========================= -->



	<jsp:include page="/common/footer.jsp" />







	<!-- ==========================================

     프로필 페이지 JS

=========================================== -->



	<script>
		document.addEventListener("DOMContentLoaded", function() {

			/* =========================

			   프로필 탭

			========================== */

			const tabs = document.querySelectorAll("[data-profile-tab]");

			const panels = document.querySelectorAll("[data-profile-panel]");

			tabs.forEach(function(tab) {

				tab.addEventListener("click", function() {

					const target = tab.dataset.profileTab;

					/* 모든 탭 비활성화 */

					tabs.forEach(function(item) {

						item.classList.remove("active");

					});

					/* 현재 탭 활성화 */

					tab.classList.add("active");

					/* 패널 전환 */

					panels.forEach(function(panel) {

						if (panel.dataset.profilePanel === target) {

							panel.classList.remove("jsp-hidden");

						} else {

							panel.classList.add("jsp-hidden");

						}

					});

				});

			});

			/* =========================

			   게시물 메뉴

			========================== */

			const moreButtons = document.querySelectorAll("[data-owner-more]");

			moreButtons.forEach(function(button) {

				button.addEventListener("click", function(event) {

					event.preventDefault();

					event.stopPropagation();

					const parent = button.closest(".feed-owner-actions");

					const menu = parent.querySelector(".feed-owner-menu");

					/* 다른 메뉴 닫기 */

					document.querySelectorAll(".feed-owner-menu").forEach(

					function(otherMenu) {

						if (otherMenu !== menu) {

							otherMenu.classList.remove("show");

						}

					});

					menu.classList.toggle("show");

				});

			});

			/* 바깥 클릭 시 메뉴 닫기 */

			document.addEventListener("click", function() {

				document.querySelectorAll(".feed-owner-menu").forEach(

				function(menu) {

					menu.classList.remove("show");

				});

			});

		});
	</script>

	<script>
		document
				.addEventListener(
						"DOMContentLoaded",
						function() {

							var modal = document
									.getElementById("profileEditModal");
							var openBtn = document
									.getElementById("openProfileEditModal");
							var closeBtn = document
									.getElementById("closeProfileEditModal");
							var cancelBtn = document
									.getElementById("cancelProfileEditModal");
							var imageInput = document
									.getElementById("profileEditImageInput");
							var preview = document
									.getElementById("profileEditPreviewImage");
							var empty = document
									.getElementById("profileEditPreviewEmpty");
							var form = document
									.getElementById("profileEditModalForm");

							if (!modal || !openBtn) {
								return;
							}

							var originalImageSrc = preview ? preview
									.getAttribute("src") : null;
							var originalPreviewDisplay = preview ? preview.style.display
									: "none";
							var originalEmptyDisplay = empty ? empty.style.display
									: "flex";

							function openProfileModal() {
								modal.classList.add("show");
								modal.setAttribute("aria-hidden", "false");
								document.body.classList
										.add("profile-modal-open");
							}

							function resetImagePreview() {
								if (imageInput) {
									imageInput.value = "";
								}

								if (!preview) {
									return;
								}

								if (originalImageSrc
										&& originalImageSrc.trim() !== "") {
									preview.src = originalImageSrc;
									preview.style.display = originalPreviewDisplay
											|| "block";

									if (empty) {
										empty.style.display = "none";
									}
								} else {
									preview.removeAttribute("src");
									preview.style.display = "none";

									if (empty) {
										empty.style.display = originalEmptyDisplay
												|| "flex";
									}
								}
							}

							function closeProfileModal() {
								modal.classList.remove("show");
								modal.setAttribute("aria-hidden", "true");
								document.body.classList
										.remove("profile-modal-open");

								if (form) {
									form.reset();
								}

								resetImagePreview();
							}

							openBtn.addEventListener("click", openProfileModal);

							if (closeBtn) {
								closeBtn.addEventListener("click",
										closeProfileModal);
							}

							if (cancelBtn) {
								cancelBtn.addEventListener("click",
										closeProfileModal);
							}

							modal.addEventListener("click", function(event) {
								if (event.target === modal) {
									closeProfileModal();
								}
							});

							document.addEventListener("keydown",
									function(event) {
										if (event.key === "Escape"
												&& modal.classList
														.contains("show")) {
											closeProfileModal();
										}
									});

							if (imageInput) {
								imageInput
										.addEventListener(
												"change",
												function() {
													if (!this.files
															|| this.files.length === 0) {
														resetImagePreview();
														return;
													}

													var file = this.files[0];

													if (!file.type
															|| file.type
																	.indexOf("image/") !== 0) {
														alert("이미지 파일만 선택할 수 있습니다.");
														this.value = "";
														resetImagePreview();
														return;
													}

													if (file.size > 5 * 1024 * 1024) {
														alert("프로필 이미지는 5MB 이하만 업로드할 수 있습니다.");
														this.value = "";
														resetImagePreview();
														return;
													}

													var reader = new FileReader();

													reader.onload = function(
															event) {
														preview.src = event.target.result;
														preview.style.display = "block";

														if (empty) {
															empty.style.display = "none";
														}
													};

													reader.onerror = function() {
														alert("이미지를 불러오지 못했습니다.");
														imageInput.value = "";
														resetImagePreview();
													};

													reader.readAsDataURL(file);
												});
							}

							if (form) {
								form
										.addEventListener(
												"submit",
												function() {
													var submitButton = form
															.querySelector(".profile-edit-save-btn");

													if (submitButton) {
														submitButton.disabled = true;
														submitButton.textContent = "저장 중...";
													}
												});
							}
						});
	</script>



</body>



</html>