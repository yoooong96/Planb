// ================================
// 대륙별 국가 목록 펼치기 / 접기 + 선택 국가 표시
// ================================
(function () {

	const selectedCountry = (window.selectedCountry || "").trim();

	// 선택 국가 표시 (일정 목록과 동일한 색)
	document.querySelectorAll(".continent-panel a").forEach(function (link) {
		const country = new URL(link.href, window.location.origin).searchParams.get("country");
		const selected = selectedCountry !== "" && country === selectedCountry;

		link.setAttribute("aria-current", String(selected));

		if (selected) {
			link.style.color = "#6369D1";
			link.style.backgroundColor = "#F0F0FF";
			link.style.fontWeight = "600";
		}
	});

	// 대륙 패널 열기 / 닫기
	document.querySelectorAll("[data-continent-toggle]").forEach(function (button) {

		const panel = document.querySelector(
			'[data-continent-panel="' + button.dataset.continentToggle + '"]'
		);
		const chevron = button.querySelector(".continent-chevron");

		if (!panel) return;

		function setContinentOpen(open) {
			panel.classList.toggle("hidden", !open);
			panel.style.display = open ? "block" : "none";
			button.setAttribute("aria-expanded", String(open));
			if (chevron) {
				chevron.style.transform = open ? "rotate(180deg)" : "";
			}
		}

		const containsSelectedCountry = selectedCountry !== "" &&
			Array.from(panel.querySelectorAll("a")).some(function (link) {
				return new URL(link.href, window.location.origin)
					.searchParams.get("country") === selectedCountry;
			});

		setContinentOpen(containsSelectedCountry);

		button.addEventListener("click", function () {
			setContinentOpen(button.getAttribute("aria-expanded") !== "true");
		});
	});
})();
 
// ================================
// 카드 미리보기에서 사진 위치 표시([[IMG:n]]) 제거
//  - 글 작성 시 사진 위치가 본문에 [[IMG:1]] 형태로 저장되므로
//    목록 카드의 미리보기 문구에서는 보이지 않게 정리한다.
// ================================
 
function cleanTipPreview(root) {
 
	root.querySelectorAll("p.line-clamp-2").forEach(function (preview) {
 
		const original = preview.textContent;
 
		if (!/\[\[IMG:\d+\]\]/.test(original)) {
			return;
		}
 
		preview.textContent = original
			.replace(/\[\[IMG:\d+\]\]/g, " ")
			.replace(/\s+/g, " ")
			.trim();
	});
}
 
// 처음 화면에 그려진 카드
cleanTipPreview(document);
 
// ================================
// 여행 꿀팁 무한 스크롤
// ================================
 
const infiniteScroll = document.getElementById("tipInfiniteScroll");
const cardGrid = document.querySelector("[data-card-grid]");
const sentinel = document.getElementById("tipScrollSentinel");
const loading = document.getElementById("tipLoading");
const loadComplete = document.getElementById("tipLoadComplete");
 
