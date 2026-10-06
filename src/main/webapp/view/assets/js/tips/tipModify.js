document.addEventListener("DOMContentLoaded", function () {

    const tipImages =
        document.getElementById("tipImages");

    const tipImagePreview =
        document.getElementById("tipImagePreview");

    const existingImageList =
        document.getElementById("existingImageList");

    const deletedMediaInputs =
        document.getElementById("deletedMediaInputs");

    if (!tipImages || !tipImagePreview) {
        return;
    }

    // 새로 선택한 이미지
    const selectedFiles = [];


    // ========================================
    // 현재 남아있는 기존 이미지 개수
    // ========================================
    function getExistingImageCount() {

        if (!existingImageList) {
            return 0;
        }

        return existingImageList.querySelectorAll(
            ".existing-image-item"
        ).length;
    }


    // ========================================
    // 기존 이미지 X 버튼
    // ========================================
    if (existingImageList) {

        existingImageList.addEventListener(
            "click",
            function (e) {

                const deleteButton =
                    e.target.closest(
                        ".existing-image-delete"
                    );

                if (!deleteButton) {
                    return;
                }

                const mediaId =
                    deleteButton.dataset.mediaId;

                const imageItem =
                    deleteButton.closest(
                        ".existing-image-item"
                    );

                if (!mediaId || !imageItem) {
                    return;
                }


                // 서버로 삭제할 mediaId 전달
                if (deletedMediaInputs) {

                    const hiddenInput =
                        document.createElement("input");

                    hiddenInput.type = "hidden";
                    hiddenInput.name = "deletedMediaIds";
                    hiddenInput.value = mediaId;

                    deletedMediaInputs.appendChild(
                        hiddenInput
                    );
                }


                // 화면에서 제거
                imageItem.remove();
            }
        );
    }


    // ========================================
    // 새 이미지 선택
    // ========================================
    tipImages.addEventListener(
        "change",
        function () {

            const newFiles =
                Array.from(this.files);

            let overLimit = false;


            newFiles.forEach(function (file) {

                // 이미지 파일만 허용
                if (!file.type.startsWith("image/")) {
                    return;
                }


                // 기존 + 신규 이미지 개수
                const totalCount =
                    getExistingImageCount()
                    + selectedFiles.length;


                // 최대 5장
                if (totalCount >= 5) {
                    overLimit = true;
                    return;
                }


                selectedFiles.push(file);
            });


            if (overLimit) {

                alert(
                    "사진은 기존 사진과 새 사진을 합쳐 최대 5장까지 첨부할 수 있습니다."
                );
            }


            updateInputFiles();
            renderPreview();
        }
    );


    // ========================================
    // 실제 input.files 갱신
    // ========================================
    function updateInputFiles() {

        const dataTransfer =
            new DataTransfer();


        selectedFiles.forEach(function (file) {

            dataTransfer.items.add(file);
        });


        tipImages.files =
            dataTransfer.files;
    }


    // ========================================
    // 새 이미지 미리보기
    // ========================================
    function renderPreview() {

        tipImagePreview.innerHTML = "";


        selectedFiles.forEach(
            function (file, index) {

                const reader =
                    new FileReader();


                reader.onload =
                    function (e) {

                        const preview =
                            document.createElement(
                                "div"
                            );


                        preview.className =
                            "relative overflow-hidden rounded-xl border bg-gray-50";

                        preview.style.borderColor =
                            "#D1D2F9";

                        preview.style.aspectRatio =
                            "4 / 3";


                        preview.innerHTML = `
                            <img
                                src="${e.target.result}"
                                alt="새로 선택한 이미지"
                                class="w-full h-full object-cover"
                            >

                            <button
                                type="button"
                                class="
                                    new-image-delete
                                    absolute
                                    top-2
                                    right-2
                                    w-7
                                    h-7
                                    rounded-full
                                    bg-black/60
                                    text-white
                                    flex
                                    items-center
                                    justify-center
                                "
                                data-index="${index}"
                                aria-label="선택 이미지 삭제"
                            >
                                ×
                            </button>
                        `;


                        tipImagePreview.appendChild(
                            preview
                        );
                    };


                reader.readAsDataURL(file);
            }
        );
    }


    // ========================================
    // 새로 선택한 이미지 X 버튼
    // ========================================
    tipImagePreview.addEventListener(
        "click",
        function (e) {

            const deleteButton =
                e.target.closest(
                    ".new-image-delete"
                );


            if (!deleteButton) {
                return;
            }


            const index =
                Number(
                    deleteButton.dataset.index
                );


            if (Number.isNaN(index)) {
                return;
            }


            selectedFiles.splice(
                index,
                1
            );


            updateInputFiles();
            renderPreview();
        }
    );

});