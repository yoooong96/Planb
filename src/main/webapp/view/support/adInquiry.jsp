<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="dto.member.UserDto"%>

<%!
/* =========================================================
   HTML 출력용 이스케이프

   오류 후 사용자가 입력한 값을 다시 value="" 등에 넣을 때
   따옴표나 특수문자로 HTML이 깨지는 것을 방지
========================================================= */
private String escapeHtml(String value) {

    if (value == null) {
        return "";
    }

    return value
            .replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\"", "&quot;")
            .replace("'", "&#39;");
}
%>

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



/* =========================================================
   로그인 회원

   광고 문의는 비회원도 가능
========================================================= */

UserDto user =
        (UserDto)
        session.getAttribute(
                "user"
        );


String defaultManagerName = "";
String defaultEmail = "";


if (user != null) {

    defaultManagerName =
            user.getName() == null
            ? ""
            : user.getName();


    defaultEmail =
            user.getEmail() == null
            ? ""
            : user.getEmail();
}



/* =========================================================
   광고 안내 페이지에서 넘어온 광고 위치

   adInquiry.jsp?adPosition=MAIN_BANNER
   adInquiry.jsp?adPosition=TRIP_CARD
========================================================= */

String selectedAdPosition =
        request.getParameter(
                "adPosition"
        );


/*
 * 서버 오류 후 forward 되었을 때는
 * request attribute에 보관된 값 우선 사용
 */
Object preservedAdPosition =
        request.getAttribute(
                "adPosition"
        );


if (preservedAdPosition != null) {

    selectedAdPosition =
            String.valueOf(
                    preservedAdPosition
            );
}


if (
    !"MAIN_BANNER".equals(
            selectedAdPosition
    )
    &&
    !"TRIP_CARD".equals(
            selectedAdPosition
    )
) {

    selectedAdPosition = "";
}



/* =========================================================
   처리 결과
========================================================= */

boolean success =
        "1".equals(
                request.getParameter(
                        "success"
                )
        );


String errorMessage =
        (String)
        request.getAttribute(
                "errorMessage"
        );



/* =========================================================
   오류 발생 후 입력값 유지
========================================================= */

String formBusinessName =
        request.getAttribute(
                "businessName"
        ) == null
        ? ""
        : String.valueOf(
                request.getAttribute(
                        "businessName"
                )
        );


String formManagerName =
        request.getAttribute(
                "managerName"
        ) == null
        ? defaultManagerName
        : String.valueOf(
                request.getAttribute(
                        "managerName"
                )
        );


String formPhone =
        request.getAttribute(
                "phone"
        ) == null
        ? ""
        : String.valueOf(
                request.getAttribute(
                        "phone"
                )
        );


String formEmail =
        request.getAttribute(
                "email"
        ) == null
        ? defaultEmail
        : String.valueOf(
                request.getAttribute(
                        "email"
                )
        );


String formLinkUrl =
        request.getAttribute(
                "linkUrl"
        ) == null
        ? ""
        : String.valueOf(
                request.getAttribute(
                        "linkUrl"
                )
        );


String formContent =
        request.getAttribute(
                "content"
        ) == null
        ? ""
        : String.valueOf(
                request.getAttribute(
                        "content"
                )
        );


String formStartDate =
        request.getAttribute(
                "startDate"
        ) == null
        ? ""
        : String.valueOf(
                request.getAttribute(
                        "startDate"
                )
        );


String formEndDate =
        request.getAttribute(
                "endDate"
        ) == null
        ? ""
        : String.valueOf(
                request.getAttribute(
                        "endDate"
                )
        );

%>


<!DOCTYPE html>

<html lang="ko">


<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">


<title>광고 문의하기 · Planb</title>


<jsp:include page="/common/headStyles.jsp" />


<link rel="stylesheet"
	href="<%=ctx%>/view/assets/css/support/support.css">


<link rel="stylesheet"
	href="<%=ctx%>/view/assets/css/setting/settings.css">



