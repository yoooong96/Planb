(function() {

	const button =
		document.getElementById("scheduleLikeButton");

	const count =
		document.getElementById("scheduleLikeCount");

	if (!button || !count) {
		return;
	}

	button.addEventListener("click", async function(event) {

		event.preventDefault();

		if (button.dataset.loggedIn !== "true") {
			window.location.href = button.dataset.loginUrl;
			return;
		}

		if (button.disabled) {
			return;
		}

		button.disabled = true;
		button.setAttribute("aria-busy", "true");

		try {
			const params = new URLSearchParams();

			params.set(
				"itineraryId",
				button.dataset.itineraryId
			);

			const response = await fetch(
				button.dataset.likeUrl,
				{
					method: "POST",
					credentials: "same-origin",
					headers: {
						"Content-Type":
							"application/x-www-form-urlencoded;charset=UTF-8",
						"Accept": "application/json"
					},
					body: params.toString()
				}
			);

			const result = await response.json();

			if (!response.ok || result.success !== true) {
				throw new Error(
					result.message || "좋아요 처리에 실패했습니다."
				);
			}

			if (typeof result.liked !== "boolean"
				|| !Number.isInteger(result.likeCount)
				|| result.likeCount < 0) {

				throw new Error("서버 응답을 확인해주세요.");
			}

			// 서버에서 처리한 결과로 화면 갱신
			button.setAttribute(
				"aria-pressed",
				String(result.liked)
			);

			button.setAttribute(
				"aria-label",
				result.liked ? "좋아요 취소" : "좋아요"
			);

			button.style.color =
				result.liked ? "#ef4444" : "#94a3b8";

			const icon = button.querySelector("svg");

			if (icon) {
				icon.setAttribute(
					"fill",
					result.liked ? "currentColor" : "none"
				);
			}

			count.textContent =
				result.likeCount.toLocaleString("ko-KR");

		} catch (error) {
			console.error(error);

			window.tripilyToast(
				error.message || "좋아요 처리 중 오류가 발생했습니다."
			);

		} finally {
			button.disabled = false;
			button.removeAttribute("aria-busy");
		}
	});

})();

(function() {

	const button =
		document.getElementById("scheduleBookmarkButton");

	if (!button) {
		return;
	}

	button.addEventListener("click", async function(event) {

		event.preventDefault();

		if (button.dataset.loggedIn !== "true") {
			window.location.href = button.dataset.loginUrl;
			return;
		}

		if (button.disabled) {
			return;
		}

		button.disabled = true;
		button.setAttribute("aria-busy", "true");

		try {
			const params = new URLSearchParams();

			params.set(
				"itineraryId",
				button.dataset.itineraryId
			);

			const response = await fetch(
				button.dataset.bookmarkUrl,
				{
					method: "POST",
					credentials: "same-origin",
					headers: {
						"Content-Type":
							"application/x-www-form-urlencoded;charset=UTF-8",
						"Accept": "application/json"
					},
					body: params.toString()
				}
			);

			const result = await response.json();

			if (!response.ok || result.success !== true) {
				throw new Error(
					result.message || "북마크 처리에 실패했습니다."
				);
			}

			if (typeof result.bookmarked !== "boolean") {
				throw new Error("서버 응답을 확인해주세요.");
			}

			button.setAttribute(
				"aria-pressed",
				String(result.bookmarked)
			);

			const label =
				result.bookmarked ? "북마크 해제" : "북마크 추가";

			button.setAttribute("aria-label", label);
			button.title = label;

			const icon = button.querySelector("svg");

			if (icon) {
				icon.setAttribute(
					"fill",
					result.bookmarked ? "#6369D1" : "none"
				);
			}

			window.tripilyToast(
				result.bookmarked
					? "일정을 북마크했어요."
					: "북마크를 해제했어요."
			);

		} catch (error) {
			console.error(error);

			window.tripilyToast(
				error.message || "북마크 처리 중 오류가 발생했습니다."
			);

		} finally {
			button.disabled = false;
			button.removeAttribute("aria-busy");
		}
	});

})();

