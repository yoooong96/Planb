document.addEventListener("DOMContentLoaded", function () {

	var mateLikeButton = document.getElementById("mateLikeButton");
	var mateLikeMateId = document.getElementById("mateLikeMateId");
	var mateLikeCount = document.getElementById("mateLikeCount");

	if (!mateLikeButton || !mateLikeMateId || !mateLikeCount) {
		return;
	}

	var mateLikeIcon = mateLikeButton.querySelector(".mate-like-icon");

	mateLikeButton.addEventListener("click", function () {

		mateLikeButton.disabled = true;

		fetch("/Planb/mateLike", {
			method: "POST",
			headers: {
				"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
			},
			body: "mateId=" + encodeURIComponent(mateLikeMateId.value)
		})
		.then(function (response) {

			if (!response.ok) {
				throw new Error("HTTP 오류: " + response.status);
			}

			return response.json();
		})
		.then(function (data) {

			if (!data.success) {
				throw new Error("좋아요 처리 실패");
			}

			mateLikeCount.textContent = data.likeCount;

			if (data.liked) {
				mateLikeButton.classList.add("active");

				if (mateLikeIcon) {
					mateLikeIcon.setAttribute("fill", "currentColor");
				}
			} else {
				mateLikeButton.classList.remove("active");

				if (mateLikeIcon) {
					mateLikeIcon.setAttribute("fill", "none");
				}
			}

			mateLikeButton.disabled = false;
		})
		.catch(function (error) {

			console.error("Mate 좋아요 오류:", error);

			alert("좋아요 처리 중 오류가 발생했습니다.\n" + error.message);

			mateLikeButton.disabled = false;
		});

	});

});

// =========================
// 댓글 등록
// =========================

var mateCommentForm = document.getElementById("mateCommentForm");

if (mateCommentForm) {

	mateCommentForm.addEventListener("submit", function(e) {

		e.preventDefault();

		var commentInput = document.getElementById("mateCommentContent");
		var content = commentInput.value.trim();

		if (content === "") {
			alert("댓글을 입력해주세요.");
			commentInput.focus();
			return;
		}

		var submitButton = mateCommentForm.querySelector('button[type="submit"]');

		submitButton.disabled = true;

		var formData = new URLSearchParams(
			new FormData(mateCommentForm)
		);

		fetch(mateCommentForm.action, {
			method: "POST",
			headers: {
				"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
			},
			body: formData.toString()
		})
		.then(function(response) {

			if (response.status === 401) {
				throw new Error("LOGIN_REQUIRED");
			}

			if (!response.ok) {
				throw new Error("COMMENT_WRITE_FAILED");
			}

			return response.json();
		})
		.then(function(data) {

			if (!data.success) {
				throw new Error("COMMENT_WRITE_FAILED");
			}

			window.location.reload();
		})
		.catch(function(error) {

			if (error.message === "LOGIN_REQUIRED") {
				alert("로그인이 필요합니다.");
				return;
			}

			console.error(error);
			alert("댓글 등록 중 오류가 발생했습니다.");
		})
		.then(function() {
			submitButton.disabled = false;
		});

	});

}