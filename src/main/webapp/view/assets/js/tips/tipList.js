document.querySelectorAll("[data-continent-toggle]").forEach(button => {

	button.addEventListener("click", function() {

		const continent = this.dataset.continentToggle;

		const panel = document.querySelector(
			`[data-continent-panel="${continent}"]`
		);

		if (panel) {
			panel.classList.toggle("hidden");

			if (panel.classList.contains("hidden")) {
				panel.style.display = "none";
			} else {
				panel.style.display = "block";
			}
		}

		const chevron = this.querySelector(".continent-chevron");

		if (chevron) {
			chevron.classList.toggle("rotate-180");
		}
	});
});

// 현재 선택된 나라가 속한 대륙 토글 유지
const countryContinentMap = {

	// 아시아
	"대한민국": "asia",
	"일본": "asia",
	"중국": "asia",
	"대만": "asia",
	"홍콩": "asia",
	"태국": "asia",
	"베트남": "asia",
	"필리핀": "asia",
	"싱가포르": "asia",
	"말레이시아": "asia",
	"인도네시아": "asia",

	// 유럽
	"그리스": "europe",
	"독일": "europe",
	"스페인": "europe",
	"영국": "europe",
	"이탈리아": "europe",
	"포르투갈": "europe",
	"프랑스": "europe",

	// 북아메리카
	"멕시코": "north-america",
	"미국": "north-america",
	"캐나다": "north-america",

	// 남아메리카
	"브라질": "south-america",
	"아르헨티나": "south-america",
	"칠레": "south-america",
	"페루": "south-america",

	// 아프리카
	"남아프리카": "africa",
	"모로코": "africa",
	"이집트": "africa",
	"케냐": "africa",

	// 오세아니아
	"뉴질랜드": "oceania",
	"피지": "oceania",
	"호주": "oceania",

	// 중동
	"UAE": "middle-east",
	"터키": "middle-east",
	"이스라엘": "middle-east"
};

if (window.selectedCountry) {

	const continent = countryContinentMap[window.selectedCountry];

	if (continent) {

		const panel = document.querySelector(
			`[data-continent-panel="${continent}"]`
		);

		const button = document.querySelector(
			`[data-continent-toggle="${continent}"]`
		);

		if (panel) {
			panel.classList.remove("hidden");
			panel.style.display = "block";
		}

		if (button) {
			const chevron = button.querySelector(".continent-chevron");

			if (chevron) {
				chevron.classList.add("rotate-180");
			}
		}
	}
}