(function() {

	const tabs =
		document.querySelectorAll("[data-detail-tab]");

	const schedulePanel =
		document.getElementById("detailSchedulePanel");

	const commentPanel =
		document.getElementById("detailCommentPanel");

	if (!tabs.length || !schedulePanel || !commentPanel) {
		return;
	}

	function selectTab(selected) {

		schedulePanel.classList.toggle(
			"hidden",
			selected !== "schedule"
		);

		commentPanel.classList.toggle(
			"hidden",
			selected !== "comments"
		);

		tabs.forEach(function(tab) {

			const active =
				tab.dataset.detailTab === selected;

			tab.setAttribute(
				"aria-selected",
				String(active)
			);

			tab.style.color =
				active ? "#6369D1" : "#94a3b8";

			const line =
				tab.querySelector("[data-detail-tab-line]");

			if (line) {
				line.classList.toggle("hidden", !active);
			}
		});
	}

	tabs.forEach(function(tab) {
		tab.addEventListener("click", function() {
			selectTab(tab.dataset.detailTab);
		});
	});

	selectTab("schedule");

})();

(function() {
	// 현재는 지도 요청을 실행하지 않음
	const mapEnabled = false;

	if (!mapEnabled) {
		return;
	}

	var data = [
		{
			day: 1,
			color: '#6369D1',
			items: [['제주공항 도착', 33.5069, 126.4927],
			['흑돼지 맛집 점심', 33.4996, 126.5267],
			['성산일출봉', 33.4582, 126.9427],
			['광치기해변 산책', 33.4569, 126.9199]]
		},
		{
			day: 2,
			color: '#ef4444',
			items: [['섭지코지 일출', 33.4265, 126.9303],
			['카페 오션뷰', 33.2508, 126.5643],
			['한라산 국립공원 트래킹', 33.3617, 126.5292],
			['흑돼지거리 저녁', 33.4958, 126.5312]]
		},
		{
			day: 3,
			color: '#10b981',
			items: [['협재해변', 33.3942, 126.2397],
			['우도 당일치기', 33.5013, 126.9516]]
		}];
	function initDetailMap() {
		if (!window.google || !google.maps
			|| !document.getElementById('detailGoogleMap'))
			return;
		var all = [];
		data.forEach(function(d) {
			d.items.forEach(function(x) {
				all.push({
					lat: x[1],
					lng: x[2]
				})
			})
		});
		var map = new google.maps.Map(document
			.getElementById('detailGoogleMap'), {
			center: {
				lat: 33.38,
				lng: 126.55
			},
			zoom: 11,
			mapTypeControl: false,
			streetViewControl: false,
			fullscreenControl: false
		});
		var bounds = new google.maps.LatLngBounds();
		all.forEach(function(c) {
			bounds.extend(c)
		});
		map.fitBounds(bounds, 48);
		var ds = new google.maps.DirectionsService(), num = 1;
		data
			.forEach(function(d) {
				d.items
					.forEach(function(x) {
						var svg = encodeURIComponent('<svg xmlns="http://www.w3.org/2000/svg" width="28" height="28"><circle cx="14" cy="14" r="12" fill="' + d.color + '" stroke="white" stroke-width="2.5"/><text x="14" y="19" text-anchor="middle" font-size="11" font-weight="bold" font-family="Arial,sans-serif" fill="white">'
							+ (num++) + '</text></svg>');
						new google.maps.Marker(
							{
								position: {
									lat: x[1],
									lng: x[2]
								},
								map: map,
								icon: {
									url: 'data:image/svg+xml;charset=UTF-8,'
										+ svg,
									scaledSize: new google.maps.Size(
										28, 28),
									anchor: new google.maps.Point(
										14, 14)
								},
								title: x[0]
							});
					});
				if (d.items.length > 1) {
					ds
						.route(
							{
								origin: {
									lat: d.items[0][1],
									lng: d.items[0][2]
								},
								destination: {
									lat: d.items[d.items.length - 1][1],
									lng: d.items[d.items.length - 1][2]
								},
								waypoints: d.items
									.slice(1, -1)
									.map(
										function(x) {
											return {
												location: {
													lat: x[1],
													lng: x[2]
												},
												stopover: true
											}
										}),
								travelMode: google.maps.TravelMode.DRIVING,
								optimizeWaypoints: false
							},
							function(res, status) {
								if (status === 'OK' && res)
									new google.maps.Polyline(
										{
											path: res.routes[0].overview_path,
											strokeColor: d.color,
											strokeOpacity: .88,
											strokeWeight: 5,
											map: map
										});
							});
				}
			});
	}
	window.initDetailMap = initDetailMap;
	if (window.google && window.google.maps) {
		initDetailMap();
	}
})();

