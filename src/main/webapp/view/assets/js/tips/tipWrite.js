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

// ========================================
// 여행지 나라 / 도시 선택
// ========================================

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
	
	"홍콩": [
		"야우침몽구",
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


// ========================================
// DOM
// ========================================

const tipWriteForm =
	document.querySelector('form[action$="/tipWrite"]');

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
// 나라 추천 표시
// ========================================
function renderCountrySuggestions() {

	const keyword =
		countryInput.value.trim();

	countrySuggestions.innerHTML = "";

	// 아무것도 입력하지 않았으면 추천 태그 표시 안 함
	if (keyword === "") {
		return;
	}

	const countries =
		Object.keys(travelLocations);

	const matchedCountries =
		countries.filter(function(country) {
			return country.includes(keyword);
		});

	matchedCountries.forEach(function(country) {

		const button =
			createSuggestionButton(
				country,
				function() {
					selectCountry(country);
				}
			);

		countrySuggestions.appendChild(button);
	});
}

// 나라 입력
countryInput.addEventListener("input", function() {

	// 직접 다시 입력하면 선택값 초기화
	countryValue.value = "";

	// 나라가 바뀌었으므로 도시도 초기화
	cityInput.value = "";
	cityValue.value = "";
	cityInput.disabled = true;

	citySuggestions.innerHTML = "";

	clearCountryError();
	clearCityError();

	renderCountrySuggestions();
});

// ========================================
// 나라 선택
// ========================================

function selectCountry(country) {

	countryInput.value =
		country;

	countryValue.value =
		country;

	countrySuggestions.innerHTML =
		"";

	clearCountryError();

	// 나라 선택 후 도시 입력 활성화
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


// ========================================
// 도시 검색
// ========================================

cityInput.addEventListener("input", function() {

	const keyword =
		this.value.trim();

	cityValue.value =
		"";

	citySuggestions.innerHTML =
		"";

	clearCityError();

	const selectedCountry =
		countryValue.value;

	if (!selectedCountry) {
		return;
	}

	if (keyword === "") {
		return;
	}

	const cities =
		travelLocations[selectedCountry] || [];

	const matchedCities =
		cities.filter(function(city) {

			return city.includes(keyword);
		});

	matchedCities.forEach(function(city) {

		const button =
			createSuggestionButton(
				city,
				function() {
					selectCity(city);
				}
			);

		citySuggestions.appendChild(
			button
		);
	});
});


// ========================================
// 도시 선택
// ========================================

function selectCity(city) {

	cityInput.value =
		city;

	cityValue.value =
		city;

	citySuggestions.innerHTML =
		"";

	clearCityError();
}


// ========================================
// 나라 오류 표시
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


// ========================================
// 도시 오류 표시
// ========================================

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
// 등록 전 나라 / 도시 최종 검증
// ========================================

tipWriteForm.addEventListener("submit", function(event) {

	const selectedCountry =
		countryValue.value.trim();

	const selectedCity =
		cityValue.value.trim();

	// 나라 미선택
	if (selectedCountry === "") {

		event.preventDefault();

		showCountryError();

		countryInput.scrollIntoView({
			behavior: "smooth",
			block: "center"
		});

		setTimeout(function() {
			countryInput.focus();
		}, 300);

		return;
	}

	// 도시 미선택
	if (selectedCity === "") {

		event.preventDefault();

		showCityError();

		cityInput.scrollIntoView({
			behavior: "smooth",
			block: "center"
		});

		setTimeout(function() {
			cityInput.focus();
		}, 300);

		return;
	}
});

// ========================================
// 본문이 비어있을 때 커서를 맨 앞으로 이동
// ========================================
const contentTextarea =
	document.querySelector('textarea[name="content"]');

if (contentTextarea) {

	contentTextarea.addEventListener("click", function () {

		if (this.value.length === 0) {
			this.setSelectionRange(0, 0);
		}
	});
}