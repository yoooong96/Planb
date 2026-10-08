(function() {

	const cart = document.getElementById("headerCart");
	const badge = document.getElementById("headerCartBadge");

	if (!cart || !badge) {
		return;
	}

	const countUrl = cart.dataset.countUrl;

	if (!countUrl) {
		return;
	}

	// 여러 요청이 겹쳐도 가장 최근 요청의 결과만 표시
	let requestNumber = 0;

	async function refreshCartCount() {

		const currentRequest = ++requestNumber;

		try {
			const response = await fetch(countUrl, {
				method: "GET",
				credentials: "same-origin",
				cache: "no-store",
				headers: {
					"Accept": "application/json"
				}
			});

			const result = await response.json();

			if (!response.ok || result.success !== true) {
				throw new Error(
					result.message ||
					"장바구니 개수를 불러오지 못했습니다."
				);
			}

			const count = result.cartCount;

			if (!Number.isInteger(count) || count < 0) {
				throw new Error(
					"장바구니 개수 응답을 확인해주세요."
				);
			}

			if (currentRequest !== requestNumber) {
				return;
			}

			badge.textContent = count > 99 ? "99+" : String(count);
			badge.style.display = count > 0 ? "inline-flex" : "none";

			const link = cart.querySelector("a");

			if (link) {
				link.setAttribute(
					"aria-label",
					"일정 장바구니, " + count + "개의 일정"
				);
			}

		} catch (error) {
			console.error(error);
		}
	}

	// 처음 화면을 열었을 때 조회
	refreshCartCount();

	// 담기 성공 후 다시 조회
	window.addEventListener(
		"itinerary-cart-updated",
		refreshCartCount
	);

})();