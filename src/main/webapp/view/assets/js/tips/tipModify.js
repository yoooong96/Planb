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

// ========================================
// 수정 페이지 - 여행지 나라 / 도시
// ========================================
document.addEventListener("DOMContentLoaded", function () {

	const travelLocations = {

		"대한민국": [
			"서울",
			"부산",
			"제주",
			"경주",
			"강릉",
			"인천",
			"전주",
			"여수"
		],

		"일본": [
			"도쿄",
			"오사카",
			"교토",
			"후쿠오카",
			"삿포로",
			"오키나와",
			"나고야"
		],

		"중국": [
			"베이징",
			"상하이",
			"칭다오",
			"광저우"
		],

		"대만": [
			"타이베이",
			"타이중",
			"가오슝"
		],

		"태국": [
			"방콕",
			"치앙마이",
			"푸켓",
			"파타야"
		],

		"베트남": [
			"다낭",
			"하노이",
			"호치민",
			"나트랑"
		],

		"싱가포르": [
			"싱가포르"
		],

		"미국": [
			"뉴욕",
			"로스앤젤레스",
			"샌프란시스코",
			"라스베이거스",
			"하와이"
		],

		"캐나다": [
			"밴쿠버",
			"토론토",
			"몬트리올"
		],

		"프랑스": [
			"파리",
			"니스",
			"리옹",
			"마르세유"
		],

		"이탈리아": [
			"로마",
			"밀라노",
			"베네치아",
			"피렌체"
		],

		"스페인": [
			"바르셀로나",
			"마드리드",
			"세비야"
		],

		"영국": [
			"런던",
			"맨체스터",
			"에든버러"
		],

		"독일": [
			"베를린",
			"뮌헨",
			"프랑크푸르트"
		],

		"호주": [
			"시드니",
			"멜버른",
			"브리즈번",
			"골드코스트"
		]
	};


	const form =
		document.querySelector('form[action$="/tipModify"]');

	const countryInput =
		document.getElementById("countryInput");

	const countryValue =
		document.getElementById("country");

	const countrySuggestions =
		document.getElementById("countrySuggestions");

	const countryError =
		document.getElementById("countryError");

	const cityInput =
		document.getElementById("cityInput");

	const cityValue =
		document.getElementById("city");

	const citySuggestions =
		document.getElementById("citySuggestions");

	const cityError =
		document.getElementById("cityError");


	if (
		!form
		|| !countryInput
		|| !countryValue
		|| !cityInput
		|| !cityValue
	) {
		return;
	}


	// ========================================
	// 추천 태그 생성
	// ========================================
	function createSuggestionButton(text, clickHandler) {

		const button =
			document.createElement("button");

		button.type = "button";
		button.textContent = text;

		button.style.padding = "6px 12px";
		button.style.borderRadius = "9999px";
		button.style.border = "1px solid #D1D2F9";
		button.style.background = "#FAFAFF";
		button.style.color = "#6369D1";
		button.style.fontSize = "12px";
		button.style.fontWeight = "600";
		button.style.cursor = "pointer";

		button.addEventListener(
			"click",
			clickHandler
		);

		return button;
	}


	// ========================================
// 나라 추천
// ========================================
function renderCountrySuggestions() {

	const keyword =
		countryInput.value.trim();

	countrySuggestions.innerHTML = "";

	// 아무것도 입력하지 않았으면 태그 표시 안 함
	if (keyword === "") {
		return;
	}

	Object.keys(travelLocations).forEach(function (country) {

		if (!country.includes(keyword)) {
			return;
		}

		const button =
			createSuggestionButton(
				country,
				function () {

					countryInput.value =
						country;

					countryValue.value =
						country;

					countrySuggestions.innerHTML =
						"";

					clearCountryError();

					// 나라 선택 후 도시 다시 선택
					cityInput.disabled =
						false;

					cityInput.value =
						"";

					cityValue.value =
						"";

					citySuggestions.innerHTML =
						"";

					cityInput.focus();
				}
			);

		countrySuggestions.appendChild(
			button
		);
	});
}

// ========================================
// 나라 입력
// ========================================
countryInput.addEventListener("input", function () {

	// 직접 타이핑하기 시작하면 기존 선택값 해제
	countryValue.value = "";

	// 나라를 변경하는 중이므로 기존 도시도 해제
	cityInput.value = "";
	cityValue.value = "";
	cityInput.disabled = true;

	countrySuggestions.innerHTML = "";
	citySuggestions.innerHTML = "";

	clearCountryError();
	clearCityError();

	renderCountrySuggestions();
});

// ========================================
// 도시 검색
// ========================================
cityInput.addEventListener("input", function () {

	const keyword =
		this.value.trim();

	cityValue.value = "";

	citySuggestions.innerHTML = "";

	clearCityError();

	const selectedCountry =
			countryValue.value;

	if (
		selectedCountry === ""
		|| keyword === ""
	) {
		return;
	}

	const cities =
		travelLocations[selectedCountry] || [];

	const matchedCities =
		cities.filter(function (city) {
			return city.includes(keyword);
		});

	matchedCities.forEach(function (city) {

		const button =
			createSuggestionButton(
				city,
					function () {

					cityInput.value =
						city;

					cityValue.value =
						city;

					citySuggestions.innerHTML =
							"";

					clearCityError();
				}
			);

		citySuggestions.appendChild(
			button
		);
	});
});


	// ========================================
	// 오류 표시
	// ========================================
	function showCountryError() {

		countryInput.style.border =
			"1.5px solid #ef4444";

		countryError.classList.remove(
			"hidden"
		);
	}


	function clearCountryError() {

		countryInput.style.border =
			"1.5px solid #D1D2F9";

		countryError.classList.add(
			"hidden"
		);
	}


	function showCityError() {

		cityInput.style.border =
			"1.5px solid #ef4444";

		cityError.classList.remove(
			"hidden"
		);
	}


	function clearCityError() {

		cityInput.style.border =
			"1.5px solid #D1D2F9";

		cityError.classList.add(
			"hidden"
		);
	}


	// ========================================
	// 수정하기 전 최종 검사
	// ========================================
	form.addEventListener("submit", function (event) {

		if (countryValue.value.trim() === "") {

			event.preventDefault();

			showCountryError();

			countryInput.scrollIntoView({
				behavior: "smooth",
				block: "center"
			});

			setTimeout(function () {
				countryInput.focus();
			}, 300);

			return;
		}


		if (cityValue.value.trim() === "") {

			event.preventDefault();

			showCityError();

			cityInput.scrollIntoView({
				behavior: "smooth",
				block: "center"
			});

			setTimeout(function () {
				cityInput.focus();
			}, 300);
		}
	});

});

console.log("tipModify.js 로드됨");

document.addEventListener("DOMContentLoaded", function () {

	console.log("여행지 JS 시작");

	const countryInput =
		document.getElementById("countryInput");

	const countrySuggestions =
		document.getElementById("countrySuggestions");

	console.log("countryInput =", countryInput);
	console.log("countrySuggestions =", countrySuggestions);

});