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
        background: #E5E7EB;
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
        flex-direction: column;
        gap: 8px;
        align-items: center;
        justify-content: center;
        color: #9CA3AF;
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
        border: 2px solid #D1D5DB;
        border-radius: 12px;
        overflow: hidden;
        background: #E5E7EB;
        min-height: 82px;
        cursor: pointer;
        transition: transform .18s ease, box-shadow .18s ease, border-color .18s ease, background .18s ease;
    }

    .planner-photo-thumb:hover {
        transform: translateY(-1px);
        box-shadow: 0 8px 18px rgba(99, 105, 209, 0.14);
    }

    .planner-photo-thumb::after {
        content: "";
        position: absolute;
        inset: 0;
        background: rgba(17, 24, 39, 0.42);
        opacity: 0;
        transition: opacity .16s ease;
        z-index: 2;
        pointer-events: none;
    }

    .planner-photo-thumb:hover::after {
        opacity: 1;
    }

    .planner-photo-plus {
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        color: #9CA3AF;
        font-size: 30px;
        font-weight: 300;
        line-height: 1;
        z-index: 1;
        pointer-events: none;
    }

    .planner-photo-thumb.has-image .planner-photo-plus {
        display: none;
    }

    .planner-photo-hover-label {
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        color: #FFFFFF;
        font-size: 11px;
        font-weight: 700;
        white-space: nowrap;
        opacity: 0;
        transition: opacity .16s ease;
        z-index: 3;
        pointer-events: none;
    }

    .planner-photo-thumb:hover .planner-photo-hover-label {
        opacity: 1;
    }

    .planner-photo-delete {
        position: absolute;
        right: 6px;
        bottom: 6px;
        width: 24px;
        height: 24px;
        border-radius: 999px;
        background: rgba(255, 255, 255, 0.96);
        color: #6B7280;
        display: flex;
        align-items: center;
        justify-content: center;
        opacity: 0;
        visibility: hidden;
        transform: translateY(2px);
        transition: opacity .16s ease, transform .16s ease, background .16s ease, color .16s ease;
        z-index: 10;
        cursor: pointer;
        padding: 0;
        box-shadow: 0 1px 4px rgba(0,0,0,.18);
    }

    .planner-photo-thumb.has-image:hover .planner-photo-delete {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }

    .planner-photo-delete:hover {
        background: #FFFFFF;
        color: #DC2626;
    }

    .planner-photo-delete svg {
        width: 13px;
        height: 13px;
        pointer-events: none;
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
        position: absolute;
        inset: 0;
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
        z-index: 1;
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
        z-index: 4;
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

    .planner-confirm-backdrop { position:fixed; inset:0; z-index:10000; display:none; align-items:center; justify-content:center; background:rgba(0,0,0,.40); padding:20px; }
    .planner-confirm-backdrop.is-open { display:flex; }
    .planner-confirm-modal { width:min(360px,100%); border:0; border-radius:16px; background:#fff; box-shadow:0 25px 50px -12px rgba(0,0,0,.28); padding:24px; display:flex; flex-direction:column; gap:16px; }
    .planner-confirm-content { display:flex; flex-direction:column; gap:8px; }
    .planner-confirm-head { display:flex; align-items:center; gap:8px; }
    .planner-confirm-icon { width:32px; height:32px; border-radius:999px; display:flex; align-items:center; justify-content:center; flex:0 0 auto; background:#FEE2E2; color:#EF4444; }
    .planner-confirm-icon svg { width:15px; height:15px; }
    .planner-confirm-title { margin:0; color:#1F2937; font-size:16px; font-weight:700; line-height:1.35; }
    .planner-confirm-body { display:flex; flex-direction:column; gap:8px; margin-top:4px; }
    .planner-confirm-message { margin:0; color:#4B5563; font-size:14px; line-height:1.55; }
    .planner-confirm-message strong { color:#1F2937; font-weight:600; }
    .planner-confirm-list { display:none; flex-direction:column; gap:4px; max-height:128px; overflow-y:auto; padding:10px 12px; border:1px solid #FEE2E2; border-radius:12px; background:#FEF2F2; }
    .planner-confirm-list.is-visible { display:flex; }
    .planner-confirm-list-item { display:flex; align-items:center; gap:8px; min-width:0; color:#374151; font-size:12px; line-height:1.4; }
    .planner-confirm-list-dot { width:7px; height:7px; border-radius:999px; flex:0 0 auto; background:#8B5CF6; }
    .planner-confirm-list-name { overflow:hidden; white-space:nowrap; text-overflow:ellipsis; }
    .planner-confirm-list-time { margin-left:auto; color:#9CA3AF; flex:0 0 auto; }
    .planner-confirm-warning { margin:0; color:#EF4444; font-size:12px; font-weight:600; }
    .planner-confirm-actions { display:flex; gap:8px; padding:0; }
    .planner-confirm-btn { flex:1 1 0; height:40px; border-radius:12px; font-size:14px; font-weight:600; border:1px solid #E5E7EB; transition:background .15s ease,border-color .15s ease; }
    .planner-confirm-cancel { background:#fff; color:#4B5563; }
    .planner-confirm-delete { border-color:#EF4444; background:#EF4444; color:#fff; font-weight:700; }
    .planner-confirm-cancel:hover { background:#F9FAFB; }
    .planner-confirm-delete:hover { background:#DC2626; border-color:#DC2626; }

    .planner-required-backdrop { position:fixed; inset:0; z-index:10020; display:none; align-items:center; justify-content:center; background:rgba(0,0,0,.40); padding:20px; }
    .planner-required-backdrop.is-open { display:flex; }
    .planner-required-modal { width:min(380px,100%); border-radius:16px; background:#fff; padding:24px; box-shadow:0 25px 50px -12px rgba(0,0,0,.28); }
    .planner-required-icon { width:34px; height:34px; border-radius:999px; display:flex; align-items:center; justify-content:center; background:#FEF2F2; color:#EF4444; font-weight:800; }
    .planner-required-list { margin:12px 0 0; padding-left:20px; color:#4B5563; font-size:13px; line-height:1.75; list-style:disc; }

    #plannerCountryDropdown button,
    #plannerRegionDropdown button { width:100%; min-height:40px; text-align:left; transition:background .15s ease; }
    #plannerCountryDropdown button:hover,
    #plannerRegionDropdown button:hover { background:#FAF5FF; }
    #plannerCountryDropdown::-webkit-scrollbar,
    #plannerRegionDropdown::-webkit-scrollbar { width:8px; }
    #plannerCountryDropdown::-webkit-scrollbar-track,
    #plannerRegionDropdown::-webkit-scrollbar-track { background:#F9FAFB; }
    #plannerCountryDropdown::-webkit-scrollbar-thumb,
    #plannerRegionDropdown::-webkit-scrollbar-thumb { background:#C7CBD4; border-radius:999px; }
    #plannerCountryDropdown,
    #plannerRegionDropdown { scrollbar-width:thin; scrollbar-color:#C7CBD4 #F9FAFB; }

    .planner-day-header[draggable="true"] { cursor:grab; }
    .planner-day-header[draggable="true"]:active { cursor:grabbing; }
    .planner-day.is-day-dragging { opacity:.48; }
    .planner-day.is-day-drag-over { outline:2px solid rgba(99,105,209,.35); outline-offset:3px; border-radius:14px; }

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
                        <div id="plannerCountryField" class="relative overflow-visible min-w-0 h-[50px] rounded-xl border bg-white flex items-center gap-3 px-3.5"
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
                                <div id="plannerCountryCombo" class="w-full min-w-0">
                                    <div class="flex items-center gap-1.5 w-full min-w-0">
                                        <input class="outline-none text-sm text-gray-800 bg-transparent placeholder-gray-400 w-full min-w-0"
                                            id="plannerCountry" placeholder="국가 선택" value="" autocomplete="off">
                                        <button type="button" id="plannerCountryClear"
                                            class="hidden shrink-0 text-gray-300 hover:text-gray-500"
                                            aria-label="국가 입력 지우기">
                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                stroke-width="2" stroke-linecap="round">
                                                <path d="M18 6 6 18M6 6l12 12"/>
                                            </svg>
                                        </button>
                                    </div>
                                    <div id="plannerCountryDropdown"
                                        class="hidden absolute top-full left-0 right-0 mt-1 bg-white border border-gray-200 rounded-xl shadow-xl z-50"
                                        style="max-height: 320px; overflow-y: auto; overflow-x: hidden;">
                                    </div>
                                </div>
                            </div>
                            <span id="plannerCountryStatus" class="text-[10px] font-semibold shrink-0 whitespace-nowrap"
                                style="color: #EF4444">필수</span>
                        </div>

                        <div class="relative overflow-visible min-w-0 h-[50px] rounded-xl border bg-white flex items-center gap-3 px-3.5"
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
                                <div id="plannerRegionCombo" class="w-full min-w-0">
                                    <div class="flex items-center gap-1.5 w-full min-w-0">
                                        <input class="outline-none text-sm text-gray-800 bg-transparent placeholder-gray-400 w-full min-w-0"
                                            id="plannerRegion" placeholder="국가 먼저 입력" value="" autocomplete="off" disabled>
                                        <button type="button" id="plannerRegionClear"
                                            class="hidden shrink-0 text-gray-300 hover:text-gray-500"
                                            aria-label="지역 입력 지우기">
                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                stroke-width="2" stroke-linecap="round">
                                                <path d="M18 6 6 18M6 6l12 12"/>
                                            </svg>
                                        </button>
                                    </div>
                                    <div id="plannerRegionDropdown"
                                        class="hidden absolute top-full left-0 right-0 mt-1 bg-white border border-gray-200 rounded-xl shadow-xl z-50"
                                        style="max-height: 280px; overflow-y: auto; overflow-x: hidden;">
                                    </div>
                                </div>
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
                            <span id="plannerSaveLabel">저장하기</span>
                        </button>

                        <form id="plannerSubmitForm" method="post" enctype="multipart/form-data" class="hidden">
                            <input type="hidden" id="plannerItineraryJson" name="itineraryJson">
                        </form>
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
                                                <img class="planner-photo-preview-img" alt="" style="display:none;">
                                                <div class="planner-photo-empty">
                                                    <span>미리보기</span>
                                                </div>
                                            </div>

                                            <div class="planner-photo-thumbs">
                                                <button type="button" class="planner-photo-thumb is-empty" draggable="true"
                                                    data-src="" data-index="0">
                                                    <span class="planner-photo-plus">+</span>
                                                    <span class="planner-photo-hover-label">이미지 등록하기</span>
                                                    <span class="planner-photo-delete" role="button" tabindex="0" aria-label="이미지 삭제">
                                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                            <polyline points="3 6 5 6 21 6"></polyline>
                                                            <path d="M19 6l-1 14H6L5 6"></path>
                                                            <path d="M10 11v6"></path>
                                                            <path d="M14 11v6"></path>
                                                            <path d="M9 6V4h6v2"></path>
                                                        </svg>
                                                    </span>
                                                </button>

                                                <button type="button" class="planner-photo-thumb is-empty" draggable="true"
                                                    data-src="" data-index="1">
                                                    <span class="planner-photo-plus">+</span>
                                                    <span class="planner-photo-hover-label">이미지 등록하기</span>
                                                    <span class="planner-photo-delete" role="button" tabindex="0" aria-label="이미지 삭제">
                                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                            <polyline points="3 6 5 6 21 6"></polyline>
                                                            <path d="M19 6l-1 14H6L5 6"></path>
                                                            <path d="M10 11v6"></path>
                                                            <path d="M14 11v6"></path>
                                                            <path d="M9 6V4h6v2"></path>
                                                        </svg>
                                                    </span>
                                                </button>

                                                <button type="button" class="planner-photo-thumb is-empty" draggable="true"
                                                    data-src="" data-index="2">
                                                    <span class="planner-photo-plus">+</span>
                                                    <span class="planner-photo-hover-label">이미지 등록하기</span>
                                                    <span class="planner-photo-delete" role="button" tabindex="0" aria-label="이미지 삭제">
                                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                            <polyline points="3 6 5 6 21 6"></polyline>
                                                            <path d="M19 6l-1 14H6L5 6"></path>
                                                            <path d="M10 11v6"></path>
                                                            <path d="M14 11v6"></path>
                                                            <path d="M9 6V4h6v2"></path>
                                                        </svg>
                                                    </span>
                                                </button>
                                            </div>

                                            <input type="file" class="planner-photo-file-input hidden" accept="image/*">
                                        </div>
                                                                                    <div class="planner-photo-guide">
                                            <span>• 썸네일 3장까지 등록 가능</span>
                                            <span>• 클릭해서 이미지 등록 / 변경</span>
                                            <span>• 등록 후 왼쪽에서 크게 보기</span>
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
            /*
             * PlannerServlet에서 전달한 카트 조회 결과.
             *
             * List<ItineraryDto>
             *  └ days
             *      └ blocks
             */
            var IMPORT_ITINERARIES =
                ${empty importListJson ? '[]' : importListJson};

            function dbBlockTypeToPlanner(type){
                var map={
                    ATTRACTION:'sightseeing',
                    MEAL:'meal',
                    LODGING:'accommodation',
                    TRANSPORT:'transport',
                    ACTIVITY:'activity'
                };

                return map[type] || 'sightseeing';
            }

            function shortTime(value){
                if(!value) return '';
                value=String(value);
                return value.length>=5 ? value.substring(0,5) : value;
            }

            function calculateTripDays(startDate,endDate,fallback){
                if(startDate && endDate){
                    var s=new Date(startDate+'T00:00:00');
                    var e=new Date(endDate+'T00:00:00');

                    if(!isNaN(s.getTime()) && !isNaN(e.getTime())){
                        return Math.max(
                            1,
                            Math.round((e-s)/(1000*60*60*24))+1
                        );
                    }
                }

                return Math.max(1,fallback||1);
            }

            function normalizeImportItinerary(itinerary,index){
                itinerary=itinerary||{};

                var rawDays=Array.isArray(itinerary.days)
                    ? itinerary.days
                    : [];

                var tripDays=calculateTripDays(
                    itinerary.startDate,
                    itinerary.endDate,
                    rawDays.length
                );

                return {
                    id:'cart-itinerary-'+(itinerary.itineraryId||index),
                    sourceItineraryId:itinerary.itineraryId||null,
                    title:itinerary.title||'제목 없는 일정',
                    country:itinerary.country||'',
                    countryCode:'',
                    region:itinerary.city||'',
                    travelerCount:itinerary.travelerCount == null
                        ? 1
                        : Number(itinerary.travelerCount),
                    nights:Math.max(0,tripDays-1),
                    days:tripDays,
                    color:'#6369D1',

                    daySchedules:rawDays.map(function(day,dayIndex){
                        day=day||{};

                        var rawBlocks=Array.isArray(day.blocks)
                            ? day.blocks
                            : [];

                        return {
                            sourceDayId:day.dayId||null,
                            dayNum:day.dayOrder||dayIndex+1,
                            theme:day.title||('Day '+(day.dayOrder||dayIndex+1)),

                            items:rawBlocks.map(function(block){
                                block=block||{};

                                return {
                                    sourceBlockId:block.blockId||null,
                                    type:dbBlockTypeToPlanner(block.blockType),
                                    name:block.title||'새 일정',
                                    time:shortTime(block.startTime),
                                    endTime:shortTime(block.endTime),
                                    location:'',
                                    cost:block.cost==null ? 0 : block.cost,
                                    note:block.memo||''
                                };
                            })
                        };
                    })
                };
            }

            var SAVED_PLANS=IMPORT_ITINERARIES.map(
                normalizeImportItinerary
            );

            function money(v){ var n=parseInt(String(v||'').replace(/[^0-9]/g,''),10)||0; return n.toLocaleString('ko-KR')+'원'; }
            function escapeImportHtml(value){
                return String(value==null?'':value)
                    .replace(/&/g,'&amp;')
                    .replace(/</g,'&lt;')
                    .replace(/>/g,'&gt;')
                    .replace(/"/g,'&quot;')
                    .replace(/'/g,'&#39;');
            }
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

                /*
                 * 국가 미선택 상태에서도 '일정 가져오기'는 가능해야 하므로
                 * 가져오기 드래그 중에만 중앙 영역 잠금을 임시 해제한다.
                 */
                var center=$('#plannerCenterPanel');
                if(center){
                    center.dataset.importDragActive='1';
                    center.classList.remove('is-country-locked');
                    center.setAttribute('aria-disabled','false');
                }
            }

            function finishImportDrag(){
                var center=$('#plannerCenterPanel');

                if(center){
                    delete center.dataset.importDragActive;
                }

                syncCountryLock();
                syncCountryEditLock();
            }

            function importHeaderMeta(plan){
                return {
                    country:plan && plan.country ? plan.country : '',
                    region:plan && plan.region ? plan.region : '',
                    travelerCount:plan && plan.travelerCount
                        ? Number(plan.travelerCount)
                        : 1
                };
            }

            function plannerHasBlocks(){
                return $$('.planner-day .planner-block-card').length > 0;
            }

            /*
             * 가져오기 전에 아직 작성된 블록이 없고 국가도 비어 있으면
             * 원본 일정의 국가 / 지역 / 인원을 자동 입력한다.
             *
             * 제목과 여행기간은 의도적으로 건드리지 않는다.
             */
            function applyImportHeaderDefaults(payload){
                if(!payload || !payload.importMeta) return;
                if(plannerHasBlocks()) return;

                var country=$('#plannerCountry');
                var region=$('#plannerRegion');
                var traveler=$('#plannerTravelerCount');

                if(!country || normalizePlannerText(country.value)) return;

                var meta=payload.importMeta;

                if(meta.country){
                    country.value=meta.country;
                    refreshCountryStatus();
                    refreshRegionOptions(true);
                }

                if(region && meta.region){
                    /*
                     * 국가 선택 후 refreshRegionOptions()가 region을 활성화하므로
                     * 그 다음 실제 지역명을 넣는다.
                     */
                    region.value=meta.region;
                    updateRegionClear();
                }

                if(traveler){
                    var n=parseInt(meta.travelerCount,10);
                    if(!Number.isFinite(n) || n<1) n=1;
                    if(n>99) n=99;
                    traveler.value=String(n);
                }

                updateCountryClear();
                filterPlans();
                syncCountryLock();
                markDirty();
            }

            /*
             * DAY 아래에 블록이 하나라도 존재하면 국가 변경 금지.
             * 블록을 모두 삭제하면 다시 국가 수정 가능.
             */
            function syncCountryEditLock(){
                var input=$('#plannerCountry');
                var clearBtn=$('#plannerCountryClear');
                var dropdown=$('#plannerCountryDropdown');
                if(!input) return;

                var locked=plannerHasBlocks();

                input.disabled=locked;
                input.setAttribute('aria-disabled',locked ? 'true' : 'false');

                if(clearBtn){
                    clearBtn.disabled=locked;
                    if(locked){
                        clearBtn.classList.add('hidden');
                    }else{
                        updateCountryClear();
                    }
                }

                if(dropdown && locked){
                    dropdown.classList.add('hidden');
                }

                var field=$('#plannerCountryField');
                if(field){
                    field.style.backgroundColor=locked ? '#F8FAFC' : '';
                }
            }

            function renderSavedPlans(){
                var list=$('#plannerSavedPlansList'); if(!list)return; list.innerHTML='';
                SAVED_PLANS.forEach(function(plan){
                    var card=document.createElement('div'); card.className='planner-saved-plan rounded-xl border border-gray-200 bg-white shadow-sm overflow-hidden';
                    card.dataset.country=plan.country||'';
                    card.dataset.search=(plan.title+' '+plan.country+' '+plan.region+' '+plan.daySchedules.map(function(d){return d.theme+' '+d.items.map(function(i){return i.name+' '+i.location}).join(' ')}).join(' ')).toLowerCase();
                    var head=document.createElement('div'); head.className='planner-saved-plan-head flex items-center gap-2.5 px-3 py-2.5 cursor-pointer hover:bg-gray-50 transition-colors select-none'; head.draggable=true;
                    var countryMark=plan.countryCode || (plan.country ? plan.country.substring(0,2) : '—');
                    head.innerHTML='<span class="text-gray-300 text-xs">⠿</span><div class="w-8 h-8 rounded-lg flex items-center justify-center text-white text-[10px] font-black shrink-0" style="background:'+plan.color+'">'+escapeImportHtml(countryMark)+'</div><div class="flex-1 min-w-0"><p class="text-xs font-bold text-gray-800 truncate">'+escapeImportHtml(plan.title)+'</p><p class="text-[10px] text-gray-400">'+escapeImportHtml(plan.country)+' · '+plan.nights+'박 '+plan.days+'일</p></div><span class="planner-plan-chevron text-gray-400 text-xs">⌄</span>';
                    var body=document.createElement('div'); body.className='planner-saved-plan-body hidden border-t border-gray-100';
                    plan.daySchedules.forEach(function(day){
                        var wrap=document.createElement('div'); wrap.className='border-b border-gray-50 last:border-0';
                        var row=document.createElement('div'); row.className='planner-saved-day flex items-center gap-2 px-3 py-2 cursor-pointer hover:bg-purple-50 select-none'; row.draggable=true;
                        row.innerHTML='<span class="text-gray-200 text-xs">⠿</span><span class="text-[10px] font-black text-white px-1.5 py-0.5 rounded" style="background:'+plan.color+'">D'+day.dayNum+'</span><span class="text-[11px] font-semibold text-gray-700 flex-1 truncate">'+escapeImportHtml(day.theme)+'</span><span class="text-[10px] text-gray-400">'+day.items.length+'개</span><span class="planner-day-chevron text-gray-400 text-xs">⌄</span>';
                        var items=document.createElement('div'); items.className='planner-saved-items hidden pl-6 pr-3 pb-2 flex flex-col gap-1';
                        day.items.forEach(function(item){
                            var cfg=TYPE_CONFIG[item.type]||TYPE_CONFIG.sightseeing; var ir=document.createElement('div'); ir.className='planner-saved-item flex items-center gap-2 px-2 py-1.5 rounded-lg cursor-grab hover:bg-gray-50 border select-none'; ir.draggable=true;
                            ir.innerHTML='<span class="text-gray-200 text-[10px]">⠿</span><span class="w-5 h-5 rounded flex items-center justify-center text-[9px] font-bold" style="background:'+cfg.bg+';color:'+cfg.color+'">'+cfg.label.substring(0,1)+'</span><span class="text-[11px] text-gray-700 flex-1 truncate font-medium">'+escapeImportHtml(item.name)+'</span><span class="text-[10px] text-gray-400">'+escapeImportHtml(item.time||'')+'</span>';
                            ir.addEventListener('dragstart',function(e){
                                e.stopPropagation();
                                dragPayload(e,{
                                    kind:'item',
                                    item:item,
                                    importMeta:importHeaderMeta(plan)
                                });
                            });
                            items.appendChild(ir);
                        });
                        row.addEventListener('click',function(){items.classList.toggle('hidden'); var c=$('.planner-day-chevron',row);if(c)c.textContent=items.classList.contains('hidden')?'⌄':'⌃';});
                        row.addEventListener('dragstart',function(e){
                            e.stopPropagation();
                            dragPayload(e,{
                                kind:'day',
                                day:day,
                                importMeta:importHeaderMeta(plan)
                            });
                        });
                        wrap.appendChild(row); wrap.appendChild(items); body.appendChild(wrap);
                    });
                    head.addEventListener('click',function(){body.classList.toggle('hidden'); var c=$('.planner-plan-chevron',head);if(c)c.textContent=body.classList.contains('hidden')?'⌄':'⌃';});
                    head.addEventListener('dragstart',function(e){
                        dragPayload(e,{
                            kind:'plan',
                            plan:plan,
                            importMeta:importHeaderMeta(plan)
                        });
                    });
                    card.appendChild(head); card.appendChild(body); list.appendChild(card);
                });
                if(SAVED_PLANS.length===0){
                    var empty=document.createElement('div');
                    empty.className='px-3 py-8 text-center text-xs text-gray-400';
                    empty.textContent='가져올 일정이 없습니다.';
                    list.appendChild(empty);
                }

                filterPlans();
            }
            function filterPlans(){
                var q=(search&&search.value||'').trim().toLowerCase();
                var countryInput=$('#plannerCountry');
                var matchedCountry=countryInput ? findPlannerCountry(countryInput.value) : null;
                var selectedCountry=matchedCountry ? matchedCountry.name : '';
                var visible=0;

                $$('.planner-saved-plan').forEach(function(card){
                    var searchOk=!q
                        || (card.dataset.search||card.textContent)
                            .toLowerCase()
                            .indexOf(q)>-1;

                    var countryOk=!selectedCountry
                        || (card.dataset.country||'')===selectedCountry;

                    var ok=searchOk && countryOk;

                    card.classList.toggle('is-hidden',!ok);

                    if(ok) visible++;
                });

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
                if(!galleryEl || galleryEl.dataset.photoReady==='1') return;
                galleryEl.dataset.photoReady='1';

                var previewImg=$('.planner-photo-preview-img',galleryEl);
                var previewEmpty=$('.planner-photo-empty',galleryEl);
                var thumbs=$$('.planner-photo-thumb',galleryEl);
                var fileInput=$('.planner-photo-file-input',galleryEl);
                var dragIndex=null;
                var didDrag=false;

                if(!fileInput){
                    fileInput=document.createElement('input');
                    fileInput.type='file';
                    fileInput.accept='image/*';
                    fileInput.className='planner-photo-file-input hidden';
                    galleryEl.appendChild(fileInput);
                }

                function getSrc(t){
                    return String(t && t.dataset.src ? t.dataset.src : '').trim();
                }

                function updateThumbState(t){
                    var src=getSrc(t);
                    var img=$('img',t);
                    var label=$('.planner-photo-hover-label',t);

                    if(src){
                        t.classList.add('has-image');
                        t.classList.remove('is-empty');

                        if(!img){
                            img=document.createElement('img');
                            img.alt='블록 이미지';
                            t.insertBefore(img,t.firstChild);
                        }

                        img.src=src;

                        if(label) label.textContent='이미지 변경하기';
                    }else{
                        t.classList.remove('has-image');
                        t.classList.add('is-empty');

                        if(img) img.remove();

                        if(label) label.textContent='이미지 등록하기';
                    }
                }

                function renderBadge(){
                    thumbs.forEach(function(t,i){
                        t.dataset.index=i;

                        var badge=$('.planner-photo-badge',t);

                        // 현재 첫 번째 위치의 이미지가 항상 대표
                        if(i===0 && getSrc(t)){
                            if(!badge){
                                badge=document.createElement('span');
                                badge.className='planner-photo-badge';
                                badge.textContent='대표';
                                t.appendChild(badge);
                            }
                        }else if(badge){
                            badge.remove();
                        }

                        updateThumbState(t);
                    });
                }

                function active(t){
                    thumbs.forEach(function(x){
                        x.classList.toggle('active',x===t && !!getSrc(x));
                    });

                    var src=getSrc(t);

                    if(previewImg){
                        if(src){
                            previewImg.src=src;
                            previewImg.style.display='block';
                        }else{
                            previewImg.removeAttribute('src');
                            previewImg.style.display='none';
                        }
                    }

                    if(previewEmpty){
                        previewEmpty.style.display=src ? 'none' : 'flex';
                    }
                }

                function openPicker(t){
                    if(!t || !fileInput) return;

                    fileInput.dataset.targetIndex=t.dataset.index;
                    fileInput.value='';
                    fileInput.click();
                }

                function swap(a,b){
                    if(a==null || b==null || a===b) return;

                    var x=thumbs[a];
                    var y=thumbs[b];

                    if(!x || !y) return;

                    var xSrc=getSrc(x);
                    var ySrc=getSrc(y);
                    var xFile=x._plannerFile || null;
                    var yFile=y._plannerFile || null;

                    /*
                     * blob URL도 이미지 자체의 상태이므로
                     * src / File과 함께 반드시 자리 이동해야 한다.
                     *
                     * 기존에는 objectUrl이 원래 칸에 남아 있어서
                     * 이동 후 한 이미지를 삭제하면 다른 칸으로 이동한
                     * 이미지의 URL까지 revoke되는 문제가 있었다.
                     */
                    var xObjectUrl=x.dataset.objectUrl || '';
                    var yObjectUrl=y.dataset.objectUrl || '';

                    var activeThumb=$('.planner-photo-thumb.active',galleryEl);
                    var activeIndex=activeThumb ? Number(activeThumb.dataset.index) : null;

                    x.dataset.src=ySrc;
                    y.dataset.src=xSrc;

                    x._plannerFile=yFile;
                    y._plannerFile=xFile;

                    x.dataset.objectUrl=yObjectUrl;
                    y.dataset.objectUrl=xObjectUrl;

                    renderBadge();

                    if(activeIndex===a){
                        active(y);
                    }else if(activeIndex===b){
                        active(x);
                    }else{
                        var firstWithImage=thumbs.find(function(t){ return !!getSrc(t); });
                        active(firstWithImage || null);
                    }

                    markDirty();
                }

                fileInput.addEventListener('change',function(){
                    var index=Number(fileInput.dataset.targetIndex);
                    var target=thumbs[index];
                    var file=fileInput.files && fileInput.files[0];

                    if(!target || !file) return;

                    if(file.type && file.type.indexOf('image/')!==0){
                        if(typeof toast==='function') toast('이미지 파일만 등록할 수 있습니다.');
                        return;
                    }

                    if(target.dataset.objectUrl){
                        try{
                            URL.revokeObjectURL(target.dataset.objectUrl);
                        }catch(e){}
                    }

                    var objectUrl=URL.createObjectURL(file);

                    target.dataset.objectUrl=objectUrl;
                    target.dataset.src=objectUrl;
                    target._plannerFile=file;

                    renderBadge();
                    active(target);
                    markDirty();
                });

                thumbs.forEach(function(t,i){
                    t.dataset.index=i;

                    t.addEventListener('mouseenter',function(){
                        if(getSrc(t)){
                            active(t);
                        }
                    });

                    var deleteBtn=$('.planner-photo-delete',t);

                    if(deleteBtn){
                        function removeThumbImage(e){
                            if(e){
                                e.preventDefault();
                                e.stopPropagation();
                            }

                            if(!getSrc(t)) return;

                            if(t.dataset.objectUrl){
                                try{
                                    URL.revokeObjectURL(t.dataset.objectUrl);
                                }catch(err){}
                            }

                            t.dataset.objectUrl='';
                            t.dataset.src='';
                            t._plannerFile=null;

                            updateThumbState(t);
                            renderBadge();

                            var nextWithImage=thumbs.find(function(x){
                                return !!getSrc(x);
                            });

                            active(nextWithImage || null);
                            markDirty();
                        }

                        deleteBtn.addEventListener('click',removeThumbImage);
                        deleteBtn.addEventListener('keydown',function(e){
                            if(e.key==='Enter' || e.key===' '){
                                removeThumbImage(e);
                            }
                        });
                    }

                    t.addEventListener('click',function(e){
                        e.preventDefault();

                        if(didDrag){
                            didDrag=false;
                            return;
                        }

                        active(t);
                        openPicker(t);
                    });

                    t.addEventListener('dragstart',function(e){
                        dragIndex=Number(t.dataset.index);
                        didDrag=true;
                        t.classList.add('dragging');
                        e.dataTransfer.effectAllowed='move';
                    });

                    t.addEventListener('dragend',function(){
                        dragIndex=null;

                        thumbs.forEach(function(x){
                            x.classList.remove('dragging','drag-over');
                        });

                        setTimeout(function(){
                            didDrag=false;
                        },0);
                    });

                    t.addEventListener('dragover',function(e){
                        e.preventDefault();
                        t.classList.add('drag-over');
                    });

                    t.addEventListener('dragleave',function(){
                        t.classList.remove('drag-over');
                    });

                    t.addEventListener('drop',function(e){
                        e.preventDefault();
                        t.classList.remove('drag-over');
                        swap(dragIndex,Number(t.dataset.index));
                    });
                });

                renderBadge();

                var firstWithImage=thumbs.find(function(t){
                    return !!getSrc(t);
                });

                active(firstWithImage || null);
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
                card.dataset.sourceBlockId=prefill.sourceBlockId||'';
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
                updateDayDeleteButtons();
                syncBudget();
                syncCountryEditLock();
                markDirty();
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
                updateDayDeleteButtons();
                body.addEventListener('drop',function(e){
                    var raw=e.dataTransfer.getData('application/x-tripily-import');
                    if(!raw)return; e.preventDefault(); body.classList.remove('is-drop-target');
                    try{
                        var d=JSON.parse(raw);

                        /*
                         * 첫 가져오기라면 원본 일정 기준으로
                         * 국가 / 지역 / 인원을 먼저 채운다.
                         */
                        applyImportHeaderDefaults(d);

                        var startIndex=$$('.planner-day').indexOf(day);
                        if(d.kind==='item'){
                            addBlockToDay(day,{sourceBlockId:d.item.sourceBlockId||null,title:d.item.name,type:d.item.type,startTime:d.item.time||'',endTime:d.item.endTime||'',cost:d.item.cost||'',place:d.item.location||'',note:d.item.note||''});
                            toast('일정 블록 1개를 가져왔습니다.');
                        } else if(d.kind==='day'){
                            (d.day.items||[]).forEach(function(item){addBlockToDay(day,{sourceBlockId:item.sourceBlockId||null,title:item.name,type:item.type,startTime:item.time||'',endTime:item.endTime||'',cost:item.cost||'',place:item.location||'',note:item.note||''});});
                            toast('D'+d.day.dayNum+' 일정을 가져왔습니다.');
                        } else if(d.kind==='plan'){
                            var schedules=d.plan.daySchedules||[];
                            var needed=Math.max(1,schedules.length);
                            while($$('.planner-day').length < startIndex + needed){ $('#plannerAddDay').click(); }
                            var targets=$$('.planner-day');
                            schedules.forEach(function(ds,di){(ds.items||[]).forEach(function(item){addBlockToDay(targets[startIndex+di],{sourceBlockId:item.sourceBlockId||null,title:item.name,type:item.type,startTime:item.time||'',endTime:item.endTime||'',cost:item.cost||'',place:item.location||'',note:item.note||''});});});
                            toast('Day '+(startIndex+1)+'부터 '+needed+'개 Day를 가져왔습니다.');
                        }
                    }catch(err){
                        console.error(err);
                    }finally{
                        finishImportDrag();
                    }
                });
            }


            var plannerDeleteAction=null;
            function openDeleteModal(options,onDelete){
                setupDeleteModal();
                options=options||{};
                var backdrop=$('#plannerConfirmBackdrop');
                var titleEl=$('#plannerConfirmTitle');
                var msgEl=$('#plannerConfirmMessage');
                var warningEl=$('#plannerConfirmWarning');
                var listEl=$('#plannerConfirmList');
                if(!backdrop){
                    if(window.confirm(options.message||options.title||'삭제하시겠습니까?')) onDelete();
                    return;
                }

                plannerDeleteAction=onDelete;
                if(titleEl) titleEl.textContent=options.title||'삭제';

                if(msgEl){
                    msgEl.innerHTML='';
                    if(options.itemName){
                        var strong=document.createElement('strong');
                        strong.textContent='"'+options.itemName+'"';
                        msgEl.appendChild(strong);
                        msgEl.appendChild(document.createTextNode(' 일정을 삭제할까요?'));
                    }else{
                        msgEl.textContent=options.message||'삭제할까요?';
                    }
                }

                if(listEl){
                    listEl.innerHTML='';
                    var items=options.items||[];
                    listEl.classList.toggle('is-visible',items.length>0);
                    items.forEach(function(item){
                        var row=document.createElement('div');
                        row.className='planner-confirm-list-item';

                        var dot=document.createElement('span');
                        dot.className='planner-confirm-list-dot';

                        var name=document.createElement('span');
                        name.className='planner-confirm-list-name';
                        name.textContent=item.name||'제목 없음';

                        row.appendChild(dot);
                        row.appendChild(name);

                        if(item.time){
                            var time=document.createElement('span');
                            time.className='planner-confirm-list-time';
                            time.textContent=item.time;
                            row.appendChild(time);
                        }
                        listEl.appendChild(row);
                    });
                }

                if(warningEl) warningEl.textContent='삭제 후 되돌릴 수 없습니다.';

                backdrop.classList.add('is-open');
                backdrop.setAttribute('aria-hidden','false');
                var cancel=$('#plannerConfirmCancel');
                if(cancel) cancel.focus();
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
                if(del) del.addEventListener('click',function(e){
                    e.stopPropagation();
                    var blockName=(label&&label.textContent?label.textContent.trim():'') || (title&&title.value?title.value.trim():'') || '제목 없음';
                    openDeleteModal({
                        title:'일정 삭제',
                        itemName:blockName
                    },function(){
                        card.remove();
                        updateDayDeleteButtons();
                        syncBudget();
                        markDirty();
                    });
                });
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

            function updateDayDeleteButtons(){
                var days=$$('.planner-day');
                days.forEach(function(day){
                    var del=$('.planner-day-delete',day);
                    if(!del) return;
                    var blockCount=$$('.planner-block-card,.planner-block-summary',day).length;
                    var hidden=(days.length===1 && blockCount===0);
                    del.style.display=hidden?'none':'';
                    del.disabled=hidden;
                    del.style.pointerEvents=hidden?'none':'';
                    del.setAttribute('aria-hidden',hidden?'true':'false');
                });
            }

            function renumberDays(){
                $$('.planner-day').forEach(function(day,i){
                    var oldNo=Number(day.dataset.dayNumber||i+1);
                    var newNo=i+1;
                    day.dataset.dayNumber=newNo;
                    day.dataset.dayOrder=newNo;
                    var circle=day.querySelector('.planner-day-header > div:first-child');
                    if(circle) circle.textContent='D'+newNo;
                });
                updateAddDayButton(); rebuildMapFilter(); updateDayDeleteButtons();
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

            var draggedPlannerDay=null;

            function clearDayDragState(){
                $$('.planner-day').forEach(function(d){
                    d.classList.remove('is-day-dragging','is-day-drag-over');
                });
            }

            function setupDay(day){
                if(day.dataset.dayReady==='1') return; day.dataset.dayReady='1';
                var h=$('.planner-day-header',day), b=$('.planner-day-body',day), del=$('.planner-day-delete',day);
                if(h){
                    h.setAttribute('draggable','true');
                    h.title=h.title||'드래그하여 DAY 순서 변경';

                    h.addEventListener('dragstart',function(e){
                        if(e.target.closest('.planner-day-delete') ||
                           e.target.closest('.planner-day-title') ||
                           e.target.closest('.planner-day-edit-icon') ||
                           e.target.closest('input,button,a,textarea,select')){
                            e.preventDefault();
                            return;
                        }
                        draggedPlannerDay=day;
                        day.classList.add('is-day-dragging');
                        if(e.dataTransfer){
                            e.dataTransfer.effectAllowed='move';
                            e.dataTransfer.setData('text/plain','planner-day');
                        }
                    });

                    h.addEventListener('dragend',function(){
                        draggedPlannerDay=null;
                        clearDayDragState();
                        renumberDays();
                        markDirty();
                    });

                    day.addEventListener('dragover',function(e){
                        if(!draggedPlannerDay || draggedPlannerDay===day) return;
                        e.preventDefault();
                        if(e.dataTransfer) e.dataTransfer.dropEffect='move';

                        $$('.planner-day').forEach(function(d){d.classList.remove('is-day-drag-over');});
                        day.classList.add('is-day-drag-over');

                        var rect=day.getBoundingClientRect();
                        var before=e.clientY < rect.top + rect.height/2;
                        var parent=day.parentNode;
                        if(before){
                            if(draggedPlannerDay!==day.previousElementSibling){
                                parent.insertBefore(draggedPlannerDay,day);
                                renumberDays();
                            }
                        }else{
                            var next=day.nextElementSibling;
                            if(next!==draggedPlannerDay){
                                parent.insertBefore(draggedPlannerDay,next);
                                renumberDays();
                            }
                        }
                    });

                    day.addEventListener('drop',function(e){
                        if(!draggedPlannerDay) return;
                        e.preventDefault();
                        clearDayDragState();
                        draggedPlannerDay=null;
                        renumberDays();
                        markDirty();
                    });
                }
                if(h&&b) h.addEventListener('click',function(e){ if(e.target.closest('.planner-day-delete') || e.target.closest('.planner-day-title') || e.target.closest('.planner-day-edit-icon'))return; b.classList.toggle('is-collapsed'); });
                enableDayTitleEdit(day);
                if(del) del.addEventListener('click',function(e){
                    e.stopPropagation();
                    var days=$$('.planner-day');
                    var currentBlockCount=$$('.planner-block-card,.planner-block-summary',day).length;
                    if(days.length===1 && currentBlockCount===0) return;
                    var dayNo=day.dataset.dayNumber||'';
                    var childItems=$$('.planner-block-card',day).map(function(card){
                        var nameEl=$('.planner-block-title-label',card);
                        var timeEl=$('.planner-item-start-time',card);
                        return {
                            name:(nameEl&&nameEl.textContent?nameEl.textContent.trim():'') || '제목 없음',
                            time:(timeEl&&timeEl.value?timeEl.value:'')
                        };
                    });
                    openDeleteModal({
                        title:'Day '+dayNo+' 삭제',
                        message:childItems.length>0
                            ? '하위 일정 '+childItems.length+'개도 함께 삭제됩니다.'
                            : (days.length<=1 ? '마지막 DAY의 일정 블록을 모두 삭제할까요?' : '이 날 블록을 삭제할까요?'),
                        items:childItems
                    }, function(){
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

            var PLANNER_COUNTRIES=[{"code": "GH", "name": "가나"}, {"code": "GA", "name": "가봉"}, {"code": "GY", "name": "가이아나"}, {"code": "GM", "name": "감비아"}, {"code": "GG", "name": "건지"}, {"code": "GP", "name": "과들루프"}, {"code": "GT", "name": "과테말라"}, {"code": "GU", "name": "괌"}, {"code": "GD", "name": "그레나다"}, {"code": "GR", "name": "그리스"}, {"code": "GL", "name": "그린란드"}, {"code": "GN", "name": "기니"}, {"code": "GW", "name": "기니비사우"}, {"code": "NA", "name": "나미비아"}, {"code": "NR", "name": "나우루"}, {"code": "NG", "name": "나이지리아"}, {"code": "AQ", "name": "남극 대륙"}, {"code": "SS", "name": "남수단"}, {"code": "ZA", "name": "남아프리카"}, {"code": "NL", "name": "네덜란드"}, {"code": "BQ", "name": "네덜란드령 카리브"}, {"code": "NP", "name": "네팔"}, {"code": "NO", "name": "노르웨이"}, {"code": "NF", "name": "노퍽섬"}, {"code": "NZ", "name": "뉴질랜드"}, {"code": "NC", "name": "뉴칼레도니아"}, {"code": "NU", "name": "니우에"}, {"code": "NE", "name": "니제르"}, {"code": "NI", "name": "니카라과"}, {"code": "TW", "name": "대만"}, {"code": "KR", "name": "대한민국"}, {"code": "DK", "name": "덴마크"}, {"code": "DM", "name": "도미니카"}, {"code": "DO", "name": "도미니카 공화국"}, {"code": "DE", "name": "독일"}, {"code": "TL", "name": "동티모르"}, {"code": "LA", "name": "라오스"}, {"code": "LR", "name": "라이베리아"}, {"code": "LV", "name": "라트비아"}, {"code": "RU", "name": "러시아"}, {"code": "LB", "name": "레바논"}, {"code": "LS", "name": "레소토"}, {"code": "RE", "name": "레위니옹"}, {"code": "RO", "name": "루마니아"}, {"code": "LU", "name": "룩셈부르크"}, {"code": "RW", "name": "르완다"}, {"code": "LY", "name": "리비아"}, {"code": "LT", "name": "리투아니아"}, {"code": "LI", "name": "리히텐슈타인"}, {"code": "MG", "name": "마다가스카르"}, {"code": "MQ", "name": "마르티니크"}, {"code": "MH", "name": "마셜 제도"}, {"code": "YT", "name": "마요트"}, {"code": "MO", "name": "마카오(중국 특별행정구)"}, {"code": "MW", "name": "말라위"}, {"code": "MY", "name": "말레이시아"}, {"code": "ML", "name": "말리"}, {"code": "IM", "name": "맨섬"}, {"code": "MX", "name": "멕시코"}, {"code": "MC", "name": "모나코"}, {"code": "MA", "name": "모로코"}, {"code": "MU", "name": "모리셔스"}, {"code": "MR", "name": "모리타니"}, {"code": "MZ", "name": "모잠비크"}, {"code": "ME", "name": "몬테네그로"}, {"code": "MS", "name": "몬트세라트"}, {"code": "MD", "name": "몰도바"}, {"code": "MV", "name": "몰디브"}, {"code": "MT", "name": "몰타"}, {"code": "MN", "name": "몽골"}, {"code": "US", "name": "미국"}, {"code": "VI", "name": "미국령 버진아일랜드"}, {"code": "UM", "name": "미국령 해외 제도"}, {"code": "MM", "name": "미얀마"}, {"code": "FM", "name": "미크로네시아"}, {"code": "VU", "name": "바누아투"}, {"code": "BH", "name": "바레인"}, {"code": "BB", "name": "바베이도스"}, {"code": "VA", "name": "바티칸 시국"}, {"code": "BS", "name": "바하마"}, {"code": "BD", "name": "방글라데시"}, {"code": "BM", "name": "버뮤다"}, {"code": "BJ", "name": "베냉"}, {"code": "VE", "name": "베네수엘라"}, {"code": "VN", "name": "베트남"}, {"code": "BE", "name": "벨기에"}, {"code": "BY", "name": "벨라루스"}, {"code": "BZ", "name": "벨리즈"}, {"code": "BA", "name": "보스니아 헤르체고비나"}, {"code": "BW", "name": "보츠와나"}, {"code": "BO", "name": "볼리비아"}, {"code": "BI", "name": "부룬디"}, {"code": "BF", "name": "부르키나파소"}, {"code": "BV", "name": "부베섬"}, {"code": "BT", "name": "부탄"}, {"code": "MP", "name": "북마리아나제도"}, {"code": "MK", "name": "북마케도니아"}, {"code": "KP", "name": "북한"}, {"code": "BG", "name": "불가리아"}, {"code": "BR", "name": "브라질"}, {"code": "BN", "name": "브루나이"}, {"code": "WS", "name": "사모아"}, {"code": "SA", "name": "사우디아라비아"}, {"code": "GS", "name": "사우스조지아 사우스샌드위치 제도"}, {"code": "SM", "name": "산마리노"}, {"code": "ST", "name": "상투메 프린시페"}, {"code": "MF", "name": "생마르탱"}, {"code": "BL", "name": "생바르텔레미"}, {"code": "PM", "name": "생피에르 미클롱"}, {"code": "EH", "name": "서사하라"}, {"code": "SN", "name": "세네갈"}, {"code": "RS", "name": "세르비아"}, {"code": "SC", "name": "세이셸"}, {"code": "LC", "name": "세인트루시아"}, {"code": "VC", "name": "세인트빈센트그레나딘"}, {"code": "KN", "name": "세인트키츠 네비스"}, {"code": "SH", "name": "세인트헬레나"}, {"code": "SO", "name": "소말리아"}, {"code": "SB", "name": "솔로몬 제도"}, {"code": "SD", "name": "수단"}, {"code": "SR", "name": "수리남"}, {"code": "LK", "name": "스리랑카"}, {"code": "SJ", "name": "스발바르제도-얀마웬섬"}, {"code": "SE", "name": "스웨덴"}, {"code": "CH", "name": "스위스"}, {"code": "ES", "name": "스페인"}, {"code": "SK", "name": "슬로바키아"}, {"code": "SI", "name": "슬로베니아"}, {"code": "SY", "name": "시리아"}, {"code": "SL", "name": "시에라리온"}, {"code": "SX", "name": "신트마르턴"}, {"code": "SG", "name": "싱가포르"}, {"code": "AE", "name": "아랍에미리트"}, {"code": "AW", "name": "아루바"}, {"code": "AM", "name": "아르메니아"}, {"code": "AR", "name": "아르헨티나"}, {"code": "AS", "name": "아메리칸 사모아"}, {"code": "IS", "name": "아이슬란드"}, {"code": "HT", "name": "아이티"}, {"code": "IE", "name": "아일랜드"}, {"code": "AZ", "name": "아제르바이잔"}, {"code": "AF", "name": "아프가니스탄"}, {"code": "AD", "name": "안도라"}, {"code": "AL", "name": "알바니아"}, {"code": "DZ", "name": "알제리"}, {"code": "AO", "name": "앙골라"}, {"code": "AG", "name": "앤티가 바부다"}, {"code": "AI", "name": "앵귈라"}, {"code": "ER", "name": "에리트리아"}, {"code": "SZ", "name": "에스와티니"}, {"code": "EE", "name": "에스토니아"}, {"code": "EC", "name": "에콰도르"}, {"code": "ET", "name": "에티오피아"}, {"code": "SV", "name": "엘살바도르"}, {"code": "GB", "name": "영국"}, {"code": "VG", "name": "영국령 버진아일랜드"}, {"code": "IO", "name": "영국령 인도양 지역"}, {"code": "YE", "name": "예멘"}, {"code": "OM", "name": "오만"}, {"code": "AU", "name": "오스트레일리아"}, {"code": "AT", "name": "오스트리아"}, {"code": "HN", "name": "온두라스"}, {"code": "AX", "name": "올란드 제도"}, {"code": "WF", "name": "왈리스-푸투나 제도"}, {"code": "JO", "name": "요르단"}, {"code": "UG", "name": "우간다"}, {"code": "UY", "name": "우루과이"}, {"code": "UZ", "name": "우즈베키스탄"}, {"code": "UA", "name": "우크라이나"}, {"code": "IQ", "name": "이라크"}, {"code": "IR", "name": "이란"}, {"code": "IL", "name": "이스라엘"}, {"code": "EG", "name": "이집트"}, {"code": "IT", "name": "이탈리아"}, {"code": "IN", "name": "인도"}, {"code": "ID", "name": "인도네시아"}, {"code": "JP", "name": "일본"}, {"code": "JM", "name": "자메이카"}, {"code": "ZM", "name": "잠비아"}, {"code": "JE", "name": "저지"}, {"code": "GQ", "name": "적도 기니"}, {"code": "GE", "name": "조지아"}, {"code": "CN", "name": "중국"}, {"code": "CF", "name": "중앙 아프리카 공화국"}, {"code": "DJ", "name": "지부티"}, {"code": "GI", "name": "지브롤터"}, {"code": "ZW", "name": "짐바브웨"}, {"code": "TD", "name": "차드"}, {"code": "CZ", "name": "체코"}, {"code": "CL", "name": "칠레"}, {"code": "CM", "name": "카메룬"}, {"code": "CV", "name": "카보베르데"}, {"code": "KZ", "name": "카자흐스탄"}, {"code": "QA", "name": "카타르"}, {"code": "KH", "name": "캄보디아"}, {"code": "CA", "name": "캐나다"}, {"code": "KE", "name": "케냐"}, {"code": "KY", "name": "케이맨 제도"}, {"code": "KM", "name": "코모로"}, {"code": "CR", "name": "코스타리카"}, {"code": "CC", "name": "코코스 제도"}, {"code": "CI", "name": "코트디부아르"}, {"code": "CO", "name": "콜롬비아"}, {"code": "CG", "name": "콩고-브라자빌"}, {"code": "CD", "name": "콩고-킨샤사"}, {"code": "CU", "name": "쿠바"}, {"code": "KW", "name": "쿠웨이트"}, {"code": "CK", "name": "쿡 제도"}, {"code": "CW", "name": "퀴라소"}, {"code": "HR", "name": "크로아티아"}, {"code": "CX", "name": "크리스마스섬"}, {"code": "KG", "name": "키르기스스탄"}, {"code": "KI", "name": "키리바시"}, {"code": "CY", "name": "키프로스"}, {"code": "TJ", "name": "타지키스탄"}, {"code": "TZ", "name": "탄자니아"}, {"code": "TH", "name": "태국"}, {"code": "TC", "name": "터크스 케이커스 제도"}, {"code": "TG", "name": "토고"}, {"code": "TK", "name": "토켈라우"}, {"code": "TO", "name": "통가"}, {"code": "TM", "name": "투르크메니스탄"}, {"code": "TV", "name": "투발루"}, {"code": "TN", "name": "튀니지"}, {"code": "TR", "name": "튀르키예"}, {"code": "TT", "name": "트리니다드 토바고"}, {"code": "PA", "name": "파나마"}, {"code": "PY", "name": "파라과이"}, {"code": "PK", "name": "파키스탄"}, {"code": "PG", "name": "파푸아뉴기니"}, {"code": "PW", "name": "팔라우"}, {"code": "PS", "name": "팔레스타인 지구"}, {"code": "FO", "name": "페로 제도"}, {"code": "PE", "name": "페루"}, {"code": "PT", "name": "포르투갈"}, {"code": "FK", "name": "포클랜드 제도"}, {"code": "PL", "name": "폴란드"}, {"code": "PR", "name": "푸에르토리코"}, {"code": "FR", "name": "프랑스"}, {"code": "GF", "name": "프랑스령 기아나"}, {"code": "TF", "name": "프랑스령 남방 지역"}, {"code": "PF", "name": "프랑스령 폴리네시아"}, {"code": "FJ", "name": "피지"}, {"code": "FI", "name": "핀란드"}, {"code": "PH", "name": "필리핀"}, {"code": "PN", "name": "핏케언 제도"}, {"code": "HM", "name": "허드 맥도널드 제도"}, {"code": "HU", "name": "헝가리"}, {"code": "HK", "name": "홍콩(중국 특별행정구)"}];
            var PLANNER_REGION_MAP={"대한민국": ["서울", "부산", "인천", "대구", "대전", "광주", "울산", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"], "일본": ["도쿄", "오사카", "교토", "후쿠오카", "삿포로", "나고야", "오키나와", "나라", "고베", "요코하마"], "중국": ["베이징", "상하이", "광저우", "선전", "칭다오", "청두", "시안", "항저우"], "대만": ["타이베이", "가오슝", "타이중", "타이난", "화롄"], "태국": ["방콕", "치앙마이", "푸껫", "파타야", "끄라비"], "베트남": ["하노이", "호찌민", "다낭", "나트랑", "호이안", "푸꾸옥"], "미국": ["뉴욕", "로스앤젤레스", "샌프란시스코", "라스베이거스", "시애틀", "시카고", "보스턴", "하와이"], "프랑스": ["파리", "니스", "리옹", "마르세유", "보르도"], "이탈리아": ["로마", "밀라노", "피렌체", "베네치아", "나폴리"], "스페인": ["마드리드", "바르셀로나", "세비야", "발렌시아"], "영국": ["런던", "에든버러", "맨체스터", "리버풀"], "독일": ["베를린", "뮌헨", "프랑크푸르트", "함부르크"], "싱가포르": ["싱가포르"], "말레이시아": ["쿠알라룸푸르", "코타키나발루", "페낭", "말라카"], "인도네시아": ["발리", "자카르타", "욕야카르타", "롬복"], "필리핀": ["마닐라", "세부", "보라카이", "보홀"], "호주": ["시드니", "멜버른", "브리즈번", "골드코스트", "퍼스"], "캐나다": ["밴쿠버", "토론토", "몬트리올", "퀘벡"]};

            function normalizePlannerText(v){ return String(v||'').trim(); }
            function findPlannerCountry(name){
                var n=normalizePlannerText(name);

                if(!Array.isArray(PLANNER_COUNTRIES)){
                    return null;
                }

                return PLANNER_COUNTRIES.find(function(c){
                    return c.name===n;
                }) || null;
            }
            function refreshCountryStatus(){
                var input=$('#plannerCountry');
                var field=$('#plannerCountryField');
                var status=$('#plannerCountryStatus');
                if(!input || !field || !status) return false;

                var value=normalizePlannerText(input.value);
                var matched=findPlannerCountry(value);

                if(!value){
                    status.textContent='필수';
                    field.style.borderColor='#FCA5A5';
                }else if(!matched){
                    status.textContent='일치하는 국가가 없습니다';
                    field.style.borderColor='#FCA5A5';
                }else{
                    status.textContent='';
                    field.style.borderColor='#E2E5EF';
                }
                return !!matched;
            }
            function searchPlannerCountries(value){
                var q=normalizePlannerText(value);
                var qLower=q.toLowerCase();

                if(!q) return PLANNER_COUNTRIES;

                return PLANNER_COUNTRIES
                    .map(function(c){
                        var name=c.name||'';
                        var nameLower=name.toLowerCase();
                        var codeLower=(c.code||'').toLowerCase();
                        var rank=99;

                        if(nameLower===qLower || codeLower===qLower){
                            rank=0; // 완전 일치
                        }else if(nameLower.indexOf(qLower)===0 || codeLower.indexOf(qLower)===0){
                            rank=1; // 입력값으로 시작
                        }else if(nameLower.indexOf(qLower)!==-1 || codeLower.indexOf(qLower)!==-1){
                            rank=2; // 중간 포함
                        }

                        return { country:c, rank:rank };
                    })
                    .filter(function(item){ return item.rank<99; })
                    .sort(function(a,b){
                        if(a.rank!==b.rank) return a.rank-b.rank;

                        var aName=a.country.name||'';
                        var bName=b.country.name||'';

                        // 같은 우선순위에서는 짧고 직접적인 이름을 먼저
                        if(aName.length!==bName.length) return aName.length-bName.length;
                        return aName.localeCompare(bName,'ko');
                    })
                    .slice(0,8)
                    .map(function(item){ return item.country; });
            }
            function closePlannerDropdowns(exceptId){
                ['plannerCountryDropdown','plannerRegionDropdown'].forEach(function(id){
                    if(id===exceptId) return;
                    var el=document.getElementById(id);
                    if(el) el.classList.add('hidden');
                });
            }
            function renderCountryDropdown(){
                var input=$('#plannerCountry');
                var dropdown=$('#plannerCountryDropdown');
                if(!input || !dropdown) return;

                var suggestions=searchPlannerCountries(input.value);
                dropdown.innerHTML='';

                suggestions.forEach(function(c){
                    var btn=document.createElement('button');
                    btn.type='button';
                    btn.className='flex items-center gap-2 px-3 py-2.5 text-sm min-w-0 whitespace-nowrap';

                    var code=document.createElement('span');
                    code.className='text-[11px] font-semibold text-gray-500 w-6 shrink-0';
                    code.textContent=c.code;

                    var name=document.createElement('span');
                    name.className='font-medium text-gray-800 min-w-0 whitespace-nowrap';
                    name.textContent=c.name;

                    btn.appendChild(code);
                    btn.appendChild(name);

                    btn.addEventListener('mousedown',function(e){
                        e.preventDefault();
                        input.value=c.name;
                        dropdown.classList.add('hidden');
                        refreshCountryStatus();
                        refreshRegionOptions(true);
                        syncCountryLock();
                        updateCountryClear();
                        filterPlans();
                        markDirty();
                    });

                    dropdown.appendChild(btn);
                });

                dropdown.classList.toggle('hidden',suggestions.length===0);
            }
            function updateCountryClear(){
                var input=$('#plannerCountry');
                var btn=$('#plannerCountryClear');
                if(btn) btn.classList.toggle('hidden',!(input && input.value));
            }
            function updateRegionClear(){
                var input=$('#plannerRegion');
                var btn=$('#plannerRegionClear');
                if(btn) btn.classList.toggle('hidden',!(input && input.value));
            }
            function refreshRegionOptions(clearValue){
                var country=$('#plannerCountry');
                var region=$('#plannerRegion');
                var dropdown=$('#plannerRegionDropdown');
                if(!country || !region || !dropdown) return;

                var matched=findPlannerCountry(country.value);
                dropdown.innerHTML='';

                if(clearValue) region.value='';

                if(!matched){
                    region.disabled=true;
                    region.placeholder='국가 먼저 입력';
                    region.value='';
                    dropdown.classList.add('hidden');
                    updateRegionClear();
                    return;
                }

                var options=PLANNER_REGION_MAP[matched.name]||[];
                region.disabled=options.length===0;
                region.placeholder=options.length ? '선택' : '지역 정보 없음';

                if(!options.length){
                    dropdown.classList.add('hidden');
                    updateRegionClear();
                    return;
                }

                renderRegionDropdown();
                dropdown.classList.add('hidden');
                updateRegionClear();
            }
            function renderRegionDropdown(){
                var country=$('#plannerCountry');
                var region=$('#plannerRegion');
                var dropdown=$('#plannerRegionDropdown');
                if(!country || !region || !dropdown) return;

                var matched=findPlannerCountry(country.value);
                var options=matched ? (PLANNER_REGION_MAP[matched.name]||[]) : [];
                var q=normalizePlannerText(region.value);
                var filtered=options.filter(function(r){ return !q || r.indexOf(q)!==-1; });

                dropdown.innerHTML='';
                filtered.forEach(function(r){
                    var btn=document.createElement('button');
                    btn.type='button';
                    btn.className='px-3 py-2 text-sm font-medium text-gray-800';
                    btn.textContent=r;
                    btn.addEventListener('mousedown',function(e){
                        e.preventDefault();
                        region.value=r;
                        dropdown.classList.add('hidden');
                        updateRegionClear();
                        markDirty();
                    });
                    dropdown.appendChild(btn);
                });
                dropdown.classList.toggle('hidden',filtered.length===0);
            }

            function showRequiredFieldsModal(items){
                var backdrop=$('#plannerRequiredBackdrop');
                var list=$('#plannerRequiredList');
                if(!backdrop || !list) return;
                list.innerHTML='';
                items.forEach(function(item){
                    var li=document.createElement('li');
                    li.textContent=item;
                    list.appendChild(li);
                });
                backdrop.classList.add('is-open');
                backdrop.setAttribute('aria-hidden','false');
                var close=$('#plannerRequiredClose');
                if(close) close.focus();
            }
            function closeRequiredFieldsModal(){
                var backdrop=$('#plannerRequiredBackdrop');
                if(!backdrop) return;
                backdrop.classList.remove('is-open');
                backdrop.setAttribute('aria-hidden','true');
            }
            function validatePlannerRequiredFields(){
                var missing=[];
                var title=$('#tripTitle');
                var country=$('#plannerCountry');

                if(!title || !normalizePlannerText(title.value)) missing.push('여행 제목');

                if(!country || !normalizePlannerText(country.value)){
                    missing.push('국가');
                    refreshCountryStatus();
                }else if(!findPlannerCountry(country.value)){
                    missing.push('일치하는 국가 선택');
                    refreshCountryStatus();
                }

                if(missing.length){
                    showRequiredFieldsModal(missing);
                    return false;
                }
                return true;
            }

            var plannerCountryInput=$('#plannerCountry');
            var plannerCountryClear=$('#plannerCountryClear');
            var plannerCountryDropdown=$('#plannerCountryDropdown');
            var plannerRegionInput=$('#plannerRegion');
            var plannerRegionClear=$('#plannerRegionClear');
            var plannerRegionDropdown=$('#plannerRegionDropdown');

            if(plannerCountryInput){
                plannerCountryInput.addEventListener('input',function(){
                    refreshCountryStatus();
                    refreshRegionOptions(true);
                    syncCountryLock();
                    updateCountryClear();
                    filterPlans();
                    closePlannerDropdowns('plannerCountryDropdown');
                    renderCountryDropdown();
                });
                plannerCountryInput.addEventListener('focus',function(){
                    closePlannerDropdowns('plannerCountryDropdown');
                    renderCountryDropdown();
                });
                plannerCountryInput.addEventListener('change',function(){
                    refreshCountryStatus();
                    refreshRegionOptions(false);
                    syncCountryLock();
                    updateCountryClear();
                    filterPlans();
                });
            }
            if(plannerCountryClear){
                plannerCountryClear.addEventListener('click',function(){
                    if(plannerCountryInput.disabled) return;
                    plannerCountryInput.value='';
                    refreshCountryStatus();
                    refreshRegionOptions(true);
                    syncCountryLock();
                    updateCountryClear();
                    filterPlans();
                    plannerCountryDropdown.classList.add('hidden');
                    plannerCountryInput.focus();
                    markDirty();
                });
            }
            if(plannerRegionInput){
                plannerRegionInput.addEventListener('input',function(){
                    updateRegionClear();
                    closePlannerDropdowns('plannerRegionDropdown');
                    renderRegionDropdown();
                });
                plannerRegionInput.addEventListener('focus',function(){
                    if(!plannerRegionInput.disabled){
                        closePlannerDropdowns('plannerRegionDropdown');
                        renderRegionDropdown();
                    }
                });
            }
            if(plannerRegionClear){
                plannerRegionClear.addEventListener('click',function(){
                    plannerRegionInput.value='';
                    updateRegionClear();
                    renderRegionDropdown();
                    plannerRegionInput.focus();
                    markDirty();
                });
            }

            document.addEventListener('mousedown',function(e){
                if(!e.target.closest('#plannerCountryCombo') && plannerCountryDropdown){
                    plannerCountryDropdown.classList.add('hidden');
                }
                if(!e.target.closest('#plannerRegionCombo') && plannerRegionDropdown){
                    plannerRegionDropdown.classList.add('hidden');
                }
            });

            var plannerItineraryId=new URLSearchParams(window.location.search).get('itineraryId');
            var plannerSaveLabel=$('#plannerSaveLabel');
            if(plannerSaveLabel) plannerSaveLabel.textContent=plannerItineraryId?'수정하기':'저장하기';

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
            function plannerBlockTypeToDb(type){
                var map={
                    sightseeing:'ATTRACTION',
                    meal:'MEAL',
                    accommodation:'LODGING',
                    transport:'TRANSPORT',
                    activity:'ACTIVITY'
                };
                return map[type] || 'ATTRACTION';
            }

            function normalizePlannerTime(value){
                if(!value) return null;
                return value.length===5 ? value+':00' : value;
            }

            function collectPlannerImages(card){
                var gallery=$('[data-photo-gallery]',card);
                if(!gallery) return [];

                var images=[];

                $$('.planner-photo-thumb',gallery).forEach(function(thumb,index){
                    var src=thumb.dataset.src || '';

                    if(!src){
                        var img=$('img',thumb);
                        if(img) src=img.getAttribute('src') || '';
                    }

                    src=String(src || '').trim();

                    /*
                     * 새로 선택한 로컬 파일은 blob: URL이므로
                     * DB에 blob URL을 넣지 않는다.
                     *
                     * 대신 imageUrl=null 상태의 ImageDto를 JSON에 넣고,
                     * 실제 파일은 multipart Part로 별도 전송한다.
                     * 서버가 저장 후 imageUrl을 실제 경로로 채운다.
                     */
                    if(thumb._plannerFile){
                        images.push({
                            imageUrl:null,
                            imageOrder:index+1
                        });
                        return;
                    }

                    /*
                     * 수정 모드에서 기존 DB 이미지라면
                     * 기존 imageUrl을 그대로 유지한다.
                     */
                    if(src && src.indexOf('blob:')!==0){
                        images.push({
                            imageUrl:src,
                            imageOrder:index+1
                        });
                    }
                });

                return images;
            }

            function appendPlannerImageParts(form){
                /*
                 * 이전 저장 시 생성한 동적 file input 제거
                 */
                $$('.planner-upload-part',form).forEach(function(input){
                    input.remove();
                });

                $$('.planner-day').forEach(function(day,dayIndex){
                    $$('.planner-block-card',day).forEach(function(card,blockIndex){
                        var gallery=$('[data-photo-gallery]',card);
                        if(!gallery) return;

                        $$('.planner-photo-thumb',gallery).forEach(function(thumb,index){
                            var file=thumb._plannerFile;
                            if(!file) return;

                            var dt=new DataTransfer();
                            dt.items.add(file);

                            var input=document.createElement('input');
                            input.type='file';
                            input.name=
                                'blockImage_'
                                + dayIndex + '_'
                                + blockIndex + '_'
                                + (index+1);

                            input.className='planner-upload-part';
                            input.files=dt.files;
                            input.hidden=true;

                            form.appendChild(input);
                        });
                    });
                });
            }

            function collectPlannerPayload(){
                var days=[];

                $$('.planner-day').forEach(function(day,dayIndex){
                    var blocks=[];

                    $$('.planner-block-card',day).forEach(function(card,blockIndex){
                        var title=$('.planner-item-title',card);
                        var start=$('.planner-start-time',card);
                        var end=$('.planner-end-time',card);
                        var cost=$('.planner-item-cost',card);
                        var memo=$('.planner-item-note',card);

                        blocks.push({
                            sourceBlockId:card.dataset.sourceBlockId
                                ? Number(card.dataset.sourceBlockId)
                                : null,
                            placeId:null,
                            blockType:plannerBlockTypeToDb(card.dataset.itemType),
                            blockOrder:blockIndex+1,
                            title:title ? title.value.trim() : '',
                            memo:memo ? memo.value.trim() : '',
                            cost:cost && cost.value ? Number(cost.value) : 0,
                            startTime:normalizePlannerTime(start ? start.value : ''),
                            endTime:normalizePlannerTime(end ? end.value : ''),
                            images:collectPlannerImages(card)
                        });
                    });

                    var dayTitle=$('.planner-day-title',day);

                    days.push({
                        sourceDayId:null,
                        dayOrder:dayIndex+1,
                        dayDate:null,
                        title:dayTitle ? dayTitle.textContent.trim() : ('Day '+(dayIndex+1)),
                        blocks:blocks
                    });
                });

                return {
                    itineraryId:plannerItineraryId ? Number(plannerItineraryId) : null,
                    sourceItineraryId:null,
                    title:$('#tripTitle') ? $('#tripTitle').value.trim() : '',
                    summary:null,
                    continent:null,
                    country:$('#plannerCountry') ? $('#plannerCountry').value.trim() : '',
                    city:$('#plannerRegion') && $('#plannerRegion').value.trim()
                        ? $('#plannerRegion').value.trim()
                        : null,
                    travelerCount:$('#plannerTravelerCount')
                        ? Number($('#plannerTravelerCount').value || 1)
                        : 1,
                    startDate:startDate && startDate.value ? startDate.value : null,
                    endDate:endDate && endDate.value ? endDate.value : null,
                    visibility:visibility && visibility.dataset.visibility
                        ? visibility.dataset.visibility
                        : 'PRIVATE',
                    days:days
                };
            }

            var save=$('#plannerSaveBtn');
            if(save) save.addEventListener('click',function(){
                if(!validatePlannerRequiredFields()) return;

                var form=$('#plannerSubmitForm');
                var jsonInput=$('#plannerItineraryJson');

                if(!form || !jsonInput){
                    toast('저장 폼을 찾을 수 없습니다.');
                    return;
                }

                var payload=collectPlannerPayload();

                /*
                 * 실제 이미지 파일을 multipart input으로 구성한 뒤
                 * JSON과 함께 같은 form으로 전송한다.
                 */
                appendPlannerImageParts(form);

                jsonInput.value=JSON.stringify(payload);

                if(plannerItineraryId){
                    form.action='${pageContext.request.contextPath}/itinerary/modify';
                }else{
                    form.action='${pageContext.request.contextPath}/itinerary/write';
                }

                dirty=false;
                sessionStorage.removeItem(DRAFT_KEY);
                form.submit();
            });
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
                var center=$('#plannerCenterPanel');
                if(!center) return;

                /*
                 * 일정 가져오기 드래그 중에는 국가가 비어 있어도
                 * DAY 영역이 dragover/drop 이벤트를 받을 수 있게 한다.
                 */
                if(center.dataset.importDragActive==='1'){
                    center.classList.remove('is-country-locked');
                    center.setAttribute('aria-disabled','false');
                    return;
                }

                var locked=!findPlannerCountry(
                    $('#plannerCountry')
                        ? $('#plannerCountry').value
                        : ''
                );

                center.classList.toggle(
                    'is-country-locked',
                    locked
                );

                center.setAttribute(
                    'aria-disabled',
                    locked ? 'true' : 'false'
                );
            }
            var countryInput=$('#plannerCountry');
            if(countryInput){
                countryInput.addEventListener('input',syncCountryLock);
                countryInput.addEventListener('change',syncCountryLock);
            }

            /*
             * 드래그를 중간에 취소한 경우에도
             * 원래 국가 잠금 상태로 복귀시킨다.
             */
            document.addEventListener('dragend',function(){
                finishImportDrag();
            });
            restoreDraft();
            refreshCountryStatus();
            refreshRegionOptions(false);
            updateCountryClear();
            updateRegionClear();
            syncCountryLock();
            syncCountryEditLock();

            /*
             * 블록/DAY 삭제 경로가 여러 곳이라 DOM 변화를 기준으로
             * 국가 잠금 상태를 항상 다시 계산한다.
             */
            var plannerDaysRoot=$('#plannerDays');
            if(plannerDaysRoot && window.MutationObserver){
                new MutationObserver(function(){
                    syncCountryEditLock();
                }).observe(plannerDaysRoot,{
                    childList:true,
                    subtree:true
                });
            }

            if(typeof filterPlans==='function'){
                filterPlans();
            }

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
            function setupRequiredFieldsModal(){
                var plannerRequiredClose=$('#plannerRequiredClose');
                var plannerRequiredBackdrop=$('#plannerRequiredBackdrop');

                if(plannerRequiredClose && !plannerRequiredClose.dataset.bound){
                    plannerRequiredClose.dataset.bound='1';
                    plannerRequiredClose.addEventListener('click',function(e){
                        e.preventDefault();
                        closeRequiredFieldsModal();
                    });
                }

                if(plannerRequiredBackdrop && !plannerRequiredBackdrop.dataset.bound){
                    plannerRequiredBackdrop.dataset.bound='1';
                    plannerRequiredBackdrop.addEventListener('click',function(e){
                        if(e.target===plannerRequiredBackdrop){
                            closeRequiredFieldsModal();
                        }
                    });
                }
            }

            if(document.readyState==='loading'){
                document.addEventListener('DOMContentLoaded',setupRequiredFieldsModal);
            }else{
                setupRequiredFieldsModal();
            }

            document.addEventListener('keydown',function(e){
                var plannerRequiredBackdrop=$('#plannerRequiredBackdrop');

                if(e.key==='Escape'
                        && plannerRequiredBackdrop
                        && plannerRequiredBackdrop.classList.contains('is-open')){
                    closeRequiredFieldsModal();
                }
            });

            window.setTimeout(function(){ if(!map) showPlannerMapFallback(); },1800);
        })();
    </script>
    <script async
        onerror="showPlannerMapFallback()" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB7ioaQS08aAzCl7gZPk6SyE1w7EeIrYhI&language=ko&loading=async&callback=initPlannerMap"></script>

    <div id="plannerRequiredBackdrop" class="planner-required-backdrop" aria-hidden="true">
        <div class="planner-required-modal" role="dialog" aria-modal="true" aria-labelledby="plannerRequiredTitle">
            <div class="flex items-center gap-3">
                <div class="planner-required-icon">!</div>
                <div>
                    <h3 id="plannerRequiredTitle" class="text-base font-bold text-gray-800">필수 항목을 확인해 주세요</h3>
                    <p class="mt-1 text-xs text-gray-500">저장하기 전에 아래 항목을 입력하거나 수정해야 합니다.</p>
                </div>
            </div>
            <ul id="plannerRequiredList" class="planner-required-list"></ul>
            <button type="button" id="plannerRequiredClose"
                class="mt-5 w-full h-10 rounded-xl text-sm font-bold text-white"
                style="background:#6369D1">확인</button>
        </div>
    </div>

    <div id="plannerConfirmBackdrop" class="planner-confirm-backdrop" aria-hidden="true">
        <div class="planner-confirm-modal" role="dialog" aria-modal="true" aria-labelledby="plannerConfirmTitle">
            <div class="planner-confirm-content">
                <div class="planner-confirm-head">
                    <div class="planner-confirm-icon" aria-hidden="true">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                            stroke-linecap="round" stroke-linejoin="round">
                            <polyline points="3 6 5 6 21 6"></polyline>
                            <path d="M19 6l-1 14H6L5 6"></path>
                            <path d="M8 6V4h8v2"></path>
                            <path d="M10 11v6M14 11v6"></path>
                        </svg>
                    </div>
                    <h3 id="plannerConfirmTitle" class="planner-confirm-title">삭제</h3>
                </div>
                <div class="planner-confirm-body">
                    <p id="plannerConfirmMessage" class="planner-confirm-message">삭제할까요?</p>
                    <div id="plannerConfirmList" class="planner-confirm-list"></div>
                    <p id="plannerConfirmWarning" class="planner-confirm-warning">삭제 후 되돌릴 수 없습니다.</p>
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
