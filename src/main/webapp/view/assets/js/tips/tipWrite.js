const tipImages = document.getElementById("tipImages");
const tipImagePreview = document.getElementById("tipImagePreview");

// 실제 전송할 이미지들을 누적해서 보관
let selectedFiles = [];

tipImages.addEventListener("change", function () {

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

    console.log("실제 전송될 사진 수:", tipImages.files.length);
    console.log(Array.from(tipImages.files));
});


/**
 * selectedFiles 배열을 실제 <input type="file">에 반영
 */
function updateInputFiles() {

    const dataTransfer = new DataTransfer();

    selectedFiles.forEach(function (file) {
        dataTransfer.items.add(file);
    });

    tipImages.files = dataTransfer.files;
}


/**
 * 이미지 미리보기 출력
 */
function renderImagePreview() {

    // 기존 미리보기 초기화
    tipImagePreview.innerHTML = "";

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
            tipImagePreview.appendChild(preview);
        };

        reader.readAsDataURL(file);
    });
}