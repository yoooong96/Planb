<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage", "planner");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>일정 만들기 | Tripily</title>
<jsp:include page="/common/headStyles.jsp" />
<style>
    .planner-photo-layout {
        display: grid;
        grid-template-columns: minmax(0, 1fr) 96px;
        gap: 12px;
        height: 310px;
        min-height: 310px;
    }

    .planner-photo-preview {
        position: relative;
        border: 2px solid #D7E600;
        border-radius: 12px;
        overflow: hidden;
        background: #111827;
        min-height: 310px;
    }

    .planner-photo-preview img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
    }

    .planner-photo-empty {
        position: absolute;
        inset: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        color: rgba(255, 255, 255, 0.7);
        font-size: 12px;
        font-weight: 600;
        letter-spacing: -0.02em;
    }

    .planner-photo-thumbs {
        display: grid;
        grid-template-rows: repeat(3, 1fr);
        gap: 12px;
        min-height: 270px;
    }

    .planner-photo-thumb {
        position: relative;
        border: 2px solid #06B6F0;
        border-radius: 12px;
        overflow: hidden;
        background: #111827;
        min-height: 82px;
        cursor: grab;
        transition: transform .18s ease, box-shadow .18s ease, border-color .18s ease;
    }

    .planner-photo-thumb:hover {
        transform: translateY(-1px);
        box-shadow: 0 8px 18px rgba(99, 105, 209, 0.14);
    }

    .planner-photo-thumb.dragging {
        opacity: 0.5;
        cursor: grabbing;
    }

    .planner-photo-thumb.drag-over {
        border-color: #6369D1;
        box-shadow: 0 0 0 3px rgba(99, 105, 209, 0.12);
    }

    .planner-photo-thumb.active {
        border-color: #6369D1;
        box-shadow: 0 0 0 3px rgba(99, 105, 209, 0.12);
    }

    .planner-photo-thumb img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
    }

    .planner-photo-order {
        position: absolute;
        left: 8px;
        top: 8px;
        min-width: 22px;
        height: 22px;
        border-radius: 999px;
        background: rgba(17, 24, 39, 0.75);
        color: #fff;
        font-size: 11px;
        font-weight: 700;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 0 6px;
    }

    .planner-photo-badge {
        position: absolute;
        right: 8px;
        top: 8px;
        padding: 2px 7px;
        border-radius: 999px;
        background: #EF4444;
        color: #fff;
        font-size: 10px;
        font-weight: 700;
        line-height: 1.2;
    }

    .planner-photo-guide {
        margin-top: 10px;
        font-size: 11px;
        color: #6B7280;
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
    }

    .planner-time-grid {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 10px;
    }

    .planner-time-box {
        height: 42px;
        border: 1px solid #E5E7EB;
        border-radius: 10px;
        background: #fff;
        display: flex;
        align-items: center;
        padding: 0 12px;
        gap: 8px;
    }

    .planner-time-box label {
        font-size: 11px;
        font-weight: 700;
        color: #6B7280;
        white-space: nowrap;
    }

    .planner-time-box input {
        flex: 1;
        min-width: 0;
        border: none;
        outline: none;
        background: transparent;
        font-size: 13px;
        color: #111827;
    }

    .planner-block-type-row {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        margin-top: 12px;
        margin-bottom: 10px;
    }

    .planner-form-column {
        height: 310px;
        display: flex;
        flex-direction: column;
        gap: 10px;
    }

    .planner-field {
        height: 42px;
        min-height: 42px;
    }

    .planner-memo-field {
        flex: 1 1 auto;
        min-height: 72px;
        display: flex;
        padding: 10px 12px;
    }

    .planner-memo-field textarea {
        width: 100%;
        height: 100%;
        min-height: 0;
        resize: vertical;
    }

    .planner-block-body.is-collapsed {
        display: none;
    }

    .planner-block-toggle {
        width: 26px;
        height: 26px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: 7px;
    }

    .planner-block-grid {
        display: grid;
        grid-template-columns: minmax(0, 1.05fr) minmax(340px, .95fr);
        gap: 16px;
    }

    .planner-block-card {
        border: 2px solid #E5E7EB;
        border-radius: 16px;
        background: #fff;
        box-shadow: 0 8px 24px rgba(99, 105, 209, 0.08);
    }

    .planner-block-summary {
        border: 1px solid #E5E7EB;
        border-radius: 14px;
        background: #fff;
        padding: 14px 16px;
    }


    .planner-day-body.is-collapsed, .planner-block-body.is-collapsed { display:none; }
    .planner-type-btn { border:1px solid transparent; opacity:.62; transition:.15s ease; }
    .planner-type-btn.is-selected { opacity:1; box-shadow:0 0 0 2px rgba(99,105,209,.08); }
    .planner-saved-plan.is-hidden { display:none; }
    .planner-save-message { position:fixed; right:24px; bottom:24px; z-index:9999; background:#111827; color:#fff; padding:10px 14px; border-radius:10px; font-size:12px; font-weight:700; box-shadow:0 10px 30px rgba(0,0,0,.18); }

    @media (max-width: 1400px) {
        .planner-block-grid {
            grid-template-columns: 1fr;
        }

        .planner-photo-layout {
            grid-template-columns: minmax(0, 1fr) 88px;
        }
    }

    .planner-day-body {
        padding: 12px;
        border: 1px solid #E5E7EB;
        border-radius: 12px;
        background: #FFFFFF;
        overflow: hidden;
    }

    .planner-add-block-btn {
        width: calc(100% + 24px);
        min-height: 42px;
        margin: 0 -12px -12px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        padding: 10px 12px;
        border: 0;
        border-top: 1px solid #E5E7EB;
        border-radius: 0 0 11px 11px;
        background: #FAFAFC;
        color: #6369D1;
        font-size: 12px;
        font-weight: 700;
        transition: background .16s ease, color .16s ease;
    }
    .planner-add-block-btn:hover { color:#555CD6; background:#F3F3FB; }
    .planner-day-body.is-drop-target { border-radius: 14px; outline: 2px dashed #8B91FF; outline-offset: 4px; background: #F8F8FF; }
    .planner-saved-plan-head[draggable="true"] { cursor: grab; }
    .planner-saved-plan-head[draggable="true"]:active { cursor: grabbing; }
    .planner-saved-day { border: 1px solid #E5E7EB; border-radius: 10px; margin: 6px 8px; background: #fff; }
    .planner-saved-item { border-color: #E5E7EB !important; background: #fff; }
    .planner-day-title { cursor: text; border-radius: 7px; padding: 2px 5px; margin-left: -5px; display:inline-flex; width:fit-content; max-width:100%; }
    .planner-day-title:hover { background: rgba(255,255,255,.14); }
    .planner-day-edit-icon { display:inline-flex; align-items:center; justify-content:center; width:18px; height:18px; margin-left:2px; transform:translateY(3px); border:0; border-radius:5px; background:transparent; color:rgba(255,255,255,.42); cursor:pointer; transition:color .15s ease, background .15s ease; vertical-align:middle; }
    .planner-day-edit-icon:hover { color:rgba(255,255,255,.9); background:rgba(255,255,255,.12); }
    .planner-day-edit-icon svg { width:11px; height:11px; pointer-events:none; }
    .planner-day-title-input { width: 120px; min-width: 72px; max-width: 420px; height: 28px; padding: 0 8px; border: 1px solid rgba(255,255,255,.55); border-radius: 7px; outline: none; background: rgba(255,255,255,.16); color: #fff; font-size: 14px; font-weight: 700; }
    .planner-block-card { transition: background .16s ease, border-color .16s ease, box-shadow .16s ease; }
    .planner-block-card:hover { background:#FAFAFD; }
    .planner-block-header { cursor:pointer; border-bottom:0 !important; transition: background .16s ease; border-radius:10px; }
    .planner-block-header:hover { background:rgba(99,105,209,.035); }
    .planner-block-header button { cursor:pointer; }
    .planner-date-row { width:100%; display:flex; align-items:center; justify-content:center; gap:10px; }
    .planner-date-row input[type="date"] { flex:1 1 0; width:auto !important; min-width:0; text-align:center; }
    .planner-date-row svg { flex:0 0 auto; }
    .planner-date-row input[type="date"]::-webkit-datetime-edit { text-align:center; width:100%; }
    #plannerCenterPanel { transition: opacity .18s ease, filter .18s ease; }
    #plannerCenterPanel.is-country-locked { opacity:.46; filter:grayscale(1) blur(.25px); pointer-events:none; user-select:none; }

    .planner-confirm-backdrop { position:fixed; inset:0; z-index:10000; display:none; align-items:center; justify-content:center; background:rgba(17,24,39,.42); backdrop-filter:blur(2px); padding:20px; }
    .planner-confirm-backdrop.is-open { display:flex; }
    .planner-confirm-modal { width:min(420px,100%); border:1px solid #E5E7EB; border-radius:18px; background:#fff; box-shadow:0 24px 64px rgba(17,24,39,.22); overflow:hidden; }
    .planner-confirm-head { padding:20px 22px 10px; display:flex; align-items:flex-start; gap:12px; }
    .planner-confirm-icon { width:36px; height:36px; border-radius:12px; display:flex; align-items:center; justify-content:center; flex:0 0 auto; background:#FEF2F2; color:#DC2626; font-size:18px; font-weight:900; }
    .planner-confirm-title { margin:0; color:#111827; font-size:15px; font-weight:800; }
    .planner-confirm-message { margin:5px 0 0; color:#6B7280; font-size:12px; line-height:1.6; }
    .planner-confirm-actions { display:flex; justify-content:flex-end; gap:8px; padding:14px 22px 20px; }
    .planner-confirm-btn { min-width:82px; height:38px; border-radius:10px; font-size:12px; font-weight:800; border:1px solid #E5E7EB; }
    .planner-confirm-cancel { background:#fff; color:#4B5563; }
    .planner-confirm-delete { border-color:#DC2626; background:#DC2626; color:#fff; }
    .planner-confirm-cancel:hover { background:#F9FAFB; }
    .planner-confirm-delete:hover { background:#B91C1C; border-color:#B91C1C; }

</style>
</head>
<body class="site-shell">
    <jsp:include page="/common/header.jsp" />

    <main class="flex flex-col" style="height: calc(100vh - 64px)">
        <div class="shrink-0 border-b border-gray-100" style="background: #F8F8FF">
            <div class="grid min-w-0" style="grid-template-columns: minmax(0, 1fr) 460px">
                <div class="min-w-0 px-6 py-3 flex flex-col gap-3">
                    <div class="flex items-center gap-3 min-w-0">
                        <div class="h-[46px] flex-1 min-w-0 rounded-xl border bg-white flex items-center gap-3 px-4"
                            style="border-color: #E2E5EF">
                            <svg class="shrink-0" width="16" height="16" viewBox="0 0 24 24" fill="none"
                                stroke="#6369D1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M12 20h9" />
                                <path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4Z" />
                            </svg>
                            <input
                                class="flex-1 min-w-0 font-semibold text-sm text-gray-800 outline-none bg-transparent placeholder-gray-400 border-none"
                                id="tripTitle" placeholder="여행 제목을 입력하세요" style="font-size: 14px">
                        </div>
                        <div class="flex items-center gap-1.5 shrink-0 text-gray-500 text-sm px-2">
                            <svg class="text-gray-400" width="14" height="14" viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect width="18" height="18" x="3" y="4" rx="2" />
                                <path d="M16 2v4M8 2v4M3 10h18" />
                            </svg>
                            <span>3일 · 13개 일정</span>
                        </div>
                    </div>

                    <div class="grid gap-3 min-w-0"
                        style="grid-template-columns: minmax(0, .72fr) minmax(0, .72fr) minmax(0, .42fr) minmax(380px, 1.55fr)">
                        <div class="relative min-w-0 h-[50px] rounded-xl border bg-white flex items-center gap-3 px-3.5"
                            style="border-color: #FCA5A5">
                            <div class="w-8 h-8 rounded-lg shrink-0 flex items-center justify-center"
                                style="background: #F0EFFF; color: #6369D1">
                                <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <circle cx="12" cy="12" r="10" />
                                    <path d="M2 12h20M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10Z" />
                                </svg>
                            </div>
                            <div class="min-w-0 flex-1 flex flex-col justify-center">
                                <span class="text-[10px] font-semibold text-gray-400 leading-none mb-1">국가</span>
                                <input class="outline-none text-sm text-gray-800 bg-transparent placeholder-gray-400 w-full min-w-0"
                                    id="plannerCountry" placeholder="국가 선택" value="" autocomplete="off">
                            </div>
                            <span class="text-[10px] font-semibold shrink-0" style="color: #EF4444">필수</span>
                        </div>

                        <div class="relative min-w-0 h-[50px] rounded-xl border bg-white flex items-center gap-3 px-3.5"
                            style="border-color: #E2E5EF">
                            <div class="w-8 h-8 rounded-lg shrink-0 flex items-center justify-center"
                                style="background: #F0EFFF; color: #6369D1">
                                <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M20 10c0 5-8 12-8 12S4 15 4 10a8 8 0 1 1 16 0Z" />
                                    <circle cx="12" cy="10" r="2.5" />
                                </svg>
                            </div>
                            <div class="min-w-0 flex-1 flex flex-col justify-center">
                                <span class="text-[10px] font-semibold text-gray-400 leading-none mb-1">지역 (선택)</span>
                                <input class="outline-none text-sm text-gray-800 bg-transparent placeholder-gray-400 w-full min-w-0"
                                    id="plannerRegion" placeholder="선택" value="" autocomplete="off">
                            </div>
                        </div>

                        <div class="relative min-w-0 h-[50px] rounded-xl border bg-white flex items-center gap-3 px-3.5"
                            style="border-color: #E2E5EF">
                            <div class="w-8 h-8 rounded-lg shrink-0 flex items-center justify-center"
                                style="background: #F0EFFF; color: #6369D1">
                                <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" />
                                    <circle cx="9" cy="7" r="4" />
                                    <path d="M22 21v-2a4 4 0 0 0-3-3.87" />
                                    <path d="M16 3.13a4 4 0 0 1 0 7.75" />
                                </svg>
                            </div>
                            <div class="min-w-0 flex-1 flex flex-col justify-center">
                                <span class="text-[10px] font-semibold text-gray-400 leading-none mb-1">여행 인원</span>
                                <div class="flex items-center gap-1 min-w-0">
                                    <input
                                        id="plannerTravelerCount"
                                        type="number"
                                        min="1"
                                        max="99"
                                        step="1"
                                        value="1"
                                        inputmode="numeric"
                                        class="outline-none text-sm text-gray-800 bg-transparent w-full min-w-0 border-none"
                                        aria-label="여행 인원수">
                                    <span class="text-xs text-gray-500 shrink-0">명</span>
                                </div>
                            </div>
                        </div>

                        <div class="relative min-w-0 h-[50px] rounded-xl border bg-white flex items-center gap-3 px-3.5"
                            style="border-color: #E2E5EF">
                            <div class="w-8 h-8 rounded-lg shrink-0 flex items-center justify-center"
                                style="background: #F0EFFF; color: #6369D1">
                                <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <rect width="18" height="18" x="3" y="4" rx="2" />
                                    <path d="M16 2v4M8 2v4M3 10h18" />
                                </svg>
                            </div>
                            <div class="min-w-0 flex-1 flex flex-col justify-center">
                                <span class="text-[10px] font-semibold text-gray-400 leading-none mb-1">여행 기간</span>
                                <div class="planner-date-row min-w-0">
                                    <input id="plannerStartDate" type="date" class="text-xs text-gray-700 rounded-md px-1 py-0.5 outline-none cursor-pointer border-0 bg-transparent focus:bg-gray-50 min-w-0"
                                        style="color-scheme: light; width: 132px">
                                    <svg width="14" height="10" viewBox="0 0 14 10" fill="none" class="shrink-0 text-gray-400">
                                        <path d="M1 5h12M9 1l4 4-4 4" stroke="currentColor" stroke-width="1.5"
                                            stroke-linecap="round" stroke-linejoin="round" />
                                    </svg>
                                    <input id="plannerEndDate" type="date" class="text-xs text-gray-700 rounded-md px-1 py-0.5 outline-none cursor-pointer border-0 bg-transparent focus:bg-gray-50 min-w-0"
                                        style="color-scheme: light; width: 132px">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="border-l border-gray-100 px-6 py-3 flex flex-col items-end justify-center gap-3"
                    style="border-color: #E8E9F2">
                    <div class="flex items-center justify-end gap-2">
                        <button id="plannerSaveBtn" type="button" class="h-10 w-[200px] text-xs font-bold text-white rounded-xl hover:opacity-90 transition-all flex items-center justify-center gap-1.5 shadow-sm"
                            style="background: #6369D1">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2Z" />
                                <polyline points="17 21 17 13 7 13 7 21" />
                                <polyline points="7 3 7 8 15 8" />
                            </svg>
                            저장하기
                        </button>
                    </div>

                    <button id="plannerVisibility"
                        class="h-10 w-[200px] flex items-center justify-center gap-2 text-xs font-semibold rounded-full border bg-white transition-all"
                        style="border-color: #8B91FF; color: #555CD6">
                        <span class="w-1.5 h-1.5 rounded-full bg-emerald-400 shrink-0"></span>
                        공개 중
                        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="m6 9 6 6 6-6" />
                        </svg>
                    </button>
                </div>
            </div>
        </div>

        <div class="flex flex-1 min-h-0">
            <div class="relative flex shrink-0">
                <div id="plannerLeftPanel"
                    class="flex flex-col bg-gray-50 border-r border-gray-100 overflow-hidden transition-all duration-300 ease-in-out"
                    style="width: 340px">
                    <div class="w-[340px] flex flex-col h-full">
                        <div class="px-4 py-3 bg-white border-b border-gray-100 shrink-0">
                            <div class="flex items-center justify-between mb-2">
                                <h2 class="font-bold text-sm text-gray-800">📋 일정 가져오기</h2>
                                <span id="plannerPlanCount" class="text-[10px] text-gray-400">2개</span>
                            </div>
                            <div class="relative">
                                <svg class="absolute left-2.5 top-1/2 -translate-y-1/2 text-gray-400" width="13"
                                    height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <circle cx="11" cy="11" r="8" />
                                    <path d="m21 21-4.3-4.3" />
                                </svg>
                                <input id="plannerPlanSearch" type="text" placeholder="지역, 내용 검색..."
                                    class="w-full pl-8 pr-7 py-2 text-xs bg-gray-50 border border-gray-200 rounded-lg outline-none focus:border-purple-300 focus:bg-white transition-all">
                            </div>
                            <div class="mt-2 text-[10px] font-semibold" style="color:#6369D1">카드를 원하는 Day로 드래그해 가져올 수 있습니다.</div>
                            <div class="mt-2 flex gap-2 text-[10px] text-gray-400 flex-wrap">
                                <span>전체</span>
                                <span>·</span>
                                <span>D# = 1일</span>
                                <span>·</span>
                                <span>항목 = 단일</span>
                            </div>
                        </div>

                        <div id="plannerSavedPlansList" class="flex-1 overflow-y-auto p-3 flex flex-col gap-2"></div>
                    </div>
                </div>

                <button id="plannerPanelToggle" title="일정 가져오기 숨기기"
                    class="absolute right-0 top-1/2 -translate-y-1/2 translate-x-full z-20 flex flex-col items-center justify-center gap-1 shadow-md border border-gray-200 bg-white hover:bg-purple-50 transition-all"
                    style="width: 18px; height: 56px; border-radius: 0 8px 8px 0; border-left: none">
                    <svg id="plannerPanelToggleIcon" class="text-gray-400" width="13" height="13" viewBox="0 0 24 24"
                        fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round">
                        <path d="m15 18-6-6 6-6" />
                    </svg>
                </button>
            </div>

            <div id="plannerCenterPanel" class="flex-1 flex flex-col min-w-0 bg-white">
                <div class="px-5 py-2.5 border-b border-gray-100 flex items-center shrink-0">
                    <div class="flex items-center gap-2 rounded-lg px-3 py-1.5 border"
                        style="background: #FFFBEB; border-color: #F5D98B">
                        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#B8960C"
                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M20 7V5a2 2 0 0 0-2-2H5a3 3 0 0 0 0 6h15v12H5a3 3 0 0 1-3-3V6" />
                            <path d="M16 13h4" />
                        </svg>
                        <span class="text-xs font-semibold" style="color: #92720A">총 예상 예산</span>
                        <span id="plannerTotalBudget" class="text-sm font-black" style="color: #78590A">0원</span>
                    </div>
                    <button id="plannerToggleAllDays" type="button" title="모두 닫기" class="ml-auto flex items-center justify-center text-gray-500 hover:text-gray-700 w-8 h-8 rounded-lg border border-gray-200 hover:border-gray-300 transition-all">⇅</button>
                </div>

                <div id="plannerDays" class="flex-1 overflow-y-auto px-5 py-4">
                    <div class="planner-day mb-4" data-day-number="1">
                        <div class="planner-day-header flex items-center gap-3 rounded-xl px-4 py-3 cursor-pointer select-none transition-all group/hdr hover:brightness-[0.93]"
                            style="background: linear-gradient(135deg, #6369D1, #8B5CF6)">
                            <div class="w-7 h-7 rounded-full flex items-center justify-center font-black text-[11px] text-white shrink-0"
                                style="background: rgba(255, 255, 255, .22)">D1</div>
                            <div class="flex-1 min-w-0">
                                <p class="planner-day-title font-bold text-sm truncate" style="color: #fff" title="클릭하여 제목 수정">Day 1</p>
                                <button type="button" class="planner-day-edit-icon" title="DAY 제목 수정" aria-label="DAY 제목 수정">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M12 20h9"/><path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L7 19l-4 1 1-4Z"/>
                                    </svg>
                                </button>
                            </div>
                            <button type="button" class="planner-day-delete p-1 rounded transition-all hover:bg-white/20"
                                style="color: rgba(255,255,255,.6)" title="이 날 삭제">
                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <polyline points="3 6 5 6 21 6" />
                                    <path d="M19 6l-1 14H6L5 6m3 0V4h8v2M10 11v6M14 11v6" />
                                </svg>
                            </button>
                        </div>

                        <div class="planner-day-body mt-3 flex flex-col gap-3">
                            <div class="planner-block-card p-3" data-item-type="meal">
                                <div class="planner-block-header flex items-center justify-between px-2 pb-3">
                                    <div class="flex items-center gap-2">
                                        <span class="planner-block-type-badge text-[10px] font-bold rounded-full px-2 py-1"
                                            style="background: #FFF1E8; color: #F97316">식사</span>
                                        <span class="planner-block-title-label font-bold text-sm text-gray-800">츠키지 시장</span>
                                    </div>
                                    <div class="flex items-center gap-2 text-gray-400 text-xs">
                                        <button type="button" class="planner-block-toggle hover:text-gray-600" data-block-toggle aria-expanded="true" title="블록 접기">˄</button>
                                        <button type="button" class="planner-block-delete hover:text-red-500" title="일정 삭제" aria-label="일정 삭제">
                                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <polyline points="3 6 5 6 21 6" />
                                                <path d="M19 6l-1 14H6L5 6m3 0V4h8v2M10 11v6M14 11v6" />
                                            </svg>
                                        </button>
                                    </div>
                                </div>

                                <div class="planner-block-body" data-block-body>
                                    <div class="planner-block-type-row">
                                        <button type="button" data-item-type="sightseeing" class="planner-type-btn px-3 py-1 rounded-lg text-xs font-semibold" style="background:#EEF2FF;color:#6369D1">관광</button>
                                        <button type="button" data-item-type="meal" class="planner-type-btn px-3 py-1 rounded-lg text-xs font-semibold border" style="background:#FFF7ED;color:#F97316;border-color:#FDBA74">식사</button>
                                        <button type="button" data-item-type="accommodation" class="planner-type-btn px-3 py-1 rounded-lg text-xs font-semibold" style="background:#ECFDF5;color:#10B981">숙소</button>
                                        <button type="button" data-item-type="transport" class="planner-type-btn px-3 py-1 rounded-lg text-xs font-semibold" style="background:#EFF6FF;color:#3B82F6">교통</button>
                                        <button type="button" data-item-type="activity" class="planner-type-btn px-3 py-1 rounded-lg text-xs font-semibold" style="background:#FDF2F8;color:#EC4899">활동</button>
                                    </div>

                                    <div class="planner-block-grid">
                                        <div class="planner-form-column">
                                            <input class="planner-item-title planner-field rounded-lg border border-gray-200 px-3 text-sm font-semibold text-gray-800 outline-none" value="츠키지 시장" placeholder="장소 / 일정 이름 *">

                                            <div class="planner-time-grid planner-field">
                                                <div class="planner-time-box">
                                                    <label for="startTime1">시작</label>
                                                    <input id="startTime1" class="planner-start-time" type="time" value="07:30">
                                                </div>
                                                <div class="planner-time-box">
                                                    <label for="endTime1">종료</label>
                                                    <input id="endTime1" class="planner-end-time" type="time" value="09:00">
                                                </div>
                                            </div>

                                            <div class="planner-field rounded-lg border border-gray-200 flex items-center gap-2 px-3 bg-white">
                                                <input class="planner-item-cost w-24 min-w-0 outline-none bg-transparent text-sm font-semibold text-gray-800" value="15000" inputmode="numeric">
                                                <span class="text-xs font-semibold text-gray-400">원</span>
                                                <span class="planner-foreign-cost ml-auto text-xs text-indigo-400 font-semibold">1,284 엔</span>
                                            </div>

                                            <div class="planner-field rounded-lg border border-gray-200 flex items-center gap-2 px-3 bg-white">
                                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#9CA3AF" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M20 10c0 5-8 12-8 12S4 15 4 10a8 8 0 1 1 16 0Z" />
                                                    <circle cx="12" cy="10" r="2.5" />
                                                </svg>
                                                <input class="flex-1 min-w-0 outline-none bg-transparent text-sm text-gray-800" value="츠키지" placeholder="구글 지도에서 장소 검색">
                                            </div>

                                            <div class="planner-memo-field rounded-lg border border-gray-200 bg-white">
                                                <textarea class="planner-item-note outline-none text-sm text-gray-700 placeholder-gray-400 bg-transparent" placeholder="메모 (선택)">신선한 스시와 계란말이 추천</textarea>
                                            </div>
                                        </div>

                                        <div>
                                            <div class="planner-photo-layout" data-photo-gallery>
                                            <div class="planner-photo-preview">
                                                <img class="planner-photo-preview-img" src="images/figma/image-1.png" alt="확대 미리보기">
                                                <div class="planner-photo-empty hidden">사진을 선택하면 크게 보여집니다.</div>
                                            </div>

                                            <div class="planner-photo-thumbs">
                                                <button type="button" class="planner-photo-thumb active" draggable="true"
                                                    data-src="images/figma/image-1.png" data-index="0">
                                                    <img src="images/figma/image-1.png" alt="블록 사진 1">
                                                    <span class="planner-photo-order">1</span>
                                                    <span class="planner-photo-badge">대표</span>
                                                </button>

                                                <button type="button" class="planner-photo-thumb" draggable="true"
                                                    data-src="images/figma/image-2.png" data-index="1">
                                                    <img src="images/figma/image-2.png" alt="블록 사진 2">
                                                    <span class="planner-photo-order">2</span>
                                                </button>

                                                <button type="button" class="planner-photo-thumb" draggable="true"
                                                    data-src="images/figma/image-3.png" data-index="2">
                                                    <img src="images/figma/image-3.png" alt="블록 사진 3">
                                                    <span class="planner-photo-order">3</span>
                                                </button>
                                            </div>
                                        </div>
                                                                                    <div class="planner-photo-guide">
                                            <span>• 썸네일 3장까지 등록 가능</span>
                                            <span>• 클릭하면 왼쪽 크게 보기</span>
                                            <span>• 드래그로 순서 변경</span>
                                            <span>• 1번 사진이 대표 이미지</span>
                                        </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="planner-block-summary flex items-center gap-3" data-item-type="sightseeing" draggable="true">
                                <div class="w-8 h-8 rounded-lg flex items-center justify-center text-xs font-bold"
                                    style="background:#EEF2FF;color:#6369D1">관광</div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-sm font-bold text-gray-800">센소지</p>
                                    <p class="text-xs text-gray-400">09:30 · 아사쿠사</p>
                                </div>
                                <div class="text-xs font-semibold text-indigo-400">관광</div>
                            </div>

                            <div class="planner-block-summary flex items-center gap-3" data-item-type="meal" draggable="true">
                                <div class="w-8 h-8 rounded-lg flex items-center justify-center text-xs font-bold"
                                    style="background:#FFF7ED;color:#F97316">식사</div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-sm font-bold text-gray-800">아이사카 라멘 아사쿠사</p>
                                    <p class="text-xs text-gray-400">12:00 · 아사쿠사 · 15,000원</p>
                                </div>
                                <div class="text-xs font-semibold text-orange-400">식사</div>
                            </div>
                        </div>

                        <button id="plannerAddDay" type="button"
                            class="w-full mt-4 flex items-center justify-center gap-2 py-2.5 rounded-xl border-2 border-dashed border-gray-200 text-xs font-semibold text-gray-400 hover:border-purple-300 hover:text-purple-400 transition-all">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M12 5v14M5 12h14" />
                            </svg>
                            Day 2 추가
                        </button>
                    </div>
                </div>
            </div>

            <div class="w-[460px] shrink-0 border-l border-gray-100 flex flex-col bg-white">
                <div class="px-4 py-3 border-b border-gray-100 shrink-0">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center gap-2">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#6369D1"
                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <polygon points="3 6 9 3 15 6 21 3 21 18 15 21 9 18 3 21" />
                                <line x1="9" y1="3" x2="9" y2="18" />
                                <line x1="15" y1="6" x2="15" y2="21" />
                            </svg>
                            <h2 class="font-bold text-sm text-gray-800">경로 지도</h2>
                        </div>
                        <div class="relative"><button id="plannerMapFilterBtn" type="button" class="flex items-center gap-2 rounded-xl border px-3 py-1.5 text-xs font-bold shadow-sm hover:shadow-md transition-all"
                            style="border-color: #D1D2F9; color: #6369D1; background: #F5F5FF; min-width: 86px">
                            <span class="w-2 h-2 rounded-full shrink-0" style="background: #6369D1"></span>
                            <span id="plannerMapFilterLabel" class="flex-1 text-left">전체</span>
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="m6 9 6 6 6-6" />
                            </svg>
                        </button>
                            <div id="plannerMapFilterMenu" class="hidden absolute right-0 mt-1.5 w-36 rounded-xl border bg-white shadow-xl z-30 overflow-hidden" style="border-color:#D1D2F9">
                                <button type="button" data-map-day="all" class="w-full text-left px-3 py-2 text-xs font-bold hover:bg-purple-50" style="color:#6369D1">전체</button>
                                <button type="button" data-map-day="1" class="w-full text-left px-3 py-2 text-xs font-bold hover:bg-purple-50 text-gray-600">1일차</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="flex-1 flex flex-col min-h-0">
                    <div id="plannerGoogleMap" class="flex-1 w-full" style="min-height: 360px; position:relative"></div>
                </div>

                <div class="px-4 py-3 border-t border-gray-100 shrink-0">
                    <p class="text-[10px] text-gray-400 mb-2 font-medium">핀 범례</p>
                    <div class="flex flex-wrap gap-2">
                        <div class="flex items-center gap-1"><div class="w-4 h-4 rounded flex items-center justify-center" style="background:#3B82F618"><span style="color:#3B82F6;font-size:9px">●</span></div><span class="text-[10px] font-medium" style="color:#3B82F6">관광</span></div>
                        <div class="flex items-center gap-1"><div class="w-4 h-4 rounded flex items-center justify-center" style="background:#F9731618"><span style="color:#F97316;font-size:9px">●</span></div><span class="text-[10px] font-medium" style="color:#F97316">식사</span></div>
                        <div class="flex items-center gap-1"><div class="w-4 h-4 rounded flex items-center justify-center" style="background:#8B5CF618"><span style="color:#8B5CF6;font-size:9px">●</span></div><span class="text-[10px] font-medium" style="color:#8B5CF6">숙박</span></div>
                        <div class="flex items-center gap-1"><div class="w-4 h-4 rounded flex items-center justify-center" style="background:#10B98118"><span style="color:#10B981;font-size:9px">●</span></div><span class="text-[10px] font-medium" style="color:#10B981">활동</span></div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="/common/footer.jsp" />

    <script>
        (function () {
            var DRAFT_KEY = 'tripily_planner_draft_jsp_v3';
            var TYPE_CONFIG = {
                sightseeing:{label:'관광',color:'#6369D1',bg:'#EEF2FF'},
                meal:{label:'식사',color:'#F97316',bg:'#FFF7ED'},
                accommodation:{label:'숙소',color:'#10B981',bg:'#ECFDF5'},
                transport:{label:'교통',color:'#3B82F6',bg:'#EFF6FF'},
                activity:{label:'활동',color:'#EC4899',bg:'#FDF2F8'}
            };
            var map, mapMarkers=[];
            var dirty=false;

            function $(sel, root){ return (root||document).querySelector(sel); }
            function $$(sel, root){ return Array.prototype.slice.call((root||document).querySelectorAll(sel)); }
            var blockTemplate = $('.planner-block-card') ? $('.planner-block-card').cloneNode(true) : null;
            var SAVED_PLANS = [
                {id:'plan-tokyo',title:'도쿄 벚꽃 시즌 4박 5일',country:'일본',countryCode:'JP',region:'도쿄',nights:4,days:5,color:'#FF6B9D',daySchedules:[
                    {dayNum:1,theme:'아사쿠사 · 우에노',items:[
                        {type:'sightseeing',name:'센소지',time:'10:00',location:'아사쿠사',cost:'0'},
                        {type:'meal',name:'우에노 라멘',time:'13:00',location:'우에노',cost:'15000'}]},
                    {dayNum:2,theme:'시부야 · 신주쿠',items:[
                        {type:'activity',name:'시부야 스카이',time:'16:00',location:'시부야',cost:'25000'}]}
                ]},
                {id:'plan-osaka',title:'오사카 먹방 여행 3박 4일',country:'일본',countryCode:'JP',region:'오사카',nights:3,days:4,color:'#FF8C42',daySchedules:[
                    {dayNum:1,theme:'도톤보리',items:[
                        {type:'meal',name:'도톤보리 맛집',time:'18:00',location:'난바',cost:'30000'}]}
                ]}
            ];
            function money(v){ var n=parseInt(String(v||'').replace(/[^0-9]/g,''),10)||0; return n.toLocaleString('ko-KR')+'원'; }
            function toast(msg){
                var old=$('.planner-save-message'); if(old) old.remove();
                var el=document.createElement('div'); el.className='planner-save-message'; el.textContent=msg; document.body.appendChild(el);
                setTimeout(function(){ el.remove(); },2200);
            }
            function markDirty(){ dirty=true; }
            window.addEventListener('beforeunload', function(e){ if(!dirty) return; e.preventDefault(); e.returnValue=''; });

            var toggleBtn = $('#plannerPanelToggle'), panel = $('#plannerLeftPanel'), icon = $('#plannerPanelToggleIcon');
            if (toggleBtn && panel) toggleBtn.addEventListener('click', function () {
                var closed = panel.style.width === '0px'; panel.style.width = closed ? '340px' : '0px';
                toggleBtn.title = closed ? '일정 가져오기 숨기기' : '일정 가져오기 열기';
                if (icon) icon.innerHTML = closed ? '<path d="m15 18-6-6 6-6" />' : '<path d="m9 18 6-6-6-6" />';
            });

            var search=$('#plannerPlanSearch'), count=$('#plannerPlanCount');
            function dragPayload(e, payload){
                e.dataTransfer.effectAllowed='copy';
                e.dataTransfer.setData('application/x-tripily-import', JSON.stringify(payload));
                e.dataTransfer.setData('text/plain', payload.kind);
            }
            function renderSavedPlans(){
                var list=$('#plannerSavedPlansList'); if(!list)return; list.innerHTML='';
                SAVED_PLANS.forEach(function(plan){
                    var card=document.createElement('div'); card.className='planner-saved-plan rounded-xl border border-gray-200 bg-white shadow-sm overflow-hidden';
                    card.dataset.search=(plan.title+' '+plan.country+' '+plan.region+' '+plan.daySchedules.map(function(d){return d.theme+' '+d.items.map(function(i){return i.name+' '+i.location}).join(' ')}).join(' ')).toLowerCase();
                    var head=document.createElement('div'); head.className='planner-saved-plan-head flex items-center gap-2.5 px-3 py-2.5 cursor-pointer hover:bg-gray-50 transition-colors select-none'; head.draggable=true;
                    head.innerHTML='<span class="text-gray-300 text-xs">⠿</span><div class="w-8 h-8 rounded-lg flex items-center justify-center text-white text-[11px] font-black shrink-0" style="background:'+plan.color+'">'+plan.countryCode+'</div><div class="flex-1 min-w-0"><p class="text-xs font-bold text-gray-800 truncate">'+plan.title+'</p><p class="text-[10px] text-gray-400">'+plan.country+' · '+plan.nights+'박 '+plan.days+'일</p></div><span class="planner-plan-chevron text-gray-400 text-xs">⌄</span>';
                    var body=document.createElement('div'); body.className='planner-saved-plan-body hidden border-t border-gray-100';
                    plan.daySchedules.forEach(function(day){
                        var wrap=document.createElement('div'); wrap.className='border-b border-gray-50 last:border-0';
                        var row=document.createElement('div'); row.className='planner-saved-day flex items-center gap-2 px-3 py-2 cursor-pointer hover:bg-purple-50 select-none'; row.draggable=true;
                        row.innerHTML='<span class="text-gray-200 text-xs">⠿</span><span class="text-[10px] font-black text-white px-1.5 py-0.5 rounded" style="background:'+plan.color+'">D'+day.dayNum+'</span><span class="text-[11px] font-semibold text-gray-700 flex-1 truncate">'+day.theme+'</span><span class="text-[10px] text-gray-400">'+day.items.length+'개</span><span class="planner-day-chevron text-gray-400 text-xs">⌄</span>';
                        var items=document.createElement('div'); items.className='planner-saved-items hidden pl-6 pr-3 pb-2 flex flex-col gap-1';
                        day.items.forEach(function(item){
                            var cfg=TYPE_CONFIG[item.type]||TYPE_CONFIG.sightseeing; var ir=document.createElement('div'); ir.className='planner-saved-item flex items-center gap-2 px-2 py-1.5 rounded-lg cursor-grab hover:bg-gray-50 border select-none'; ir.draggable=true;
                            ir.innerHTML='<span class="text-gray-200 text-[10px]">⠿</span><span class="w-5 h-5 rounded flex items-center justify-center text-[9px] font-bold" style="background:'+cfg.bg+';color:'+cfg.color+'">'+cfg.label.substring(0,1)+'</span><span class="text-[11px] text-gray-700 flex-1 truncate font-medium">'+item.name+'</span><span class="text-[10px] text-gray-400">'+(item.time||'')+'</span>';
                            ir.addEventListener('dragstart',function(e){e.stopPropagation();dragPayload(e,{kind:'item',item:item});});
                            items.appendChild(ir);
                        });
                        row.addEventListener('click',function(){items.classList.toggle('hidden'); var c=$('.planner-day-chevron',row);if(c)c.textContent=items.classList.contains('hidden')?'⌄':'⌃';});
                        row.addEventListener('dragstart',function(e){e.stopPropagation();dragPayload(e,{kind:'day',day:day});});
                        wrap.appendChild(row); wrap.appendChild(items); body.appendChild(wrap);
                    });
                    head.addEventListener('click',function(){body.classList.toggle('hidden'); var c=$('.planner-plan-chevron',head);if(c)c.textContent=body.classList.contains('hidden')?'⌄':'⌃';});
                    head.addEventListener('dragstart',function(e){dragPayload(e,{kind:'plan',plan:plan});});
                    card.appendChild(head); card.appendChild(body); list.appendChild(card);
                });
                filterPlans();
            }
            function filterPlans(){
                var q=(search&&search.value||'').trim().toLowerCase(), visible=0;
                $$('.planner-saved-plan').forEach(function(card){ var ok=!q || (card.dataset.search||card.textContent).toLowerCase().indexOf(q)>-1; card.classList.toggle('is-hidden',!ok); if(ok) visible++; });
                if(count) count.textContent=visible+'개';
            }
            if(search) search.addEventListener('input', filterPlans);
            renderSavedPlans();

            var startDate=$('#plannerStartDate'), endDate=$('#plannerEndDate');
            function syncDates(){
                if(!startDate || !endDate) return;
                // 어느 날짜를 먼저 골라도 선택 가능하게 하고, 서로의 선택 범위만 제한한다.
                endDate.min=startDate.value||'';
                startDate.max=endDate.value||'';
                endDate.removeAttribute('aria-disabled');
                endDate.style.opacity='1';
            }
            if(startDate){
                startDate.addEventListener('change',function(){
                    if(startDate.value && endDate && endDate.value && startDate.value>endDate.value){
                        startDate.value='';
                        if(typeof showToast==='function') showToast('시작 날짜는 종료 날짜보다 늦을 수 없습니다.');
                    }
                    syncDates();
                    markDirty();
                });
            }
            if(endDate){
                endDate.addEventListener('change',function(){
                    if(endDate.value && startDate && startDate.value && endDate.value<startDate.value){
                        endDate.value='';
                        if(typeof showToast==='function') showToast('종료 날짜는 시작 날짜보다 빠를 수 없습니다.');
                    }
                    syncDates();
                    markDirty();
                });
            }
            syncDates();

            var visibility=$('#plannerVisibility');
            if(visibility) visibility.addEventListener('click',function(){
                var pub=visibility.dataset.visibility!=='PRIVATE';
                visibility.dataset.visibility=pub?'PRIVATE':'PUBLIC';
                visibility.style.borderColor=pub?'#CBD5E1':'#8B91FF'; visibility.style.color=pub?'#6B7280':'#555CD6';
                visibility.innerHTML=pub?'<span class="w-1.5 h-1.5 rounded-full bg-gray-400 shrink-0"></span>비공개<svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="m6 9 6 6 6-6"/></svg>':'<span class="w-1.5 h-1.5 rounded-full bg-emerald-400 shrink-0"></span>공개 중<svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="m6 9 6 6 6-6"/></svg>';
                markDirty();
            });

            // 새 일정 작성 화면은 Day 1만 비어 있는 상태로 시작한다.
            $$('.planner-day').forEach(function(day){
                $$('.planner-block-card,.planner-block-summary',day).forEach(function(x){x.remove();});
            });

            function setupPhotoGallery(galleryEl) {
                var previewImg = $('.planner-photo-preview-img', galleryEl); var thumbs = $$('.planner-photo-thumb', galleryEl); var dragIndex = null;
                function renderBadge(){ thumbs.forEach(function(t,i){ t.dataset.index=i; var o=$('.planner-photo-order',t); if(o)o.textContent=String(i+1); var b=$('.planner-photo-badge',t); if(i===0&&!b){b=document.createElement('span');b.className='planner-photo-badge';b.textContent='대표';t.appendChild(b);} else if(i!==0&&b)b.remove(); }); }
                function active(t){ thumbs.forEach(function(x){x.classList.toggle('active',x===t)}); if(previewImg&&t)previewImg.src=t.dataset.src; }
                function swap(a,b){ if(a==null||b==null||a===b)return; var x=thumbs[a],y=thumbs[b],xs=x.dataset.src,ys=y.dataset.src,ax=$('.planner-photo-thumb.active',galleryEl),as=ax?ax.dataset.src:null; x.dataset.src=ys;y.dataset.src=xs; $('img',x).src=ys;$('img',y).src=xs; if(as===xs)active(y);else if(as===ys)active(x);renderBadge();markDirty(); }
                thumbs.forEach(function(t,i){ t.dataset.index=i; t.addEventListener('click',function(){active(t)}); t.addEventListener('dragstart',function(e){dragIndex=+t.dataset.index;t.classList.add('dragging');e.dataTransfer.effectAllowed='move'}); t.addEventListener('dragend',function(){dragIndex=null;thumbs.forEach(function(x){x.classList.remove('dragging','drag-over')})}); t.addEventListener('dragover',function(e){e.preventDefault();t.classList.add('drag-over')}); t.addEventListener('dragleave',function(){t.classList.remove('drag-over')}); t.addEventListener('drop',function(e){e.preventDefault();swap(dragIndex,+t.dataset.index)}); }); renderBadge(); if(thumbs[0])active(thumbs[0]);
            }
            $$('[data-photo-gallery]').forEach(setupPhotoGallery);

            function syncBudget(){ var total=0; $$('.planner-item-cost').forEach(function(i){total+=parseInt(i.value.replace(/[^0-9]/g,''),10)||0;}); var out=$('#plannerTotalBudget'); if(out) out.textContent=money(total); }
            syncBudget();

            function clearEmptyHint(dayBody){
                $$('.planner-empty-day-hint', dayBody).forEach(function(x){ x.remove(); });
            }

            function makeEmptyHint(){
                var x=document.createElement('div');
                x.className='planner-empty-day-hint rounded-xl py-6 text-center text-xs text-gray-400';
                x.textContent='새 일정 블록을 추가하거나 왼쪽 일정을 끌어오세요.';
                return x;
            }

            function createBlock(prefill){
                prefill=prefill||{};
                var template=blockTemplate;
                if(!template) return null;
                var card=template.cloneNode(true);
                card.dataset.itemType=prefill.type||'sightseeing';
                card.querySelectorAll('[id]').forEach(function(el){ el.removeAttribute('id'); });
                card.querySelectorAll('label[for]').forEach(function(el){ el.removeAttribute('for'); });
                var title=$('.planner-item-title',card), label=$('.planner-block-title-label',card);
                var start=$('.planner-start-time',card), end=$('.planner-end-time',card), cost=$('.planner-item-cost',card), note=$('.planner-item-note',card);
                var place=$('input[placeholder="구글 지도에서 장소 검색"]',card);
                if(title) title.value=prefill.title||'';
                if(label) label.textContent=prefill.title||'새 일정';
                if(start) start.value=prefill.startTime||'';
                if(end) end.value=prefill.endTime||'';
                if(cost) cost.value=prefill.cost||'';
                if(place) place.value=prefill.place||'';
                if(note) note.value=prefill.note||'';
                var foreign=$('.planner-foreign-cost',card); if(foreign) foreign.textContent='—';
                var body=$('[data-block-body]',card); if(body) body.classList.remove('is-collapsed');
                var toggle=$('[data-block-toggle]',card); if(toggle){toggle.textContent='˄';toggle.setAttribute('aria-expanded','true');}
                var cfg=TYPE_CONFIG[card.dataset.itemType]||TYPE_CONFIG.sightseeing;
                var badge=$('.planner-block-type-badge',card); if(badge){badge.textContent=cfg.label;badge.style.background=cfg.bg;badge.style.color=cfg.color;}
                $$('.planner-type-btn',card).forEach(function(btn){btn.classList.toggle('is-selected',btn.dataset.itemType===card.dataset.itemType)});
                setupBlock(card);
                $$('[data-photo-gallery]',card).forEach(setupPhotoGallery);
                return card;
            }

            function addBlockToDay(day, prefill){
                var body=$('.planner-day-body',day); if(!body)return;
                clearEmptyHint(body);
                var card=createBlock(prefill); if(!card)return;
                var addBtn=$('.planner-add-block-btn',body);
                body.insertBefore(card,addBtn||null);
                if(body.classList.contains('is-collapsed')) body.classList.remove('is-collapsed');
                syncBudget(); markDirty();
                var ti=$('.planner-item-title',card); if(ti && !prefill?.title) ti.focus();
            }

            function ensureDayControls(day){
                var body=$('.planner-day-body',day); if(!body)return;
                if(!$('.planner-block-card,.planner-block-summary',body) && !$('.planner-empty-day-hint',body)) body.insertBefore(makeEmptyHint(),body.firstChild);
                if(!$('.planner-add-block-btn',body)){
                    var btn=document.createElement('button');
                    btn.type='button'; btn.className='planner-add-block-btn';
                    btn.innerHTML='<span style="font-size:16px;line-height:1">＋</span><span>일정 블록 추가</span>';
                    btn.addEventListener('click',function(){ addBlockToDay(day,{type:'sightseeing'}); });
                    body.appendChild(btn);
                }
                body.addEventListener('dragover',function(e){
                    if(!e.dataTransfer.types.includes('application/x-tripily-import')) return;
                    e.preventDefault(); e.dataTransfer.dropEffect='copy'; body.classList.add('is-drop-target');
                });
                body.addEventListener('dragleave',function(e){ if(!body.contains(e.relatedTarget)) body.classList.remove('is-drop-target'); });
                body.addEventListener('drop',function(e){
                    var raw=e.dataTransfer.getData('application/x-tripily-import');
                    if(!raw)return; e.preventDefault(); body.classList.remove('is-drop-target');
                    try{
                        var d=JSON.parse(raw);
                        var startIndex=$$('.planner-day').indexOf(day);
                        if(d.kind==='item'){
                            addBlockToDay(day,{title:d.item.name,type:d.item.type,startTime:d.item.time||'',cost:d.item.cost||'',place:d.item.location||'',note:d.item.note||''});
                            toast('일정 블록 1개를 가져왔습니다.');
                        } else if(d.kind==='day'){
                            (d.day.items||[]).forEach(function(item){addBlockToDay(day,{title:item.name,type:item.type,startTime:item.time||'',cost:item.cost||'',place:item.location||'',note:item.note||''});});
                            toast('D'+d.day.dayNum+' 일정을 가져왔습니다.');
                        } else if(d.kind==='plan'){
                            var schedules=d.plan.daySchedules||[];
                            var needed=Math.max(1,schedules.length);
                            while($$('.planner-day').length < startIndex + needed){ $('#plannerAddDay').click(); }
                            var targets=$$('.planner-day');
                            schedules.forEach(function(ds,di){(ds.items||[]).forEach(function(item){addBlockToDay(targets[startIndex+di],{title:item.name,type:item.type,startTime:item.time||'',cost:item.cost||'',place:item.location||'',note:item.note||''});});});
                            toast('Day '+(startIndex+1)+'부터 '+needed+'개 Day를 가져왔습니다.');
                        }
                    }catch(err){ console.error(err); }
                });
            }


            var plannerDeleteAction=null;
            function openDeleteModal(title,message,onDelete){
                setupDeleteModal();
                var backdrop=$('#plannerConfirmBackdrop'), titleEl=$('#plannerConfirmTitle'), msgEl=$('#plannerConfirmMessage');
                if(!backdrop){ if(window.confirm(message||title)){ onDelete(); } return; }
                plannerDeleteAction=onDelete;
                if(titleEl) titleEl.textContent=title||'삭제하시겠습니까?';
                if(msgEl) msgEl.textContent=message||'삭제한 내용은 현재 작성 화면에서 제거됩니다.';
                backdrop.classList.add('is-open'); backdrop.setAttribute('aria-hidden','false');
                var cancel=$('#plannerConfirmCancel'); if(cancel) cancel.focus();
            }
            function closeDeleteModal(){
                var backdrop=$('#plannerConfirmBackdrop'); if(backdrop){backdrop.classList.remove('is-open');backdrop.setAttribute('aria-hidden','true');}
                plannerDeleteAction=null;
            }
            function setupDeleteModal(){
                var backdrop=$('#plannerConfirmBackdrop'), cancel=$('#plannerConfirmCancel'), ok=$('#plannerConfirmDelete');
                if(!backdrop || backdrop.dataset.bound==='1') return;
                backdrop.dataset.bound='1';
                if(cancel) cancel.addEventListener('click',function(e){ e.preventDefault(); e.stopPropagation(); closeDeleteModal(); });
                if(ok) ok.addEventListener('click',function(e){
                    e.preventDefault(); e.stopPropagation();
                    var fn=plannerDeleteAction;
                    closeDeleteModal();
                    if(fn) fn();
                });
                backdrop.addEventListener('click',function(e){ if(e.target===backdrop) closeDeleteModal(); });
                document.addEventListener('keydown',function(e){
                    if(e.key==='Escape' && backdrop.classList.contains('is-open')){
                        e.preventDefault();
                        closeDeleteModal();
                    }
                });
            }
            if(document.readyState==='loading') document.addEventListener('DOMContentLoaded',setupDeleteModal);
            else setupDeleteModal();

            function setupBlock(card){
                var body=$('[data-block-body]',card), toggle=$('[data-block-toggle]',card), del=$('.planner-block-delete',card), header=$('.planner-block-header',card), title=$('.planner-item-title',card), label=$('.planner-block-title-label',card), badge=$('.planner-block-type-badge',card);
                if(toggle&&body) toggle.addEventListener('click',function(){var c=body.classList.toggle('is-collapsed');toggle.textContent=c?'⌄':'˄';toggle.title=c?'블록 펼치기':'블록 접기';toggle.setAttribute('aria-expanded',c?'false':'true')});
                if(header&&body) header.addEventListener('click',function(e){ if(e.target.closest('button')) return; var c=body.classList.toggle('is-collapsed'); if(toggle){toggle.textContent=c?'⌄':'˄';toggle.title=c?'블록 펼치기':'블록 접기';toggle.setAttribute('aria-expanded',c?'false':'true');} });
                if(del) del.addEventListener('click',function(e){ e.stopPropagation(); openDeleteModal('일정 블록을 삭제하시겠습니까?','이 블록의 입력 내용이 현재 작성 화면에서 제거됩니다.',function(){ card.remove(); syncBudget(); markDirty(); }); });
                if(title) title.addEventListener('input',function(){ if(label)label.textContent=title.value||'제목 없음';markDirty(); });
                $$('.planner-type-btn',card).forEach(function(btn){
                    if(btn.dataset.itemType===card.dataset.itemType) btn.classList.add('is-selected');
                    btn.addEventListener('click',function(){ var cfg=TYPE_CONFIG[btn.dataset.itemType]; card.dataset.itemType=btn.dataset.itemType; $$('.planner-type-btn',card).forEach(function(x){x.classList.toggle('is-selected',x===btn)}); if(badge){badge.textContent=cfg.label;badge.style.background=cfg.bg;badge.style.color=cfg.color;} markDirty(); });
                });
                var cost=$('.planner-item-cost',card); if(cost) cost.addEventListener('input',function(){cost.value=cost.value.replace(/[^0-9]/g,'');syncBudget();markDirty();});
                $$('input,textarea',card).forEach(function(el){ if(el!==cost) el.addEventListener('input',markDirty); });
            }
            $$('.planner-block-card').forEach(setupBlock);

            function updateAddDayButton(){
                var btn=$('#plannerAddDay'); if(!btn)return;
                var next=$$('.planner-day').length+1;
                var label=$('.planner-add-day-label',btn);
                if(label) label.textContent='Day '+next+' 추가';
                else {
                    var nodes=Array.prototype.slice.call(btn.childNodes).filter(function(n){return n.nodeType===3 && n.textContent.trim()});
                    if(nodes.length) nodes[nodes.length-1].textContent=' Day '+next+' 추가';
                }
            }

            function renumberDays(){
                $$('.planner-day').forEach(function(day,i){
                    var oldNo=Number(day.dataset.dayNumber||i+1);
                    var newNo=i+1;
                    day.dataset.dayNumber=newNo;
                    var circle=day.querySelector('.planner-day-header > div:first-child');
                    var title=day.querySelector('.planner-day-title');
                    if(circle) circle.textContent='D'+newNo;
                    if(title){
                        var current=(title.textContent||'').trim();
                        if(!current || current==='Day '+oldNo || current==='Day'+oldNo) title.textContent='Day '+newNo;
                    }
                });
                updateAddDayButton(); rebuildMapFilter();
            }

            function enableDayTitleEdit(day){
                var title=$('.planner-day-title',day);
                if(!title || title.dataset.editReady==='1') return;
                title.dataset.editReady='1';
                title.addEventListener('click',function(e){
                    e.stopPropagation();
                    if(title.querySelector('input')) return;
                    var before=(title.textContent||'').trim();
                    var input=document.createElement('input');
                    input.type='text'; input.className='planner-day-title-input'; input.value=before; input.maxLength=100;
                    var resizeTitleInput=function(){input.style.width=Math.min(420,Math.max(72,(input.value.length+1)*14))+'px';}; resizeTitleInput(); input.addEventListener('input',resizeTitleInput);
                    title.textContent=''; title.appendChild(input); input.focus(); input.select();
                    var finish=function(save){
                        if(!input.isConnected) return;
                        var value=save ? input.value.trim() : before;
                        title.textContent=value || before || ('Day '+day.dataset.dayNumber);
                        if(save && title.textContent!==before) markDirty();
                    };
                    input.addEventListener('click',function(ev){ev.stopPropagation();});
                    input.addEventListener('keydown',function(ev){
                        if(ev.key==='Enter'){ev.preventDefault(); finish(true);}
                        else if(ev.key==='Escape'){ev.preventDefault(); finish(false);}
                    });
                    input.addEventListener('blur',function(){finish(true);});
                });
                var editIcon=$('.planner-day-edit-icon',day);
                if(editIcon && editIcon.dataset.editReady!=='1'){
                    editIcon.dataset.editReady='1';
                    editIcon.addEventListener('click',function(e){
                        e.preventDefault(); e.stopPropagation();
                        title.click();
                    });
                }
            }

            function setupDay(day){
                if(day.dataset.dayReady==='1') return; day.dataset.dayReady='1';
                var h=$('.planner-day-header',day), b=$('.planner-day-body',day), del=$('.planner-day-delete',day);
                if(h&&b) h.addEventListener('click',function(e){ if(e.target.closest('.planner-day-delete') || e.target.closest('.planner-day-title') || e.target.closest('.planner-day-edit-icon'))return; b.classList.toggle('is-collapsed'); });
                enableDayTitleEdit(day);
                if(del) del.addEventListener('click',function(e){
                    e.stopPropagation();
                    var days=$$('.planner-day');
                    var dayNo=day.dataset.dayNumber||'';
                    openDeleteModal('D'+dayNo+'을 삭제하시겠습니까?', days.length<=1 ? '마지막 DAY는 유지되고, 안에 작성한 일정 블록만 모두 삭제됩니다.' : '이 DAY와 안에 작성한 일정 블록이 현재 작성 화면에서 제거됩니다.', function(){
                        if(days.length<=1){ $$('.planner-block-card,.planner-block-summary',day).forEach(function(x){x.remove()}); ensureDayControls(day); }
                        else day.remove();
                        renumberDays(); syncBudget(); markDirty();
                    });
                });
                ensureDayControls(day);
            }
            $$('.planner-day').forEach(setupDay);

            var addDay=$('#plannerAddDay');
            if(addDay){
                // Day 추가 버튼은 특정 Day 안이 아니라 전체 Day 목록의 맨 아래에 둔다.
                var daysWrap=$('#plannerDays'); daysWrap.appendChild(addDay);
                var label=document.createElement('span'); label.className='planner-add-day-label'; label.textContent='Day '+($$('.planner-day').length+1)+' 추가';
                Array.prototype.slice.call(addDay.childNodes).forEach(function(n){ if(n.nodeType===3 && n.textContent.trim()) n.remove(); });
                addDay.appendChild(label);
                addDay.addEventListener('click',function(){
                    var n=$$('.planner-day').length+1;
                    var d=document.createElement('div'); d.className='planner-day mb-4'; d.dataset.dayNumber=n;
                    d.innerHTML='<div class="planner-day-header flex items-center gap-3 rounded-xl px-4 py-3 cursor-pointer select-none transition-all" style="background:linear-gradient(135deg,#6369D1,#8B5CF6)"><div class="w-7 h-7 rounded-full flex items-center justify-center font-black text-[11px] text-white shrink-0" style="background:rgba(255,255,255,.22)">D'+n+'</div><div class="flex-1 min-w-0"><p class="planner-day-title font-bold text-sm truncate" style="color:#fff" title="클릭하여 제목 수정">Day '+n+'</p><button type="button" class="planner-day-edit-icon" title="DAY 제목 수정" aria-label="DAY 제목 수정"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20h9"/><path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L7 19l-4 1 1-4Z"/></svg></button></div><button type="button" class="planner-day-delete p-1 rounded" style="color:rgba(255,255,255,.6)" title="이 날 삭제"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14H6L5 6m3 0V4h8v2M10 11v6M14 11v6"/></svg></button></div><div class="planner-day-body mt-3 flex flex-col gap-3"></div>';
                    daysWrap.insertBefore(d,addDay); setupDay(d); renumberDays(); markDirty();
                    d.scrollIntoView({behavior:'smooth',block:'nearest'});
                });
            }
            renumberDays();


            var allBtn=$('#plannerToggleAllDays');
            if(allBtn) allBtn.addEventListener('click',function(){ var bodies=$$('.planner-day-body'), anyOpen=bodies.some(function(x){return !x.classList.contains('is-collapsed')}); bodies.forEach(function(x){x.classList.toggle('is-collapsed',anyOpen)}); allBtn.title=anyOpen?'모두 열기':'모두 닫기'; });

            function rebuildMapFilter(){ var menu=$('#plannerMapFilterMenu'); if(!menu)return; menu.innerHTML='<button type="button" data-map-day="all" class="w-full text-left px-3 py-2 text-xs font-bold hover:bg-purple-50" style="color:#6369D1">전체</button>'+$$('.planner-day').map(function(d){var n=d.dataset.dayNumber;return '<button type="button" data-map-day="'+n+'" class="w-full text-left px-3 py-2 text-xs font-bold hover:bg-purple-50 text-gray-600">'+n+'일차</button>'}).join(''); bindMapOptions(); }
            function bindMapOptions(){ $$('#plannerMapFilterMenu [data-map-day]').forEach(function(b){ b.onclick=function(){ $('#plannerMapFilterLabel').textContent=b.dataset.mapDay==='all'?'전체':b.dataset.mapDay+'일차'; $('#plannerMapFilterMenu').classList.add('hidden'); refreshMap(b.dataset.mapDay); }; }); }
            var mf=$('#plannerMapFilterBtn'); if(mf) mf.addEventListener('click',function(e){e.stopPropagation();$('#plannerMapFilterMenu').classList.toggle('hidden')}); document.addEventListener('click',function(e){var m=$('#plannerMapFilterMenu');if(m&&!e.target.closest('#plannerMapFilterBtn')&&!e.target.closest('#plannerMapFilterMenu'))m.classList.add('hidden')}); bindMapOptions();

            function collectDraft(){ return {tripTitle:$('#tripTitle')?.value||'',country:$('#plannerCountry')?.value||'',region:$('#plannerRegion')?.value||'',travelerCount:$('#plannerTravelerCount')?.value||'1',startDate:startDate?.value||'',endDate:endDate?.value||'',visibility:visibility?.dataset.visibility||'PUBLIC',savedAt:new Date().toISOString()}; }
            function restoreDraft(){
                try{
                    var raw=sessionStorage.getItem(DRAFT_KEY); if(!raw)return; var d=JSON.parse(raw);
                    if($('#tripTitle')&&d.tripTitle!=null)$('#tripTitle').value=d.tripTitle;
                    if($('#plannerCountry')&&d.country!=null)$('#plannerCountry').value=d.country;
                    if($('#plannerRegion')&&d.region!=null)$('#plannerRegion').value=d.region;
                    if($('#plannerTravelerCount')&&d.travelerCount!=null)$('#plannerTravelerCount').value=d.travelerCount;
                    if(startDate&&d.startDate!=null)startDate.value=d.startDate;
                    if(endDate&&d.endDate!=null)endDate.value=d.endDate;
                    syncDates();
                    if(visibility&&d.visibility==='PRIVATE'&&visibility.dataset.visibility!=='PRIVATE')visibility.click();
                    dirty=false;
                }catch(e){ sessionStorage.removeItem(DRAFT_KEY); }
            }
            var save=$('#plannerSaveBtn'); if(save) save.addEventListener('click',function(){ sessionStorage.setItem(DRAFT_KEY,JSON.stringify(collectDraft())); dirty=false; toast('일정 내용이 임시 저장되었습니다.'); });
            ['#tripTitle','#plannerCountry','#plannerRegion','#plannerTravelerCount'].forEach(function(sel){var el=$(sel);if(el)el.addEventListener('input',markDirty)});
            var travelerCountInput=$('#plannerTravelerCount');
            if(travelerCountInput){
                travelerCountInput.addEventListener('change',function(){
                    var n=parseInt(travelerCountInput.value,10);
                    if(!Number.isFinite(n) || n<1) n=1;
                    if(n>99) n=99;
                    travelerCountInput.value=String(n);
                });
            }

            function syncCountryLock(){
                var country=$('#plannerCountry'), center=$('#plannerCenterPanel');
                if(!center) return;
                var locked=!(country && country.value.trim());
                center.classList.toggle('is-country-locked',locked);
                center.setAttribute('aria-disabled',locked?'true':'false');
            }
            var countryInput=$('#plannerCountry');
            if(countryInput){
                countryInput.addEventListener('input',syncCountryLock);
                countryInput.addEventListener('change',syncCountryLock);
            }
            restoreDraft();
            syncCountryLock();

            function plannerMapQuery(){
                var region=$('#plannerRegion') ? $('#plannerRegion').value.trim() : '';
                var country=$('#plannerCountry') ? $('#plannerCountry').value.trim() : '';
                return [region,country].filter(Boolean).join(', ') || 'Seoul, Korea';
            }
            window.showPlannerMapFallback=function(force){
                var el=$('#plannerGoogleMap');
                if(!el || (el.dataset.fallback==='1' && !force)) return;
                el.dataset.fallback='1';
                var q=encodeURIComponent(plannerMapQuery());
                el.innerHTML='<iframe title="경로 지도" src="https://maps.google.com/maps?q='+q+'&z=11&output=embed" style="width:100%;height:100%;min-height:360px;border:0;display:block" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>';
            };
            window.initPlannerMap=function(){
                var el=$('#plannerGoogleMap');
                if(!el||!window.google||!google.maps){ showPlannerMapFallback(); return; }
                try{
                    el.dataset.fallback='0';
                    el.innerHTML='';
                    map=new google.maps.Map(el,{center:{lat:37.5665,lng:126.9780},zoom:11,mapTypeControl:false,streetViewControl:false,fullscreenControl:false,styles:[{featureType:'poi',elementType:'labels',stylers:[{visibility:'off'}]},{featureType:'transit',elementType:'labels',stylers:[{visibility:'off'}]}]});
                    refreshMap('all');
                }catch(e){ showPlannerMapFallback(); }
            };
            window.refreshMap=function(day){
                if(!map||!window.google||!google.maps){ showPlannerMapFallback(); return; }
                mapMarkers.forEach(function(m){m.setMap(null)});mapMarkers=[];
                var points=[];
                var bounds=new google.maps.LatLngBounds(),has=false;
                points.filter(function(p){return day==='all'||p.day===String(day)}).forEach(function(p,i){var m=new google.maps.Marker({position:{lat:p.lat,lng:p.lng},map:map,title:p.name,label:{text:String(i+1),color:'#fff',fontWeight:'bold'},icon:{path:google.maps.SymbolPath.CIRCLE,scale:14,fillColor:p.color,fillOpacity:1,strokeColor:'#fff',strokeWeight:2}}); var iw=new google.maps.InfoWindow({content:'<div style="font-size:13px;font-weight:600;padding:4px">'+p.name+'</div>'});m.addListener('click',function(){iw.open(map,m)});mapMarkers.push(m);bounds.extend(m.getPosition());has=true;});
                if(has) map.fitBounds(bounds);
            };
            ['#plannerCountry','#plannerRegion'].forEach(function(sel){
                var el=$(sel);
                if(el) el.addEventListener('change',function(){ if($('#plannerGoogleMap') && $('#plannerGoogleMap').dataset.fallback==='1') showPlannerMapFallback(true); });
            });
            window.setTimeout(function(){ if(!map) showPlannerMapFallback(); },1800);
        })();
    </script>
    <script async
        onerror="showPlannerMapFallback()" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB7ioaQS08aAzCl7gZPk6SyE1w7EeIrYhI&language=ko&loading=async&callback=initPlannerMap"></script>

    <div id="plannerConfirmBackdrop" class="planner-confirm-backdrop" aria-hidden="true">
        <div class="planner-confirm-modal" role="dialog" aria-modal="true" aria-labelledby="plannerConfirmTitle">
            <div class="planner-confirm-head">
                <div class="planner-confirm-icon">!</div>
                <div>
                    <h3 id="plannerConfirmTitle" class="planner-confirm-title">삭제하시겠습니까?</h3>
                    <p id="plannerConfirmMessage" class="planner-confirm-message">삭제한 내용은 현재 작성 화면에서 제거됩니다.</p>
                </div>
            </div>
            <div class="planner-confirm-actions">
                <button type="button" id="plannerConfirmCancel" class="planner-confirm-btn planner-confirm-cancel">취소</button>
                <button type="button" id="plannerConfirmDelete" class="planner-confirm-btn planner-confirm-delete">삭제</button>
            </div>
        </div>
    </div>

</body>
</html>
