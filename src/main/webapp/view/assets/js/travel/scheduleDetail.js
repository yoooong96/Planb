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