/* 댓글 작성·삭제 */
(function() {

	const panel = document.getElementById("detailCommentPanel");
	const input = document.getElementById("scheduleCommentContent");
	const submit = document.getElementById("scheduleCommentSubmit");
	const length = document.getElementById("scheduleCommentLength");
	const list = document.getElementById("scheduleCommentList");
	const count = document.getElementById("scheduleCommentCount");

	if (!panel || !input || !submit || !length || !list || !count) {
		return;
	}

	// 작성과 삭제 요청이 동시에 진행되지 않도록 관리
	let processing = false;

	function updateLength() {
		// 서버의 codePointCount와 동일하게 글자 수 계산
		const size = Array.from(input.value).length;

		length.textContent = size.toLocaleString("ko-KR");
		length.style.color = size > 1000 ? "#ef4444" : "";
	}

	input.addEventListener("input", updateLength);
	updateLength();

	function checkLogin() {
		if (panel.dataset.loggedIn === "true") {
			return true;
		}

		window.location.href = panel.dataset.loginUrl;
		return false;
	}

	function setProcessing(value) {
		processing = value;
		submit.disabled = value;
		input.readOnly = value;

		submit.style.opacity = value ? "0.6" : "";
		submit.setAttribute("aria-busy", String(value));

		list.querySelectorAll("[data-comment-delete]")
			.forEach(function(button) {
				button.disabled = value;
			});
	}

	async function requestComment(url, params) {
		const response = await fetch(url, {
			method: "POST",
			credentials: "same-origin",
			headers: {
				"Content-Type":
					"application/x-www-form-urlencoded;charset=UTF-8",
				"Accept": "application/json"
			},
			body: params.toString()
		});

		const result = await response.json();

		if (!response.ok || result.success !== true) {
			throw new Error(
				result.message || "댓글 처리에 실패했습니다."
			);
		}

		if (!Array.isArray(result.comments)
			|| !Number.isInteger(result.commentCount)
			|| result.commentCount < 0) {
			throw new Error("댓글 처리 응답을 확인해주세요.");
		}

		return result;
	}

	// 문자열을 HTML로 해석하지 않고 텍스트로 표시
	function createElement(tag, className, text) {
		const element = document.createElement(tag);

		element.className = className;

		if (text !== undefined && text !== null) {
			element.textContent = String(text);
		}

		return element;
	}

	function getProfileUrl(path) {
		if (!path) {
			return null;
		}

		const value = String(path).trim();

		if (/^https?:\/\//i.test(value)) {
			return value;
		}

		// 외부 URL처럼 해석되는 경로나 다른 프로토콜은 제외
		if (value.startsWith("//")
			|| /^[a-z][a-z0-9+.-]*:/i.test(value)) {
			return null;
		}

		if (value.startsWith("/")) {
			return panel.dataset.contextPath + value;
		}

		return panel.dataset.contextPath
			+ "/profiles/" + encodeURIComponent(value);
	}

	function createProfile(comment) {
		const profile = createElement(
			"div",
			"w-10 h-10 rounded-full overflow-hidden shrink-0 "
			+ "flex items-center justify-center"
		);

		profile.style.background = "#F0F0FF";
		profile.style.color = "#6369D1";

		// 고정된 아이콘이며 댓글 내용은 넣지 않음
		function showDefaultProfile() {
			profile.innerHTML =
				'<svg width="22" height="22" viewBox="0 0 24 24"'
				+ ' fill="none" stroke="currentColor" stroke-width="2"'
				+ ' aria-hidden="true">'
				+ '<circle cx="12" cy="8" r="4"/>'
				+ '<path d="M4 21v-2a8 8 0 0 1 16 0v2"/>'
				+ '</svg>';
		}

		const url = getProfileUrl(comment.profileImg);

		if (url) {
			const image = createElement(
				"img",
				"w-full h-full object-cover"
			);

			image.alt = "작성자 프로필";
			image.addEventListener("error", showDefaultProfile, {
				once: true
			});
			image.src = url;

			profile.appendChild(image);
		} else {
			showDefaultProfile();
		}

		return profile;
	}

	function renderComments(comments) {
		const fragment = document.createDocumentFragment();

		if (comments.length === 0) {
			fragment.appendChild(
				createElement(
					"p",
					"py-5 text-center text-[12px] text-gray-400",
					"아직 댓글이 없습니다."
				)
			);
		}

		comments.forEach(function(comment) {
			const article = createElement(
				"article",
				"flex items-start gap-3"
			);

			article.appendChild(createProfile(comment));

			const body = createElement("div", "flex-1 min-w-0");
			const header = createElement(
				"div",
				"flex items-center gap-2 flex-wrap"
			);

			header.appendChild(
				createElement(
					"span",
					"font-bold text-[13px] text-gray-900",
					comment.nickname || ""
				)
			);

			header.appendChild(
				createElement(
					"span",
					"text-[11px] text-gray-400",
					comment.createdAt || ""
				)
			);

			// 본인 댓글에만 삭제 버튼 표시
			if (panel.dataset.loggedIn === "true"
				&& String(comment.userId)
				=== panel.dataset.loginUserId) {

				const deleteButton = createElement(
					"button",
					"ml-auto text-[11px] text-gray-400 hover:text-red-500",
					"삭제"
				);

				deleteButton.type = "button";
				deleteButton.setAttribute("data-comment-delete", "");
				deleteButton.dataset.commentId =
					String(comment.commentId);
				deleteButton.disabled = processing;

				header.appendChild(deleteButton);
			}

			const content = createElement(
				"p",
				"mt-1 text-[13px] text-gray-600",
				comment.content || ""
			);

			content.style.whiteSpace = "pre-wrap";
			content.style.overflowWrap = "anywhere";

			body.appendChild(header);
			body.appendChild(content);
			article.appendChild(body);
			fragment.appendChild(article);
		});

		list.replaceChildren(fragment);
	}

	function updateComments(result) {
		renderComments(result.comments);

		count.textContent =
			result.commentCount.toLocaleString("ko-KR");
	}

	submit.addEventListener("click", async function() {
		if (!checkLogin() || processing) {
			return;
		}

		const content = input.value.trim();

		if (!content) {
			window.tripilyToast("댓글 내용을 입력해주세요.");
			input.focus();
			return;
		}

		if (Array.from(content).length > 1000) {
			window.tripilyToast("댓글은 최대 1,000자까지 입력할 수 있습니다.");
			input.focus();
			return;
		}

		setProcessing(true);

		try {
			const params = new URLSearchParams();

			params.set("itineraryId", panel.dataset.itineraryId);
			params.set("content", content);

			const result = await requestComment(
				panel.dataset.writeUrl,
				params
			);

			updateComments(result);

			input.value = "";
			updateLength();

			window.tripilyToast("댓글을 등록했어요.");

		} catch (error) {
			console.error(error);
			window.tripilyToast(
				error.message || "댓글 등록 중 오류가 발생했습니다."
			);

		} finally {
			setProcessing(false);
		}
	});

	// 새로 추가된 댓글의 삭제 버튼에도 동작하도록 이벤트 위임
	list.addEventListener("click", async function(event) {
		const button = event.target.closest("[data-comment-delete]");

		if (!button || !list.contains(button)) {
			return;
		}

		if (!checkLogin() || processing) {
			return;
		}

		if (!window.confirm("댓글을 삭제할까요?")) {
			return;
		}

		setProcessing(true);

		try {
			const params = new URLSearchParams();

			params.set("itineraryId", panel.dataset.itineraryId);
			params.set("commentId", button.dataset.commentId);

			const result = await requestComment(
				panel.dataset.deleteUrl,
				params
			);

			updateComments(result);

			window.tripilyToast("댓글을 삭제했어요.");

		} catch (error) {
			console.error(error);
			window.tripilyToast(
				error.message || "댓글 삭제 중 오류가 발생했습니다."
			);

		} finally {
			setProcessing(false);
		}
	});

})();

