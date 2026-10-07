// ================================
// 제목 글자 수
// ================================

const titleInput = document.querySelector("[data-char-input]");
const titleCount = document.querySelector("[data-char-count]");

if (titleInput && titleCount) {

	titleInput.addEventListener("input", function () {
		titleCount.textContent = this.value.length;
	});
}


// ================================
// 모집 인원
// ================================

const recruitMinus = document.getElementById("recruitMinus");
const recruitPlus = document.getElementById("recruitPlus");
const recruitCount = document.getElementById("recruitCount");

if (recruitMinus && recruitPlus && recruitCount) {

	recruitMinus.addEventListener("click", function () {

		let count = Number(recruitCount.value);

		if (count > 1) {
			recruitCount.value = count - 1;
		}
	});

	recruitPlus.addEventListener("click", function () {

		let count = Number(recruitCount.value);

		if (count < 99) {
			recruitCount.value = count + 1;
		}
	});
}

// ================================
// 사진 첨부
// ================================

const mateImages = document.getElementById("mateImages");
const mateImagePreview = document.getElementById("mateImagePreview");

// 실제 전송할 이미지들을 누적해서 보관
let selectedFiles = [];

mateImages.addEventListener("change", function () {

	const newFiles = Array.from(this.files);

	// 새로 선택한 파일 추가
	for (const file of newFiles) {

		// 이미지만 허용
		if (!file.type.startsWith("image/")) {
			continue;
		}

		// 최대 5장
		if (selectedFiles.length >= 5) {
			alert("사진은 최대 5장까지 첨부할 수 있습니다.");
			break;
		}

		selectedFiles.push(file);
	}

	// 실제 input.files도 누적된 파일들로 다시 설정
	updateInputFiles();

	// 미리보기 다시 출력
	renderImagePreview();

	console.log("실제 전송될 사진 수:", mateImages.files.length);
	console.log(Array.from(mateImages.files));
});


/**
 * selectedFiles 배열을 실제 <input type="file">에 반영
 */
function updateInputFiles() {

	const dataTransfer = new DataTransfer();

	selectedFiles.forEach(function (file) {
		dataTransfer.items.add(file);
	});

	mateImages.files = dataTransfer.files;
}


/**
 * 이미지 미리보기 출력
 */
function renderImagePreview() {

	// 기존 미리보기 초기화
	mateImagePreview.innerHTML = "";

	selectedFiles.forEach(function (file) {

		const reader = new FileReader();

		reader.onload = function (e) {

			const preview = document.createElement("div");

			preview.style.position = "relative";
			preview.style.overflow = "hidden";
			preview.style.borderRadius = "12px";
			preview.style.border = "1px solid #D1D2F9";
			preview.style.background = "#f9fafb";

			// 반응형 크기
			preview.style.width = "clamp(120px, 18vw, 180px)";
			preview.style.aspectRatio = "4 / 3";
			preview.style.flex = "0 0 auto";

			const img = document.createElement("img");

			img.src = e.target.result;
			img.alt = "첨부 이미지 미리보기";

			img.style.width = "100%";
			img.style.height = "100%";
			img.style.objectFit = "cover";
			img.style.display = "block";

			preview.appendChild(img);
			mateImagePreview.appendChild(preview);
		};

		reader.readAsDataURL(file);
	});
}