// =========================
// 내가 작성한 여행메이트 삭제
// =========================
const mateDeleteButtons =
	document.querySelectorAll(".mate-write-list-delete-btn");

mateDeleteButtons.forEach(function(deleteButton) {

	deleteButton.addEventListener("click", function(event) {

		event.preventDefault();
		event.stopPropagation();

		const confirmed =
			confirm("게시글을 삭제하시겠습니까?");

		if (!confirmed) {
			return;
		}

		const mateId =
			deleteButton.dataset.mateId;

		const params =
			new URLSearchParams();

		params.append("mateId", mateId);

		deleteButton.disabled = true;

		fetch(
			getContextPath() + "/mateDelete",
			{
				method: "POST",

				headers: {
					"Content-Type":
						"application/x-www-form-urlencoded; charset=UTF-8"
				},

				body: params.toString()
			}
		)
		.then(function(response) {

			if (response.status === 401) {
				throw new Error("LOGIN_REQUIRED");
			}

			if (response.status === 403) {
				throw new Error("FORBIDDEN");
			}

			if (response.status === 404) {
				throw new Error("NOT_FOUND");
			}

			if (!response.ok) {
				throw new Error("DELETE_FAILED");
			}

			return response.json();
		})
		.then(function(data) {

			if (!data.success) {
				throw new Error("DELETE_FAILED");
			}

			window.location.reload();

		})
		.catch(function(error) {

			deleteButton.disabled = false;

			console.error(error);

			if (error.message === "LOGIN_REQUIRED") {
				alert("로그인이 필요합니다.");
				return;
			}

			if (error.message === "FORBIDDEN") {
				alert("본인이 작성한 게시글만 삭제할 수 있습니다.");
				return;
			}

			if (error.message === "NOT_FOUND") {
				alert("존재하지 않는 게시글입니다.");
				return;
			}

			alert("게시글 삭제 중 오류가 발생했습니다.");
		});

	});

});


function getContextPath() {

	const path =
		window.location.pathname;

	const secondSlash =
		path.indexOf("/", 1);

	if (secondSlash === -1) {
		return "";
	}

	return path.substring(
		0,
		secondSlash
	);
}