/* 일정 신고 팝업 */
(function() {

	const openButton =
		document.getElementById("scheduleReportButton");

	const modal =
		document.getElementById("scheduleReportModal");

	const form =
		document.getElementById("scheduleReportForm");

	const detail =
		document.getElementById("scheduleReportDetail");

	const length =
		document.getElementById("scheduleReportLength");

	const submit =
		document.getElementById("scheduleReportSubmit");

	const errorText =
		document.getElementById("scheduleReportError");

	const success =
		document.getElementById("scheduleReportSuccess");

	if (!openButton || !modal || !form || !detail
		|| !length || !submit || !errorText || !success) {
		return;
	}

	const closeButtons =
		modal.querySelectorAll("[data-report-close]");

	let processing = false;
	let previousBodyOverflow = "";

	function showError(message) {
		errorText.textContent = message;
		errorText.hidden = !message;
	}

	function updateFormState() {
		const size = Array.from(detail.value).length;

		const selected =
			form.querySelector('input[name="reasonId"]:checked');

		length.textContent = size.toLocaleString("ko-KR");
		length.style.color = size > 300 ? "#ef4444" : "";

		submit.disabled =
			processing || !selected || size > 300;
	}

	function setProcessing(value) {
		processing = value;

		form.querySelectorAll("input, textarea")
			.forEach(function(element) {
				element.disabled = value;
			});

		closeButtons.forEach(function(button) {
			button.disabled = value;
		});

		submit.textContent = value ? "접수 중..." : "신고하기";
		form.setAttribute("aria-busy", String(value));

		updateFormState();
	}

	openButton.addEventListener("click", function(event) {
		event.preventDefault();

		if (openButton.dataset.loggedIn !== "true") {
			window.location.href = openButton.dataset.loginUrl;
			return;
		}

		if (openButton.dataset.isOwner === "true") {
			window.tripilyToast(
				"본인이 작성한 일정은 신고할 수 없습니다."
			);
			return;
		}

		if (modal.open) {
			return;
		}

		form.reset();
		form.hidden = false;
		success.hidden = true;

		showError("");
		setProcessing(false);

		previousBodyOverflow = document.body.style.overflow;

		modal.showModal();
		document.body.style.overflow = "hidden";
	});

	function closeModal() {
		if (!processing && modal.open) {
			modal.close();
		}
	}

	closeButtons.forEach(function(button) {
		button.addEventListener("click", closeModal);
	});

	// Escape 키로 닫기, 제출 중에는 닫기 차단
	modal.addEventListener("cancel", function(event) {
		if (processing) {
			event.preventDefault();
		}
	});

	modal.addEventListener("close", function() {
		document.body.style.overflow = previousBodyOverflow;
		openButton.focus();
	});

	form.addEventListener("change", function() {
		showError("");
		updateFormState();
	});

	detail.addEventListener("input", function() {
		showError("");
		updateFormState();
	});

	form.addEventListener("submit", async function(event) {
		event.preventDefault();

		if (processing) {
			return;
		}

		const selected =
			form.querySelector('input[name="reasonId"]:checked');

		if (!selected) {
			showError("신고 사유를 선택해주세요.");
			return;
		}

		if (Array.from(detail.value).length > 300) {
			showError("상세 내용은 최대 300자까지 입력할 수 있습니다.");
			detail.focus();
			return;
		}

		// 입력을 비활성화하기 전에 요청 데이터 구성
		const params = new URLSearchParams();

		params.set(
			"itineraryId",
			form.elements.namedItem("itineraryId").value
		);

		params.set("reasonId", selected.value);
		params.set("detail", detail.value.trim());

		showError("");
		setProcessing(true);

		try {
			const response = await fetch(form.action, {
				method: "POST",
				credentials: "same-origin",
				headers: {
					"Content-Type":
						"application/x-www-form-urlencoded;charset=UTF-8",
					"Accept": "application/json"
				},
				body: params.toString()
			});

			const result = await response.json();

			if (!response.ok || result.success !== true) {
				throw new Error(
					result.message || "신고 접수에 실패했습니다."
				);
			}

			// DB 저장 성공 후 완료 화면 표시
			form.hidden = true;
			success.hidden = false;

			success.querySelector("button").focus();

		} catch (error) {
			console.error(error);

			showError(
				error.message || "신고 접수 중 오류가 발생했습니다."
			);

		} finally {
			setProcessing(false);

			if (!success.hidden) {
				success.querySelector("button").focus();
			}
		}
	});

	updateFormState();

})();

