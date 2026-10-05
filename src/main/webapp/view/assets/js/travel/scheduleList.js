(function() {

	/* 상세 조건 패널 열기·닫기 */
	const filterToggle = document.getElementById("scheduleFilterToggle");
	const filterPanel = document.getElementById("scheduleFilterPanel");

	if (filterToggle && filterPanel) {

		function setFilterPanelOpen(open) {
			filterPanel.classList.toggle("hidden", !open);

			filterToggle.setAttribute("aria-expanded", String(open));

			const arrow = filterToggle.querySelector("svg");

			if (arrow) {
				arrow.style.transform = open ? "rotate(180deg)" : "";
			}
		}

		filterToggle.addEventListener("click", function() {
			const isOpen = filterToggle.getAttribute("aria-expanded") === "true";

			setFilterPanelOpen(!isOpen);
		});

		// 검색창을 클릭하거나 키보드로 선택하면 상세 조건 펼치기
		const keywordInput = document.getElementById("scheduleKeyword");

		if (keywordInput) {
			keywordInput.addEventListener("click", function() {
				setFilterPanelOpen(true);
			});

			keywordInput.addEventListener("focus", function() {
				setFilterPanelOpen(true);
			});
		}

		// 검색 영역 밖을 클릭하면 닫기
		document.addEventListener("click", function(event) {
			const searchForm = document.getElementById("scheduleSearchForm");

			if (searchForm && !searchForm.contains(event.target)) {
				setFilterPanelOpen(false);
			}
		});

		// Escape 키로 닫기
		document.addEventListener("keydown", function(event) {
			if (event.key === "Escape") {
				setFilterPanelOpen(false);
			}
		});
	}

	/* 국가 선택 조회 */
	const searchForm = document.getElementById("scheduleSearchForm");

	// 조회 후 URL의 검색 조건으로 체크 상태 복원
	if (searchForm) {
		const query = new URLSearchParams(window.location.search);
		["durations", "budgets", "travelers"].forEach(function(name) {
			const selectedValues = query.getAll(name);

			searchForm.querySelectorAll(`input[name="${name}"]`).forEach(function(checkbox) {
				checkbox.checked = selectedValues.includes(checkbox.value);
			});
		});
	}

	// 상세 조건 체크박스만 초기화
	const filterReset = document.getElementById("scheduleFilterReset");

	if (searchForm && filterReset) {
		filterReset.addEventListener("click", function() {
			searchForm.querySelectorAll(
				'input[name="durations"], ' +
				'input[name="budgets"], ' +
				'input[name="travelers"]'
			).forEach(function(checkbox) {
				checkbox.checked = false;
			});
		});
	}

	const countryInput = document.getElementById("scheduleCountry");

	if (searchForm && countryInput) {

		const countryButtons = document.querySelectorAll("[data-schedule-country]");

		countryButtons.forEach(function(button) {

			const selected = button.dataset.scheduleCountry === countryInput.value;

			button.setAttribute("aria-pressed", String(selected));

			// 국가 버튼의 선택 표시
			if (button.dataset.scheduleCountry !== "" && selected) {
				button.style.color = "#6369D1";
				button.style.backgroundColor = "#F0F0FF";
				button.style.fontWeight = "600";
			}

			button.addEventListener("click", function() {
				countryInput.value = button.dataset.scheduleCountry;

				searchForm.requestSubmit();
			});
		});
	}

	/* 대륙별 국가 목록 펼치기·접기 */
	document.querySelectorAll("[data-continent-toggle]").forEach(function(button) {

		const group = button.parentElement;

		const panel = group.querySelector(".continent-panel");

		const arrow = button.querySelector(".continent-chevron");

		if (!panel) {
			return;
		}

		function setContinentOpen(open) {
			panel.style.display = open ? "flex" : "none";

			button.setAttribute("aria-expanded", String(open));

			if (arrow) {
				arrow.style.transform = open ? "rotate(180deg)" : "";
			}
		}

		// 선택한 국가가 속한 대륙은 조회 후에도 펼침
		const containsSelectedCountry =
			countryInput &&
			countryInput.value !== "" &&
			Array.from(panel.querySelectorAll("[data-schedule-country]")).some(function(countryButton) {
				return countryButton.dataset.scheduleCountry === countryInput.value;
			});

		setContinentOpen(Boolean(containsSelectedCountry));

		button.addEventListener("click", function() {
			const isOpen = button.getAttribute("aria-expanded") === "true";

			setContinentOpen(!isOpen);
		});
	});

	/* 조회 조건을 유지하면서 정렬 변경 */
	const sortInput = document.getElementById("scheduleSort");

	if (searchForm && sortInput) {
		if (!["latest", "views", "likes"].includes(sortInput.value)) {
			sortInput.value = "latest";
		}

		document.querySelectorAll("[data-schedule-sort]").forEach(function(button) {
			const selected = button.dataset.scheduleSort === sortInput.value;

			button.setAttribute("aria-pressed", String(selected));

			button.style.color = selected ? "#6369D1" : "#9ca3af";
			button.style.fontWeight = selected ? "600" : "400";
			button.style.borderBottom = selected ? "2px solid #6369D1" : "2px solid transparent";

			button.addEventListener("click", function() {
				sortInput.value = button.dataset.scheduleSort;
				searchForm.requestSubmit();
			});
		});
	}

	// 클릭 이벤트
	document.addEventListener("click", function(event) {

		const button = event.target.closest("[data-schedule-bookmark]");

		if (!button) {
			return;
		}

		event.preventDefault();
		event.stopPropagation();

		/* 비로그인시 로그인 페이지로 처리.*/
		if (button.dataset.loggedIn !== "true") {
			window.location.href = button.dataset.loginUrl;
			return;
		}

		if (button.dataset.loading === "true") {
			return;
		}

		toggleBookmark(button);
	});

	async function toggleBookmark(button) {

		const itineraryId = button.dataset.itineraryId;
		const url = button.dataset.bookmarkUrl;

		if (!itineraryId || !url) {
			window.tripilyToast("북마크 요청 정보를 확인해주세요.");
			return;
		}

		button.dataset.loading = "true";
		button.disabled = true;
		button.setAttribute("aria-busy", "true");

		try {
			const params = new URLSearchParams();

			params.set("itineraryId", itineraryId);

			const response = await fetch(url, {
				method: "POST",
				credentials: "same-origin",
				headers: {
					"Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
					"Accept": "application/json"
				},
				body: params.toString()
			});

			const result = await response.json();

			if (!response.ok || result.success !== true) {
				throw new Error(result.message || "북마크 처리에 실패했습니다.");
			}

			if (typeof result.bookmarked !== "boolean") {
				throw new Error("서버 응답을 확인해주세요.");
			}

			updateBookmarkButton(button, result.bookmarked);

			window.tripilyToast(
				result.bookmarked ? "일정을 북마크했어요." : "북마크를 해제했어요."
			);

		} catch (error) {
			console.error(error);

			window.tripilyToast(
				error.message || "북마크 처리 중 오류가 발생했습니다."
			);

		} finally {
			delete button.dataset.loading;

			button.disabled = false;
			button.removeAttribute("aria-busy");
		}
	}

	function updateBookmarkButton(button, bookmarked) {

		button.setAttribute("aria-pressed", String(bookmarked));

		button.setAttribute("aria-label", bookmarked ? "북마크 해제" : "북마크 추가");

		const icon = button.querySelector("svg");

		if (icon) {
			icon.setAttribute("fill", bookmarked ? "#6369D1" : "none");
			icon.setAttribute("stroke", bookmarked ? "#6369D1" : "#9ca3af");
		}
	}

	/* 무한 스크롤 */
	const cardGrid = document.getElementById("scheduleCardGrid");
	const scrollArea = document.getElementById("scheduleInfiniteScroll");
	const sentinel = document.getElementById("scheduleScrollSentinel");

	if (cardGrid && scrollArea && sentinel) {
		const loading = document.getElementById("scheduleLoading");
		const retryButton = document.getElementById("scheduleLoadRetry");
		const complete = document.getElementById("scheduleLoadComplete");

		let offset = Number(scrollArea.dataset.loadedCount);
		const totalCount = Number(scrollArea.dataset.totalCount);

		let isLoading = false;
		let finished = offset >= totalCount;

		// 현재 화면에 적용된 조건을 사용
		const appliedQuery = new URLSearchParams(window.location.search);

		const observer = new IntersectionObserver(function(entries) {
			if (entries.some(function(entry) {
				return entry.isIntersecting;
			})) {
				loadMore();
			}
		}, {
			threshold: 0
		});

		function finishLoading() {
			finished = true;
			observer.disconnect();
			sentinel.classList.add("hidden");

			if (totalCount > 0) {
				complete.classList.remove("hidden");
			}
		}

		async function loadMore() {
			if (isLoading || finished) {
				return;
			}

			isLoading = true;
			loading.classList.remove("hidden");
			retryButton.classList.add("hidden");

			// 요청 중 중복 감지 방지
			observer.unobserve(sentinel);

			let succeeded = false;

			try {
				const params = new URLSearchParams(appliedQuery);

				params.set("offset", String(offset));

				const response = await fetch(
					scrollArea.dataset.loadUrl + "?" + params.toString(),
					{
						credentials: "same-origin",
						headers: {
							"Accept": "text/html"
						}
					}
				);

				if (!response.ok) {
					throw new Error("일정 추가 조회에 실패했습니다.");
				}

				const html = await response.text();
				const template = document.createElement("template");

				template.innerHTML = html.trim();

				const cards = Array.from(template.content.children);

				if (cards.some(function(card) {
					return !card.matches("article.jsp-schedule-card");
				})) {
					throw new Error("추가 조회 응답을 확인해주세요.");
				}

				cards.forEach(function(card) {
					cardGrid.appendChild(card);
				});

				offset += cards.length;
				scrollArea.dataset.loadedCount = String(offset);

				succeeded = true;

				if (cards.length < 12 || offset >= totalCount) {
					finishLoading();
				}

			} catch (error) {
				console.error(error);
				retryButton.classList.remove("hidden");

			} finally {
				isLoading = false;
				loading.classList.add("hidden");

				if (succeeded && !finished) {
					observer.observe(sentinel);
				}
			}
		}

		retryButton.addEventListener("click", loadMore);

		if (finished) {
			finishLoading();
		} else {
			observer.observe(sentinel);
		}
	}


})();