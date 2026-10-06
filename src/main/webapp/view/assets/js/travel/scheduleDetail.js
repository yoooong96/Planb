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