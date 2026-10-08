<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.List"
	import="java.text.SimpleDateFormat" import="dto.report.ReportDto"%>

<%!
    /*
     * 사용자 입력값을 화면에 출력할 때
     * HTML 태그 실행 방지
     */
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
        "admin"
);


String ctx =
        request.getContextPath();


/* =========================================
   신고 목록
========================================== */

List<ReportDto> reports =
        (List<ReportDto>)
        request.getAttribute("reports");


if (reports == null) {

    reports =
        new java.util.ArrayList<ReportDto>();
}


/* =========================================
   현재 선택 탭
========================================== */

String currentTab =
        (String)
        request.getAttribute("currentTab");


if (currentTab == null) {

    currentTab = "PENDING";
}


/* =========================================
   개수
========================================== */

Integer pendingCount =
        (Integer)
        request.getAttribute(
                "pendingCount"
        );


Integer deletedCount =
        (Integer)
        request.getAttribute(
                "deletedCount"
        );


Integer rejectedCount =
        (Integer)
        request.getAttribute(
                "rejectedCount"
        );


Integer totalCount =
        (Integer)
        request.getAttribute(
                "totalCount"
        );


if (pendingCount == null) {
    pendingCount = 0;
}


if (deletedCount == null) {
    deletedCount = 0;
}


if (rejectedCount == null) {
    rejectedCount = 0;
}


if (totalCount == null) {
    totalCount = 0;
}


SimpleDateFormat dateFormat =
        new SimpleDateFormat(
                "yyyy.MM.dd HH:mm"
        );

%>


<!DOCTYPE html>

<html lang="ko">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">


<jsp:include page="/common/headStyles.jsp" />


<title>신고 관리 | Tripily</title>

</head>


