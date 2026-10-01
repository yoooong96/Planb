<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage", "travel");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>장바구니 | Tripily</title>

<jsp:include page="/common/headStyles.jsp" />

<style>
/* 장바구니 페이지에만 적용되는 보완 스타일 */
.cart-page {
    flex: 1;
    background: #fbfbfe;
    min-height: calc(100vh - 68px);
}

.cart-page-inner {
    width: 100%;
    max-width: 1440px;
    margin: 0 auto;
    padding: 32px 24px;
}

.cart-heading {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    gap: 16px;
    margin-bottom: 24px;
}

.cart-title {
    margin: 0 0 4px;
    color: #111827;
    font-size: 24px;
    font-weight: 900;
    line-height: 1.4;
}

.cart-description {
    margin: 0;
    color: #6b7280;
    font-size: 14px;
    line-height: 1.6;
}

.cart-count {
    flex-shrink: 0;
    padding: 6px 12px;
    border-radius: 999px;
    background: #6369d115;
    color: #6369d1;
    font-size: 14px;
    font-weight: 700;
    white-space: nowrap;
}

.cart-search-panel {
    margin-bottom: 20px;
    padding: 16px;
    border: 1px solid #d1d2f9;
    border-radius: 16px;
    background: #fff;
}

.cart-search-box {
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 10px 12px;
    border: 1px solid #d1d2f9;
    border-radius: 12px;
    background: #f8f8fc;
}

.cart-search-box:focus-within {
    border-color: #6369d1;
    box-shadow: 0 0 0 3px rgba(99, 105, 209, .08);
}

.cart-search-icon {
    width: 18px;
    height: 18px;
    flex-shrink: 0;
    color: #6369d1;
}

.cart-search-input {
    flex: 1;
    min-width: 0;
    border: 0;
    outline: none;
    background: transparent;
    color: #374151;
    font: inherit;
    font-size: 14px;
}

.cart-search-input::placeholder {
    color: #9ca3af;
}

.cart-search-clear {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 24px;
    height: 24px;
    padding: 0;
    border: 0;
    background: transparent;
    color: #9ca3af;
    cursor: pointer;
}

.cart-search-clear:hover {
    color: #6369d1;
}

.cart-search-clear[hidden] {
    display: none;
}

.cart-empty {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 96px 16px;
    text-align: center;
}

.cart-empty-icon {
    margin-bottom: 16px;
    font-size: 48px;
    line-height: 1.2;
}

.cart-empty-title {
    margin: 0 0 4px;
    color: #6b7280;
    font-size: 16px;
    font-weight: 600;
}

.cart-empty-description {
    margin: 0;
    color: #9ca3af;
    font-size: 14px;
    line-height: 1.6;
}

@media (max-width: 640px) {
    .cart-page-inner {
        padding: 24px 16px;
    }

    .cart-title {
        font-size: 22px;
    }

    .cart-empty {
        padding: 72px 12px;
    }
}
</style>
</head>

<body class="site-shell">

<jsp:include page="/common/header.jsp" />

<main class="cart-page">
    <div class="cart-page-inner">

        <!-- 제목과 담은 항목 수 -->
        <div class="cart-heading">
            <div>
                <h1 class="cart-title">장바구니</h1>

                <p class="cart-description">
                    담아둔 일정, 일차, 장소를 확인하고
                    내 일정을 만들어보세요.
                </p>
            </div>

            <span class="cart-count">
                총 <span id="cartTotalCount">0</span>개
            </span>
        </div>

        <!-- 카테고리 없이 검색창만 표시 -->
        <div class="cart-search-panel">
            <div class="cart-search-box">

                <svg
                    class="cart-search-icon"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    aria-hidden="true">

                    <circle cx="10.5" cy="10.5" r="6.5" />

                    <path
                        stroke-linecap="round"
                        d="M16 16l5 5" />
                </svg>

                <input
                    id="cartSearchInput"
                    class="cart-search-input"
                    type="search"
                    placeholder="일정·장소 이름으로 검색..."
                    aria-label="장바구니 검색"
                    autocomplete="off">

                <button
                    id="cartSearchClear"
                    class="cart-search-clear"
                    type="button"
                    aria-label="검색어 지우기"
                    hidden>

                    <svg
                        width="16"
                        height="16"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        aria-hidden="true">

                        <path
                            stroke-linecap="round"
                            d="M6 6l12 12M18 6L6 18" />
                    </svg>
                </button>

            </div>
        </div>

        <!-- DB 연결 시 장바구니 목록을 출력할 영역 -->
        <div id="cartList"></div>

        <!-- 빈 장바구니 -->
        <div id="cartEmpty" class="cart-empty">

            <div class="cart-empty-icon" aria-hidden="true">
                🛒
            </div>

            <p class="cart-empty-title">
                장바구니가 비어있어요
            </p>

            <p class="cart-empty-description">
                일정 상세에서 담기 버튼을 눌러보세요!
            </p>

        </div>

    </div>
</main>

<script src="${pageContext.request.contextPath}/view/assets/js/tripily.js"></script>

<script>
(function () {
    const searchInput =
        document.getElementById("cartSearchInput");

    const clearButton =
        document.getElementById("cartSearchClear");

    searchInput.addEventListener("input", function () {
        clearButton.hidden = searchInput.value.length === 0;
    });

    clearButton.addEventListener("click", function () {
        searchInput.value = "";
        clearButton.hidden = true;
        searchInput.focus();

        // 이후 검색 기능을 연결해도 초기화 이벤트가 전달되도록 처리
        searchInput.dispatchEvent(
            new Event("input", { bubbles: true })
        );
    });
})();
</script>

</body>
</html>