if (infiniteScroll && cardGrid) {
 
    let currentPage = Number(infiniteScroll.dataset.currentPage);
    let currentCount = Number(infiniteScroll.dataset.currentCount);
    const totalCount = Number(infiniteScroll.dataset.totalCount);
 
    let isLoading = false;
    const loadingStartTime = Date.now();
 
    window.addEventListener("scroll", function () {
 
        if (isLoading) {
            return;
        }
 
        if (currentCount >= totalCount) {
            return;
        }
 
        // 현재 스크롤 위치
        const scrollTop =
            window.pageYOffset ||
            document.documentElement.scrollTop;
 
        // 현재 브라우저 화면 높이
        const windowHeight = window.innerHeight;
 
        // 전체 문서 높이
        const documentHeight =
            document.documentElement.scrollHeight;
 
        /*
         * 실제 페이지 맨 아래 근처까지 내려왔을 때만
         * 다음 페이지를 불러온다.
         */
        if (scrollTop + windowHeight < documentHeight - 30) {
            return;
        }
 
        loadNextPage();
 
    });
 
 
    function loadNextPage() {
 
	    if (isLoading || currentCount >= totalCount) {
	        return;
	    }
	
	    isLoading = true;
	
	    // 로딩 표시
	    if (loading) {
	        loading.classList.remove("hidden");
	        loading.classList.add("flex");
	    }
	
	    // 로딩 시작 시점의 현재 개수 표시
	    const currentCountElement =
	        document.getElementById("tipCurrentCount");
	
	    if (currentCountElement) {
	        currentCountElement.textContent = currentCount;
	    }
	
	    const nextPage = currentPage + 1;
	
	    const params =
	        new URLSearchParams(window.location.search);
	
	    params.set("page", nextPage);
	
	    const loadUrl =
	        window.location.pathname
	        + "/load?"
	        + params.toString();
	
	    fetch(loadUrl)
	
	        .then(function (response) {
	
	            if (!response.ok) {
	                throw new Error(
	                    "여행 꿀팁을 불러오지 못했습니다."
	                );
	            }
	
	            return response.text();
	        })
	
	        .then(function (html) {
	
	            const temp =
	                document.createElement("div");
	
	            temp.innerHTML = html.trim();
	
	            const newCards =
	                Array.from(temp.children);
	
	            /*
	             * 테스트용:
	             * 로딩 화면을 5초 보여준 뒤
	             * 실제 카드를 추가한다.
	             */
	            setTimeout(function () {
	
	                // 더 이상 가져올 게시글이 없는 경우
	                if (newCards.length === 0) {
	
	                    currentCount = totalCount;
	
	                    hideLoading();
	                    showComplete();
	
	                    isLoading = false;
	
	                    return;
	                }
	
	                // 여기서 실제 카드가 추가됨
	                newCards.forEach(function (card) {
 
	                    // 미리보기 문구의 [[IMG:n]] 표시 제거
	                    cleanTipPreview(card);
 
	                    cardGrid.appendChild(card);
	                });
	
	                currentPage = nextPage;
	
	                currentCount = Math.min(
	                    currentCount + newCards.length,
	                    totalCount
	                );
	
	                infiniteScroll.dataset.currentPage =
	                    currentPage;
	
	                infiniteScroll.dataset.currentCount =
	                    currentCount;
	
	                // 카드 추가가 끝난 후 로딩 숨김
	                hideLoading();
	
	                // 마지막 페이지라면 그때 완료 문구 표시
	                if (currentCount >= totalCount) {
	                    showComplete();
	                }
	
	                isLoading = false;
	
	            }, 1000);
	        })
	
	        .catch(function (error) {
	
	            console.error(
	                "무한 스크롤 오류:",
	                error
	            );
	
	            hideLoading();
	
	            isLoading = false;
	        });
	}
	function hideLoading() {
 
	    if (loading) {
	        loading.classList.add("hidden");
	        loading.classList.remove("flex");
	    }
	}
 
 
    function showComplete() {
 
        if (sentinel) {
            sentinel.classList.add("hidden");
        }
 
        const completeCount =
            document.getElementById("tipCompleteCount");
 
        if (completeCount) {
            completeCount.textContent = currentCount;
        }
 
        if (loadComplete) {
 
            loadComplete.classList.remove("hidden");
            loadComplete.classList.add("flex");
        }
    }
}
 
// ================================
// 최상단 이동 버튼
// ================================
 
const tipScrollTopBtn =
	document.getElementById("tipScrollTopBtn");
 
if (tipScrollTopBtn) {
 
	window.addEventListener("scroll", function () {
 
		// 500px 이상 내려가면 버튼 표시
		if (window.scrollY > 500) {
			tipScrollTopBtn.classList.add("show");
		} else {
			tipScrollTopBtn.classList.remove("show");
		}
	});
 
	tipScrollTopBtn.addEventListener("click", function () {
 
		window.scrollTo({
			top: 0,
			behavior: "smooth"
		});
	});
}
 
// =========================
// 뒤로가기로 목록 복원 시 새로고침
// =========================
 
window.addEventListener("pageshow", function(event) {
 
	var navigationEntries = performance.getEntriesByType("navigation");
 
	if (
		event.persisted ||
		(
			navigationEntries.length > 0 &&
			navigationEntries[0].type === "back_forward"
		)
	) {
		window.location.reload();
	}
 
});