<style>

/* =========================================================
   광고 문의 전체
========================================================= */
.ad-inquiry-page {
	width: 100%;
}

/* =========================================================
   안내 박스
========================================================= */
.ad-inquiry-intro {
	margin-bottom: 18px;
	padding: 20px;
	border: 1px solid #e4e5f2;
	border-radius: 16px;
	background: linear-gradient(135deg, #fbfbff, #f3f3ff);
}

.ad-inquiry-intro-head {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 15px;
}

.ad-inquiry-intro-title {
	display: flex;
	align-items: center;
	gap: 8px;
	color: #343642;
	font-size: 15px;
	font-weight: 800;
}

.ad-inquiry-intro-link {
	color: #6369D1;
	font-size: 10.5px;
	font-weight: 700;
	text-decoration: none;
}

.ad-inquiry-intro-link:hover {
	text-decoration: underline;
}

.ad-inquiry-intro p {
	margin: 8px 0 0;
	color: #777984;
	font-size: 11px;
	line-height: 1.7;
}

/* =========================================================
   성공 / 오류
========================================================= */
.ad-message {
	margin-bottom: 18px;
	padding: 14px 16px;
	border-radius: 11px;
	font-size: 11.5px;
	line-height: 1.65;
}

.ad-message-success {
	background: #f0f8f3;
	color: #31794c;
}

.ad-message-error {
	background: #fff2f3;
	color: #d6404d;
}

/* =========================================================
   폼
========================================================= */
.ad-form-panel {
	overflow: visible;
}

.ad-form-section {
	display: flex;
	flex-direction: column;
	gap: 22px;
}

.ad-form-field {
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.ad-form-label {
	color: #454650;
	font-size: 11.5px;
	font-weight: 700;
}

.ad-form-label .optional {
	margin-left: 4px;
	color: #a1a2ab;
	font-size: 9px;
	font-weight: 500;
}

.ad-form-field input[type="text"], .ad-form-field input[type="email"],
	.ad-form-field input[type="tel"], .ad-form-field input[type="url"],
	.ad-form-field input[type="date"], .ad-form-field textarea {
	width: 100%;
	box-sizing: border-box;
	border: 1px solid #dddde8;
	border-radius: 10px;
	background: #fff;
	color: #35363f;
	font-family: inherit;
	font-size: 11.5px;
	outline: none;
	transition: border-color .15s ease, box-shadow .15s ease;
}

.ad-form-field input[type="text"], .ad-form-field input[type="email"],
	.ad-form-field input[type="tel"], .ad-form-field input[type="url"],
	.ad-form-field input[type="date"] {
	height: 43px;
	padding: 0 13px;
}

.ad-form-field textarea {
	min-height: 150px;
	padding: 13px;
	line-height: 1.7;
	resize: vertical;
}

.ad-form-field input:focus, .ad-form-field textarea:focus {
	border-color: #6369D1;
	box-shadow: 0 0 0 3px rgba(99, 105, 209, .08);
}

.ad-field-help {
	margin: 0;
	color: #9899a3;
	font-size: 9.5px;
	line-height: 1.6;
}

/* =========================================================
   광고 위치
========================================================= */
.ad-position-grid {
	display: grid;
	grid-template-columns: repeat(2, minmax(0, 1fr));
	gap: 11px;
}

.ad-position-card {
	position: relative;
	display: block;
	padding: 16px;
	border: 1px solid #dedfea;
	border-radius: 13px;
	background: #fff;
	cursor: pointer;
	transition: border-color .15s ease, background .15s ease, box-shadow
		.15s ease;
}

.ad-position-card:hover {
	border-color: #bfc1ed;
}

.ad-position-card.selected {
	border-color: #6369D1;
	background: #f7f7ff;
	box-shadow: inset 0 0 0 1px #6369D1;
}

.ad-position-card input {
	position: absolute;
	opacity: 0;
	pointer-events: none;
}

.ad-position-card-title {
	display: block;
	color: #353640;
	font-size: 12px;
	font-weight: 800;
}

.ad-position-card-desc {
	display: block;
	margin-top: 5px;
	color: #8b8c96;
	font-size: 9.5px;
	line-height: 1.55;
}

.ad-position-code {
	display: inline-flex;
	margin-top: 10px;
	padding: 4px 7px;
	border-radius: 6px;
	background: #eeeeff;
	color: #6369D1;
	font-size: 8px;
	font-weight: 800;
}

/* =========================================================
   날짜
========================================================= */
.ad-date-grid {
	display: grid;
	grid-template-columns: repeat(2, minmax(0, 1fr));
	gap: 10px;
}

.ad-date-item {
	display: flex;
	flex-direction: column;
	gap: 6px;
}

.ad-date-item small {
	color: #8b8c96;
	font-size: 9px;
}

/* =========================================================
   예상 가격
========================================================= */
.ad-price-box {
	margin-top: 4px;
	padding: 15px 16px;
	border: 1px solid #e5e5ef;
	border-radius: 12px;
	background: #fafaff;
}

.ad-price-row {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 20px;
	padding: 5px 0;
	color: #80818b;
	font-size: 10.5px;
}

.ad-price-row strong {
	color: #44454f;
}

.ad-price-total {
	margin-top: 7px;
	padding-top: 12px;
	border-top: 1px solid #e3e3ed;
}

.ad-price-total strong {
	color: #6369D1;
	font-size: 14px;
}

/* =========================================================
   이미지
========================================================= */
.ad-image-area {
	display: grid;
	grid-template-columns: 170px minmax(0, 1fr);
	gap: 16px;
	align-items: center;
}

.ad-image-preview {
	width: 100%;
	height: 105px;
	display: flex;
	align-items: center;
	justify-content: center;
	overflow: hidden;
	box-sizing: border-box;
	border: 1px dashed #cfd0de;
	border-radius: 11px;
	background: #fafafd;
	color: #aaaab3;
	font-size: 9.5px;
}

.ad-image-preview img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.ad-image-input-wrap
input[type="file"] {
	width: 100%;
	box-sizing: border-box;
	padding: 9px;
	border: 1px solid #dedee8;
	border-radius: 9px;
	background: #fff;
	font-size: 10px;
}

/* =========================================================
   제출 버튼
========================================================= */
.ad-submit-area {
	width: 100%;
	display: flex;
	align-items: center;
	justify-content: flex-end;
	gap: 10px;
	margin-top: 20px;
	padding: 20px 0 10px;
}

.ad-cancel-button, .ad-submit-button {
	min-width: 125px;
	height: 44px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	box-sizing: border-box;
	border-radius: 10px;
	font-family: inherit;
	font-size: 11.5px;
	font-weight: 750;
	text-decoration: none;
	cursor: pointer;
}

.ad-cancel-button {
	border: 1px solid #dedfe8;
	background: #fff;
	color: #666873;
}

.ad-cancel-button:hover {
	background: #f8f8fb;
}

.ad-submit-button {
	border: 1px solid #6369D1;
	background: #6369D1;
	color: #fff;
	box-shadow: 0 7px 18px rgba(99, 105, 209, .19);
}

.ad-submit-button:hover {
	background: #555bc4;
	transform: translateY(-1px);
}

.ad-submit-button:disabled {
	opacity: .55;
	cursor: wait;
}

/* =========================================================
   모바일
========================================================= */
@media ( max-width : 680px ) {
	.ad-position-grid, .ad-date-grid {
		grid-template-columns: 1fr;
	}
	.ad-image-area {
		grid-template-columns: 1fr;
	}
	.ad-image-preview {
		max-width: 240px;
	}
	.ad-submit-area {
		flex-direction: column-reverse;
	}
	.ad-cancel-button, .ad-submit-button {
		width: 100%;
	}
}
</style>


</head>



<body class="site-shell">


	<jsp:include page="/common/header.jsp" />



	<div class="settings-page">


		<div class="settings-shell">


			<jsp:include page="/common/settingsSidebar.jsp" />



			<main class="settings-main">


				<div class="settings-content
                       ad-inquiry-page">


					<!-- =================================================
                     TITLE
                ================================================== -->

					<header class="settings-title">


						<span class="settings-eyebrow"> ADVERTISEMENT </span>


						<h1>광고 문의하기</h1>


						<p>Planb 내 광고 및 제휴 상품에 대해 문의할 수 있습니다.</p>


					</header>



					<a class="support-back" href="<%=ctx%>/view/support/adGuide.jsp">

						‹ 광고 안내 </a>



					<!-- =================================================
                     성공 메시지
                ================================================== -->

					<% if (success) { %>


					<div
						class="ad-message
                               ad-message-success">


						광고 문의가 정상적으로 접수되었습니다. <br> 담당자가 광고 내용을 검토한 후 입력하신 이메일로
						안내드립니다.


					</div>


					<% } %>



					<!-- =================================================
                     오류 메시지
                ================================================== -->

					<%
                if (
                    errorMessage != null
                    && !errorMessage.trim().isEmpty()
                ) {
                %>


					<div
						class="ad-message
                               ad-message-error">


						<%=escapeHtml(errorMessage)%>


						<br> <small> 광고 이미지를 제외한 입력 내용은 유지됩니다. </small>


					</div>


					<%
                }
                %>



					<!-- =================================================
                     안내
                ================================================== -->

					<section class="ad-inquiry-intro">


						<div class="ad-inquiry-intro-head">


							<div class="ad-inquiry-intro-title">


								<span> 📣 </span> <span> Planb 광고 문의 </span>


							</div>



							<a href="<%=ctx%>/view/support/adGuide.jsp"
								class="ad-inquiry-intro-link"> 광고 영역·가격 다시 보기 → </a>


						</div>



						<p>

							여행 서비스, 숙박, 교통, 음식점 및 브랜드 제휴 광고를 문의할 수 있습니다. <br> 문의 접수 후
							관리자가 광고 내용, 이미지 및 희망 노출 일정을 검토합니다.

						</p>


					</section>



					<!-- =================================================
                     FORM
                ================================================== -->

					<form id="adInquiryForm" action="<%=ctx%>/support/adInquiry"
						method="post" enctype="multipart/form-data">


						<section
							class="settings-panel
                               settings-form-panel
                               ad-form-panel">


							<div class="ad-form-section">



								<!-- =====================================
                                 회사 / 브랜드명
                            ====================================== -->

								<div class="ad-form-field">


									<label class="ad-form-label" for="businessName">

										회사/브랜드명 </label> <input type="text" id="businessName"
										name="businessName" maxlength="100"
										value="<%=escapeHtml(formBusinessName)%>"
										placeholder="회사 또는 브랜드명을 입력해주세요." required>


								</div>



								<!-- =====================================
                                 담당자
                            ====================================== -->

								<div class="ad-form-field">


									<label class="ad-form-label" for="managerName"> 담당자명 </label> <input
										type="text" id="managerName" name="managerName"
										maxlength="100" value="<%=escapeHtml(formManagerName)%>"
										placeholder="담당자 이름을 입력해주세요." required>


								</div>



								<!-- =====================================
                                 이메일
                            ====================================== -->

								<div class="ad-form-field">


									<label class="ad-form-label" for="email"> 연락 이메일 </label> <input
										type="email" id="email" name="email" maxlength="150"
										value="<%=escapeHtml(formEmail)%>"
										placeholder="example@company.com" required>


									<p class="ad-field-help">광고 검토 및 승인 결과를 받을 이메일입니다.</p>


								</div>



								<!-- =====================================
                                 전화번호
                            ====================================== -->

								<div class="ad-form-field">


									<label class="ad-form-label" for="phone"> 전화번호 </label> <input
										type="tel" id="phone" name="phone" maxlength="13"
										inputmode="numeric" autocomplete="tel"
										value="<%=escapeHtml(formPhone)%>" placeholder="010-1234-5678"
										required>


									<p class="ad-field-help">숫자만 입력해도 하이픈이 자동으로 입력됩니다.</p>


								</div>



								<!-- =====================================
                                 광고 위치
                            ====================================== -->

								<div class="ad-form-field">


									<span class="ad-form-label"> 광고 희망 영역 </span>



									<div class="ad-position-grid">


										<!-- MAIN BANNER -->

										<label class="ad-position-card"> <input type="radio"
											name="adPosition" value="MAIN_BANNER"
											<%=
                                                "MAIN_BANNER"
                                                .equals(
                                                    selectedAdPosition
                                                )
                                                ? "checked"
                                                : ""
                                            %>
											required> <span class="ad-position-card-title">

												메인 배너 </span> <span class="ad-position-card-desc"> 홈 화면 상단에
												노출되는 대표 배너형 광고입니다. </span> <span class="ad-position-code">

												MAIN_BANNER </span>


										</label>



										<!-- TRIP CARD -->

										<label class="ad-position-card"> <input type="radio"
											name="adPosition" value="TRIP_CARD"
											<%=
                                                "TRIP_CARD"
                                                .equals(
                                                    selectedAdPosition
                                                )
                                                ? "checked"
                                                : ""
                                            %>
											required> <span class="ad-position-card-title">

												여행 카드 광고 </span> <span class="ad-position-card-desc"> 여행 일정
												목록 사이에 노출되는 카드형 광고입니다. </span> <span class="ad-position-code">

												TRIP_CARD </span>


										</label>


									</div>


								</div>



								<!-- =====================================
                                 광고 희망 기간
                            ====================================== -->

								<div class="ad-form-field">


									<span class="ad-form-label"> 광고 희망 기간 </span>



									<div class="ad-date-grid">


										<div class="ad-date-item">


											<small> 시작일 </small> <input type="date" id="adStartDate"
												name="startDate" value="<%=escapeHtml(formStartDate)%>"
												required>


										</div>



										<div class="ad-date-item">


											<small> 종료일 </small> <input type="date" id="adEndDate"
												name="endDate" value="<%=escapeHtml(formEndDate)%>" required>


										</div>


									</div>



									<!-- 예상 가격 -->

									<div class="ad-price-box">


										<div class="ad-price-row">


											<span> 선택 광고 </span> <strong id="pricePosition"> - </strong>


										</div>



										<div class="ad-price-row">


											<span> 광고 기간 </span> <strong id="priceDuration"> - </strong>


										</div>



										<div
											class="ad-price-row
                                               ad-price-total">


											<span> 예상 광고비 </span> <strong id="priceTotal"> 광고
												위치와 기간을 선택해주세요. </strong>


										</div>


									</div>



									<p class="ad-field-help">표시 금액은 예상 금액이며 최종 비용은 관리자 검토 후
										확정됩니다.</p>


								</div>



								<!-- =====================================
                                 광고 연결 URL
                            ====================================== -->

								<div class="ad-form-field">


									<label class="ad-form-label" for="linkUrl"> 광고 연결 URL <span
										class="optional"> 선택 </span>

									</label> <input type="url" id="linkUrl" name="linkUrl" maxlength="500"
										value="<%=escapeHtml(formLinkUrl)%>"
										placeholder="https://example.com">


									<p class="ad-field-help">사용자가 광고를 클릭했을 때 이동할 웹사이트 주소입니다.</p>


								</div>



								<!-- =====================================
                                 이미지
                            ====================================== -->

								<div class="ad-form-field">


									<span class="ad-form-label"> 광고 이미지 </span>



									<div class="ad-image-area">


										<div class="ad-image-preview" id="adImagePreview">이미지
											미리보기</div>



										<div class="ad-image-input-wrap">


											<input type="file" id="adImage" name="image"
												accept="image/jpeg,image/png,image/webp" required>


											<p class="ad-field-help">JPG, PNG, WEBP / 최대 5MB</p>


											<%
                                        if (
                                            errorMessage != null
                                        ) {
                                        %>

											<p class="ad-field-help"
												style="color: #d6404d; margin-top: 5px;">오류 후에는 보안상 광고
												이미지를 다시 선택해야 합니다.</p>

											<%
                                        }
                                        %>


										</div>


									</div>


								</div>



								<!-- =====================================
                                 문의 내용
                            ====================================== -->

								<div class="ad-form-field">


									<label class="ad-form-label" for="content"> 광고 및 문의 내용

									</label>


									<textarea id="content" name="content" maxlength="3000" rows="7"
										placeholder="광고하려는 상품 또는 서비스와 요청사항을 작성해주세요." required><%=escapeHtml(formContent)%></textarea>


									<p class="ad-field-help">광고 목적, 상품 설명, 희망 노출 방식 등 필요한 내용을
										작성해주세요.</p>


								</div>


							</div>


						</section>



						<!-- =================================================
                         제출 버튼
                    ================================================== -->

						<div class="ad-submit-area">


							<a class="ad-cancel-button"
								href="<%=ctx%>/view/support/adGuide.jsp"> 취소 </a>



							<button type="submit" id="adSubmitButton"
								class="ad-submit-button">광고 문의 접수</button>


						</div>


					</form>


				</div>


			</main>


		</div>


	</div>



	<jsp:include page="/common/footer.jsp" />



	<script>

document.addEventListener(
    "DOMContentLoaded",
    function () {


        /* =====================================================
           ELEMENT
        ====================================================== */

        const form =
            document.getElementById(
                "adInquiryForm"
            );


        const submitButton =
            document.getElementById(
                "adSubmitButton"
            );


        const phoneInput =
            document.getElementById(
                "phone"
            );


        const startDate =
            document.getElementById(
                "adStartDate"
            );


        const endDate =
            document.getElementById(
                "adEndDate"
            );


        const imageInput =
            document.getElementById(
                "adImage"
            );


        const imagePreview =
            document.getElementById(
                "adImagePreview"
            );


        const positionInputs =
            document.querySelectorAll(
                'input[name="adPosition"]'
            );


        const positionCards =
            document.querySelectorAll(
                ".ad-position-card"
            );


        const pricePosition =
            document.getElementById(
                "pricePosition"
            );


        const priceDuration =
            document.getElementById(
                "priceDuration"
            );


        const priceTotal =
            document.getElementById(
                "priceTotal"
            );



        /* =====================================================
           전화번호 자동 하이픈
        ====================================================== */

        function formatPhoneNumber(
            value
        ) {


            let number =
                value.replace(
                    /[^0-9]/g,
                    ""
                );


            number =
                number.substring(
                    0,
                    11
                );


            /*
             * 서울 02
             */
            if (
                number.startsWith(
                    "02"
                )
            ) {


                if (
                    number.length <= 2
                ) {

                    return number;
                }


                if (
                    number.length <= 5
                ) {

                    return number.replace(
                        /(\d{2})(\d+)/,
                        "$1-$2"
                    );
                }


                if (
                    number.length <= 9
                ) {

                    return number.replace(
                        /(\d{2})(\d{3})(\d+)/,
                        "$1-$2-$3"
                    );
                }


                return number.replace(
                    /(\d{2})(\d{4})(\d{4})/,
                    "$1-$2-$3"
                );

            }



            /*
             * 010, 051, 053 등
             */
            if (
                number.length <= 3
            ) {

                return number;
            }


            if (
                number.length <= 7
            ) {

                return number.replace(
                    /(\d{3})(\d+)/,
                    "$1-$2"
                );
            }


            /*
             * 10자리
             * 053-123-4567
             */
            if (
                number.length <= 10
            ) {

                return number.replace(
                    /(\d{3})(\d{3})(\d{4})/,
                    "$1-$2-$3"
                );
            }


            /*
             * 11자리
             * 010-1234-5678
             */
            return number.replace(
                /(\d{3})(\d{4})(\d{4})/,
                "$1-$2-$3"
            );

        }



        phoneInput.addEventListener(
            "input",
            function () {


                this.value =
                    formatPhoneNumber(
                        this.value
                    );

            }
        );


        /*
         * 오류 후 되돌아온 번호도
         * 다시 형식 적용
         */
        phoneInput.value =
            formatPhoneNumber(
                phoneInput.value
            );



        /* =====================================================
           오늘 날짜
        ====================================================== */

        const today =
            new Date();


        const yyyy =
            today.getFullYear();


        const mm =
            String(
                today.getMonth() + 1
            ).padStart(
                2,
                "0"
            );


        const dd =
            String(
                today.getDate()
            ).padStart(
                2,
                "0"
            );


        const todayValue =
            yyyy
            + "-"
            + mm
            + "-"
            + dd;


        startDate.min =
            todayValue;


        /*
         * 시작일이 이미 있는 경우에는
         * 그 날짜를 종료일 최소값으로 사용
         */
        if (
            startDate.value
        ) {

            endDate.min =
                startDate.value;

        } else {

            endDate.min =
                todayValue;
        }



        /* =====================================================
           광고 위치 선택 표시
        ====================================================== */

        function updatePositionCards() {


            positionCards.forEach(
                function (card) {


                    const radio =
                        card.querySelector(
                            'input[type="radio"]'
                        );


                    if (
                        radio
                        && radio.checked
                    ) {

                        card.classList.add(
                            "selected"
                        );


                    } else {

                        card.classList.remove(
                            "selected"
                        );

                    }

                }
            );

        }



        function getSelectedPosition() {


            const selected =
                document.querySelector(
                    'input[name="adPosition"]:checked'
                );


            return selected
                ? selected.value
                : null;

        }



        positionInputs.forEach(
            function (input) {


                input.addEventListener(
                    "change",
                    function () {


                        updatePositionCards();

                        updatePrice();

                    }
                );

            }
        );



        /* =====================================================
           날짜
        ====================================================== */

        startDate.addEventListener(
            "change",
            function () {


                if (
                    startDate.value
                ) {

                    endDate.min =
                        startDate.value;

                }


                if (
                    endDate.value
                    &&
                    endDate.value
                    <
                    startDate.value
                ) {

                    endDate.value =
                        "";

                }


                updatePrice();

            }
        );


        endDate.addEventListener(
            "change",
            updatePrice
        );



        /* =====================================================
           가격
        ====================================================== */

        const PRICE_TABLE = {

            MAIN_BANNER: {

                7: 50000,

                14: 90000,

                30: 160000

            },


            TRIP_CARD: {

                7: 30000,

                14: 50000,

                30: 90000

            }

        };


        const POSITION_NAMES = {

            MAIN_BANNER:
                "메인 배너",

            TRIP_CARD:
                "여행 카드 광고"

        };



        function calculateDays() {


            if (
                !startDate.value
                ||
                !endDate.value
            ) {

                return null;
            }


            const start =
                new Date(
                    startDate.value
                    + "T00:00:00"
                );


            const end =
                new Date(
                    endDate.value
                    + "T00:00:00"
                );


            if (
                end < start
            ) {

                return -1;
            }


            const diff =
                end.getTime()
                -
                start.getTime();


            return Math.floor(
                diff / 86400000
            ) + 1;

        }



        function updatePrice() {


            const position =
                getSelectedPosition();


            const days =
                calculateDays();



            pricePosition.textContent =
                position
                ? POSITION_NAMES[position]
                : "-";



            if (
                days === null
            ) {

                priceDuration.textContent =
                    "-";

            } else if (
                days <= 0
            ) {

                priceDuration.textContent =
                    "날짜를 확인해주세요.";

            } else {

                priceDuration.textContent =
                    days.toLocaleString()
                    + "일";

            }



            if (
                !position
                ||
                days === null
            ) {

                priceTotal.textContent =
                    "광고 위치와 기간을 선택해주세요.";

                return;
            }


            if (
                days <= 0
            ) {

                priceTotal.textContent =
                    "종료일을 확인해주세요.";

                return;
            }


            const price =
                PRICE_TABLE[position]
                &&
                PRICE_TABLE[position][days];


            if (
                price
            ) {

                priceTotal.textContent =
                    price.toLocaleString()
                    + "원";

            } else {

                priceTotal.textContent =
                    "기간별 별도 안내";

            }

        }



        /* =====================================================
           이미지 미리보기
        ====================================================== */

        imageInput.addEventListener(
            "change",
            function () {


                const file =
                    imageInput.files[0];


                if (
                    !file
                ) {

                    imagePreview.innerHTML =
                        "이미지 미리보기";

                    return;
                }



                if (
                    file.size
                    >
                    5 * 1024 * 1024
                ) {

                    alert(
                        "광고 이미지는 최대 5MB까지 등록할 수 있습니다."
                    );


                    imageInput.value =
                        "";


                    imagePreview.innerHTML =
                        "이미지 미리보기";


                    return;
                }



                const allowedTypes = [

                    "image/jpeg",

                    "image/png",

                    "image/webp"

                ];


                if (
                    !allowedTypes.includes(
                        file.type
                    )
                ) {

                    alert(
                        "JPG, PNG, WEBP 이미지만 등록할 수 있습니다."
                    );


                    imageInput.value =
                        "";


                    imagePreview.innerHTML =
                        "이미지 미리보기";


                    return;
                }



                const reader =
                    new FileReader();


                reader.onload =
                    function (event) {


                        const image =
                            document.createElement(
                                "img"
                            );


                        image.src =
                            event.target.result;


                        image.alt =
                            "광고 이미지 미리보기";


                        imagePreview.innerHTML =
                            "";


                        imagePreview.appendChild(
                            image
                        );

                    };


                reader.readAsDataURL(
                    file
                );

            }
        );



        /* =====================================================
           제출
        ====================================================== */

        form.addEventListener(
            "submit",
            function (event) {


                const selectedPosition =
                    getSelectedPosition();


                if (
                    !selectedPosition
                ) {

                    event.preventDefault();


                    alert(
                        "광고 희망 영역을 선택해주세요."
                    );


                    return;
                }



                if (
                    !startDate.value
                ) {

                    event.preventDefault();


                    alert(
                        "광고 시작일을 선택해주세요."
                    );


                    startDate.focus();


                    return;
                }



                if (
                    !endDate.value
                ) {

                    event.preventDefault();


                    alert(
                        "광고 종료일을 선택해주세요."
                    );


                    endDate.focus();


                    return;
                }



                if (
                    endDate.value
                    <
                    startDate.value
                ) {

                    event.preventDefault();


                    alert(
                        "광고 종료일은 시작일 이후로 선택해주세요."
                    );


                    endDate.focus();


                    return;
                }



                if (
                    !imageInput.files
                    ||
                    !imageInput.files[0]
                ) {

                    event.preventDefault();


                    alert(
                        "광고 이미지를 등록해주세요."
                    );


                    return;
                }



                /*
                 * 정상 제출이 시작됐을 때만
                 * 중복 클릭 방지
                 */
                submitButton.disabled =
                    true;


                submitButton.textContent =
                    "접수 중...";

            }
        );



        /* =====================================================
           처음 화면 표시
        ====================================================== */

        updatePositionCards();

        updatePrice();

    }
);

</script>


</body>

</html>