/* 일정 링크 공유 */
(function () {

    const button =
        document.getElementById("scheduleShareButton");

    if (!button) {
        return;
    }

    button.addEventListener("click", async function () {

        if (button.disabled) {
            return;
        }

        const url = new URL(
            button.dataset.shareUrl,
            window.location.origin
        ).href;

        button.disabled = true;

        try {
            if (!navigator.clipboard || !window.isSecureContext) {
                throw new Error("클립보드 사용 불가");
            }

            await navigator.clipboard.writeText(url);

            window.tripilyToast("링크를 복사했어요.");

        } catch (error) {
            // 자동 복사가 제한된 환경에서는 직접 복사 안내
            window.prompt(
                "아래 링크를 복사해서 공유해주세요.",
                url
            );

        } finally {
            button.disabled = false;
        }
    });

})();

/* 전체 일정·DAY·BLOCK 담기 */
(function () {

    const root = document.getElementById("scheduleDetail");

    if (!root) {
        return;
    }

    let processing = false;

    root.addEventListener("click", async function (event) {

        const button = event.target.closest("[data-cart-add]");

        if (!button || !root.contains(button)) {
            return;
        }

        event.preventDefault();

        if (root.dataset.loggedIn !== "true") {
            window.location.href = root.dataset.loginUrl;
            return;
        }

        if (processing) {
            return;
        }

        const itemType = button.dataset.cartAdd;
        const targetId = button.dataset.targetId;

        if (!targetId || !root.dataset.itineraryId
                || !root.dataset.cartUrl) {
            window.tripilyToast("담기 요청 정보를 확인해주세요.");
            return;
        }

        processing = true;

        // 서로 다른 담기 버튼을 동시에 누르는 것도 방지
        const buttons = Array.from(
            root.querySelectorAll("[data-cart-add]")
        );

        const previousDisabled = buttons.map(function (item) {
            return item.disabled;
        });

        buttons.forEach(function (item) {
            item.disabled = true;
        });

        button.setAttribute("aria-busy", "true");

        try {
            const params = new URLSearchParams();

            params.set("itineraryId", root.dataset.itineraryId);
            params.set("itemType", itemType);
            params.set("targetId", targetId);

            const response = await fetch(root.dataset.cartUrl, {
                method: "POST",
                credentials: "same-origin",
                headers: {
                    "Content-Type":
                        "application/x-www-form-urlencoded;charset=UTF-8",
                    "Accept": "application/json"
                },
                body: params.toString()
            });

            const result = await response.json();

            if (!response.ok || result.success !== true) {
                throw new Error(
                    result.message || "장바구니 담기에 실패했습니다."
                );
            }

            if (typeof result.changed !== "boolean") {
                throw new Error("담기 응답을 확인해주세요.");
            }

            window.tripilyToast(result.message);

            // 헤더 등에서 필요할 때 이 이벤트를 받아 갱신 가능
            window.dispatchEvent(
                new CustomEvent("itinerary-cart-updated", {
                    detail: result
                })
            );

        } catch (error) {
            console.error(error);

            window.tripilyToast(
                error.message || "장바구니 담기 중 오류가 발생했습니다."
            );

        } finally {
            processing = false;

            buttons.forEach(function (item, index) {
                item.disabled = previousDisabled[index];
            });

            button.removeAttribute("aria-busy");
        }
    });

})();