<body class="site-shell">


	<jsp:include page="/common/header.jsp" />



	<main class="max-w-5xl mx-auto px-6 py-10">


		<!-- ======================================
         페이지 상단
    ======================================= -->

		<div class="flex items-end justify-between gap-4 mb-7">


			<div>


				<div
					class="inline-flex items-center gap-2 px-2.5 py-1 rounded-full bg-[#F0F0FF] text-[#6369D1] text-[11px] font-black">

					ADMIN · REPORTS</div>


				<h1 class="text-3xl font-black mt-3">신고 관리</h1>


				<p class="text-sm text-gray-500 mt-2">접수된 신고를 확인하고 게시글 보기, 문제
					없음, 삭제 조치를 바로 처리합니다.</p>


			</div>



			<div class="hidden sm:block text-right">


				<strong class="text-2xl text-[#6369D1]"> <%=pendingCount%>

				</strong>


				<div class="text-xs text-gray-400">처리 대기</div>


			</div>


		</div>



		<!-- ======================================
         처리 결과 메시지
    ======================================= -->

		<%
    String result =
            request.getParameter("result");


    if ("success".equals(result)) {
    %>


		<div
			class="mb-5 px-4 py-3 rounded-xl bg-green-50 text-green-700 text-sm font-bold">

			신고 처리가 완료되었습니다.</div>


		<%
    } else if ("fail".equals(result)) {
    %>


		<div
			class="mb-5 px-4 py-3 rounded-xl bg-red-50 text-red-600 text-sm font-bold">

			신고 처리 중 오류가 발생했습니다.</div>


		<%
    }
    %>



		<!-- ======================================
         상태 탭
    ======================================= -->

		<div class="flex gap-2 flex-wrap mb-5">


			<!-- 처리 대기 -->

			<a href="<%=ctx%>/admin/reports?tab=PENDING"
				class="px-4 py-2 rounded-full border text-sm font-bold
            <%=
                "PENDING".equals(currentTab)
                ? "bg-[#6369D1] border-[#6369D1] text-white"
                : "bg-white border-gray-200 text-gray-500"
            %>">

				처리 대기 <span> <%=pendingCount%>
			</span>

			</a>



			<!-- 삭제 처리 -->

			<a href="<%=ctx%>/admin/reports?tab=DELETED"
				class="px-4 py-2 rounded-full border text-sm font-bold
            <%=
                "DELETED".equals(currentTab)
                ? "bg-[#6369D1] border-[#6369D1] text-white"
                : "bg-white border-gray-200 text-gray-500"
            %>">

				삭제 처리 <span> <%=deletedCount%>
			</span>

			</a>



			<!-- 문제 없음 -->

			<a href="<%=ctx%>/admin/reports?tab=REJECTED"
				class="px-4 py-2 rounded-full border text-sm font-bold
            <%=
                "REJECTED".equals(currentTab)
                ? "bg-[#6369D1] border-[#6369D1] text-white"
                : "bg-white border-gray-200 text-gray-500"
            %>">

				문제 없음 <span> <%=rejectedCount%>
			</span>

			</a>



			<!-- 전체 -->

			<a href="<%=ctx%>/admin/reports?tab=ALL"
				class="px-4 py-2 rounded-full border text-sm font-bold
            <%=
                "ALL".equals(currentTab)
                ? "bg-[#6369D1] border-[#6369D1] text-white"
                : "bg-white border-gray-200 text-gray-500"
            %>">

				전체 <span> <%=totalCount%>
			</span>

			</a>


		</div>



		<!-- ======================================
         신고 목록
    ======================================= -->

		<div class="space-y-3">


			<%

        if (!reports.isEmpty()) {


            for (ReportDto report : reports) {


                String targetType =
                        report.getTargetType();


                String typeName =
                        "신고";


                String viewButtonText =
                        "게시글 보기";


                String targetUrl =
                        "#";



                /* =================================
                   여행 일정
                ================================== */

                if ("ITINERARY".equals(
                        targetType)) {


                    typeName =
                            "여행일정";


                    targetUrl =
                            ctx
                            + "/schedules/detail?id="
                            + report.getViewTargetId();



                /* =================================
                   여행 꿀팁
                ================================== */

                } else if (
                    "TIP".equals(targetType)
                ) {


                    typeName =
                            "여행꿀팁";


                    targetUrl =
                            ctx
                            + "/tipDetail?tipId="
                            + report.getViewTargetId();



                /* =================================
                   여행 메이트
                ================================== */

                } else if (
                    "MATE".equals(targetType)
                ) {


                    typeName =
                            "여행메이트";


                    targetUrl =
                            ctx
                            + "/mateDetail?mateId="
                            + report.getViewTargetId();



                /* =================================
                   여행 꿀팁 댓글
                ================================== */

                } else if (
                    "TIP_COMMENT".equals(
                            targetType)
                ) {


                    typeName =
                            "여행꿀팁 댓글";


                    viewButtonText =
                            "원글 보기";


                    targetUrl =
                            ctx
                            + "/tipDetail?tipId="
                            + report.getViewTargetId();



                /* =================================
                   메이트 댓글
                ================================== */

                } else if (
                    "MATE_COMMENT".equals(
                            targetType)
                ) {


                    typeName =
                            "여행메이트 댓글";


                    viewButtonText =
                            "원글 보기";


                    targetUrl =
                            ctx
                            + "/mateDetail?mateId="
                            + report.getViewTargetId();



                /* =================================
                   여행 일정 댓글
                ================================== */

                } else if (
                    "ITINERARY_COMMENT".equals(
                            targetType)
                ) {


                    typeName =
                            "일정 댓글";


                    viewButtonText =
                            "원글 보기";


                    targetUrl =
                            ctx
                            + "/schedules/detail?id="
                            + report.getViewTargetId();



                /* =================================
                   사용자 프로필
                ================================== */

                } else if (
                    "USER".equals(targetType)
                ) {


                    typeName =
                            "프로필";


                    viewButtonText =
                            "프로필 보기";


                    targetUrl =
                            ctx
                            + "/profile/userProfile?userId="
                            + report.getViewTargetId();



                /* =================================
                   과거 POST 데이터
                ================================== */

                } else if (
                    "POST".equals(targetType)
                ) {


                    typeName =
                            "게시글";


                    targetUrl = "#";



                } else if (
                    "COMMENT".equals(targetType)
                ) {


                    typeName =
                            "댓글";


                    viewButtonText =
                            "원글 보기";


                    targetUrl = "#";
                }



                /* =================================
                   상태 표시
                ================================== */

                String statusName = "";

                String statusClass = "";


                if ("PENDING".equals(
                        report.getStatus())) {


                    statusName =
                            "처리 대기";


                    statusClass =
                            "bg-amber-50 text-amber-700";


                } else if (
                    "REJECTED".equals(
                            report.getStatus())
                ) {


                    statusName =
                            "문제 없음";


                    statusClass =
                            "bg-gray-100 text-gray-500";


                } else if (
                    "CONTENT_DELETE".equals(
                            report.getActionType())
                ) {


                    statusName =
                            "삭제 처리";


                    statusClass =
                            "bg-red-50 text-red-600";


                } else if (
                    "USER_SUSPEND".equals(
                            report.getActionType())
                ) {


                    statusName =
                            "계정 정지";


                    statusClass =
                            "bg-red-50 text-red-600";


                } else {


                    statusName =
                            "처리 완료";


                    statusClass =
                            "bg-gray-100 text-gray-500";
                }



                /* =================================
                   신고 대상 회원 표시
                ================================== */

                String targetUser =
                        report.getTargetNickname();


                if (targetUser == null
                        || targetUser
                            .trim()
                            .isEmpty()) {


                    targetUser =
                            report.getTargetLoginId();
                }


                if (targetUser == null
                        || targetUser
                            .trim()
                            .isEmpty()) {


                    targetUser =
                            "알 수 없음";
                }



                /* =================================
                   신고자
                ================================== */

                String reporter =
                        report.getReporterLoginId();


                if (reporter == null
                        || reporter
                            .trim()
                            .isEmpty()) {


                    reporter =
                            "탈퇴 회원";
                }



                /* =================================
                   제목
                ================================== */

                String targetTitle =
                        report.getTargetTitle();


                if (targetTitle == null
                        || targetTitle
                            .trim()
                            .isEmpty()) {


                    targetTitle =
                            "신고 대상";
                }

        %>



			<article
				class="border border-gray-200 rounded-2xl bg-white p-5 shadow-sm">


				<div class="flex flex-col sm:flex-row sm:items-start gap-4">


					<!-- ================================
                     신고 내용
                ================================= -->

					<div class="flex-1 min-w-0">


						<div class="flex items-center gap-2 flex-wrap">


							<!-- 대상 종류 -->

							<span
								class="text-[10px] font-black px-2 py-1 rounded-full bg-[#F0F0FF] text-[#6369D1]">

								<%=escapeHtml(typeName)%>

							</span>



							<!-- 처리 상태 -->

							<span
								class="text-[10px] font-black px-2 py-1 rounded-full <%=statusClass%>">

								<%=escapeHtml(statusName)%>

							</span>



							<!-- 신고 일시 -->

							<span class="text-xs text-gray-400"> <%
                            if (report.getCreatedAt()
                                    != null) {
                            %> <%=dateFormat.format(
                                    report.getCreatedAt()
                            )%> <%
                            }
                            %>


							</span>


						</div>



						<!-- 제목 -->

						<h2 class="font-black text-lg mt-3">

							<%=escapeHtml(
                            targetTitle
                        )%>

						</h2>



						<!-- 정보 -->

						<div class="grid sm:grid-cols-[90px_1fr] gap-y-2 mt-4 text-sm">


							<!-- 신고 사유 -->

							<span class="text-gray-400 font-bold"> 신고 사유 </span> <span
								class="text-gray-700"> <%=escapeHtml(
                                report.getReasonName()
                            )%>

							</span>



							<!-- 신고 대상 -->

							<span class="text-gray-400 font-bold"> 신고 대상 </span> <span
								class="text-gray-700"> <%=escapeHtml(
                                targetUser
                            )%>

							</span>



							<!-- 신고자 -->

							<span class="text-gray-400 font-bold"> 신고자 </span> <span
								class="text-gray-700"> <%=escapeHtml(
                                reporter
                            )%>

							</span>



							<!-- 상세 내용 -->

							<%

                        if (report.getDetail()
                                != null
                                &&
                                !report.getDetail()
                                    .trim()
                                    .isEmpty()) {

                        %>


							<span class="text-gray-400 font-bold"> 상세 내용 </span> <span
								class="text-gray-600"> <%=escapeHtml(
                                report.getDetail()
                            )%>

							</span>


							<%
                        }
                        %>


						</div>


					</div>



					<!-- ================================
                     버튼
                ================================= -->

					<div class="flex sm:flex-col gap-2 shrink-0">


						<!-- 대상 보기 -->

						<%

                    if (!"#".equals(targetUrl)) {

                    %>


						<a href="<%=targetUrl%>"
							class="text-center px-4 py-2.5 rounded-xl border border-gray-200 text-sm font-bold text-gray-600">

							<%=viewButtonText%>

						</a>


						<%
                    }
                    %>



						<!-- 처리 대기인 경우만 관리자 버튼 표시 -->

						<%

                    if ("PENDING".equals(
                            report.getStatus())) {

                    %>



						<!-- 문제 없음 -->

						<form action="<%=ctx%>/admin/reports/process" method="post"
							onsubmit="return confirm('이 신고를 문제 없음으로 처리하시겠습니까?');">


							<input type="hidden" name="reportId"
								value="<%=report.getReportId()%>"> <input type="hidden"
								name="action" value="REJECT">


							<button type="submit"
								class="w-full px-4 py-2.5 rounded-xl border border-gray-200 text-sm font-bold text-gray-500">

								문제 없음</button>


						</form>



						<!-- =============================
                         프로필 신고
                    ============================== -->

						<%

                    if ("USER".equals(targetType)) {

                    %>


						<form action="<%=ctx%>/admin/reports/process" method="post"
							onsubmit="return confirm('이 회원의 계정을 정지하시겠습니까?');">


							<input type="hidden" name="reportId"
								value="<%=report.getReportId()%>"> <input type="hidden"
								name="action" value="SUSPEND">


							<button type="submit"
								class="w-full px-4 py-2.5 rounded-xl bg-red-500 text-white text-sm font-bold">

								계정 정지</button>


						</form>



						<%

                    } else if (
                        !"POST".equals(targetType)
                        &&
                        !"COMMENT".equals(targetType)
                    ) {

                    %>



						<!-- =============================
                         콘텐츠 삭제
                    ============================== -->

						<form action="<%=ctx%>/admin/reports/process" method="post"
							onsubmit="return confirm('신고된 콘텐츠를 삭제하시겠습니까?');">


							<input type="hidden" name="reportId"
								value="<%=report.getReportId()%>"> <input type="hidden"
								name="action" value="DELETE">


							<button type="submit"
								class="w-full px-4 py-2.5 rounded-xl bg-red-500 text-white text-sm font-bold">


								<%=
                                targetType != null
                                && targetType.contains(
                                    "COMMENT"
                                )
                                ? "댓글 삭제"
                                : "삭제 조치"
                            %>


							</button>


						</form>


						<%
                    }
                    %>


						<%
                    }
                    %>


					</div>


				</div>


			</article>


			<%

            }

        } else {

        %>



			<!-- 신고 없음 -->

			<div
				class="border border-gray-200 rounded-2xl bg-white p-12 text-center">


				<div class="text-gray-400 font-bold">해당 상태의 신고 내역이 없습니다.</div>


			</div>



			<%

        }

        %>


		</div>


	</main>



	<jsp:include page="/common/footer.jsp" />


</body>

</html>