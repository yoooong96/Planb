/**
 * 
 */// ========================================
// 수정 페이지 - 기존 이미지 삭제
// ========================================
document.addEventListener("DOMContentLoaded", function() {

	const existingImageList =
		document.getElementById("existingImageList");

	if (!existingImageList) {
		return;
	}

	const form =
		existingImageList.closest("form");

	if (!form) {
		return;
	}

	existingImageList.addEventListener("click", function(event) {

		const deleteButton =
			event.target.closest(".existing-image-delete");

		if (!deleteButton) {
			return;
		}

		const mediaId =
			deleteButton.dataset.mediaId;

		const imageItem =
			deleteButton.closest(".existing-image-item");

		if (!mediaId || !imageItem) {
			return;
		}

		// 삭제할 mediaId를 서버로 보내기 위한 hidden input
		const hiddenInput =
			document.createElement("input");

		hiddenInput.type = "hidden";
		hiddenInput.name = "deletedMediaIds";
		hiddenInput.value = mediaId;

		form.appendChild(hiddenInput);

		// 화면에서 이미지 제거
		imageItem.remove();
	});
});