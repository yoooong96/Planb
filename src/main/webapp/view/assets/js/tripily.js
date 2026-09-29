(function() {

	/* =========================================================
	   공통 DOM 함수
	========================================================= */

	const qs = (selector, root = document) => {
		return root.querySelector(selector);
	};

	const qsa = (selector, root = document) => {
		return [...root.querySelectorAll(selector)];
	};


	/* =========================================================
	   Toast 메시지
	========================================================= */

	window.tripilyToast = function(message) {

		let toast = qs("#tripilyToast");

		if (!toast) {
			toast = document.createElement("div");
			toast.id = "tripilyToast";
			toast.className = "toast";

			document.body.appendChild(toast);
		}

		toast.textContent = message;
		toast.classList.add("show");

		clearTimeout(window.__tripilyToastTimer);

		window.__tripilyToastTimer = setTimeout(function() {
			toast.classList.remove("show");
		}, 2200);
	};


	/* =========================================================
	   Controller 연결 전 Demo Submit
	========================================================= */

	window.tripilyDemoSubmit = function(event, message) {

		if (event) {
			event.preventDefault();
		}

		tripilyToast(
			message ||
			"샘플 화면입니다. Controller 연결 후 실제 처리됩니다."
		);

		return false;
	};


	/* =========================================================
	   Modal
	========================================================= */

	window.openModal = function(id) {

		const modal = document.getElementById(id);

		if (modal) {
			modal.classList.add("open");
		}
	};


	window.closeModal = function(id) {

		const modal = document.getElementById(id);

		if (modal) {
			modal.classList.remove("open");
		}
	};


	/* =========================================================
	   공통 Click Event
	========================================================= */

	document.addEventListener("click", function(event) {

		/* -------------------------
		   Modal 열기
		------------------------- */

		const openButton = event.target.closest("[data-modal-open]");

		if (openButton) {

			openModal(openButton.dataset.modalOpen);

			return;
		}


		/* -------------------------
		   Modal 닫기
		------------------------- */

		const closeButton = event.target.closest("[data-modal-close]");

		if (closeButton) {

			closeModal(closeButton.dataset.modalClose);

			return;
		}


		/* -------------------------
		   Switch
		------------------------- */

		const switchButton = event.target.closest(".switch");

		if (switchButton) {

			switchButton.classList.toggle("on");

			switchButton.setAttribute(
				"aria-checked",
				switchButton.classList.contains("on")
			);

			return;
		}


		/* -------------------------
		   FAQ
		------------------------- */

		const faqQuestion = event.target.closest(".faq-q");

		if (faqQuestion) {

			faqQuestion.parentElement.classList.toggle("open");

			return;
		}


		/* -------------------------
		   Tab
		------------------------- */

		const tab = event.target.closest("[data-tab]");

		if (tab) {

			const group = tab.dataset.tabGroup || "default";

			/*
			 * 같은 그룹의 모든 탭 비활성화
			 */
			qsa(`[data-tab-group="${group}"]`).forEach(function(item) {
				item.classList.remove("active");
			});

			/*
			 * 선택한 탭 활성화
			 */
			tab.classList.add("active");

			const target = tab.dataset.tab;

			/*
			 * 해당 그룹의 모든 패널 숨김
			 */
			qsa(`[data-tab-panel-group="${group}"]`).forEach(
				function(panel) {
					panel.classList.add("hidden");
				}
			);

			/*
			 * 선택한 패널 표시
			 */
			const targetPanel = qs(
				`[data-tab-panel="${target}"]`
			);

			if (targetPanel) {
				targetPanel.classList.remove("hidden");
			}

			return;
		}


		/* -------------------------
		   삭제 등 확인 메시지
		------------------------- */

		const confirmButton = event.target.closest("[data-confirm]");

		if (confirmButton) {

			const message = confirmButton.dataset.confirm;

			if (!confirm(message)) {
				event.preventDefault();
			}
		}
	});


	/* =========================================================
	   이미지 미리보기
	========================================================= */

	document.addEventListener("change", function(event) {

		const input = event.target.closest(
			"[data-image-preview]"
		);

		if (
			input &&
			input.files &&
			input.files[0]
		) {

			const image = document.getElementById(
				input.dataset.imagePreview
			);

			if (image) {

				image.src = URL.createObjectURL(
					input.files[0]
				);

				image.classList.remove("hidden");
			}
		}
	});


	/* =========================================================
	   중복 확인 Demo
	   회원가입 닉네임 / 이메일 등
	========================================================= */

	qsa("[data-demo-duplicate]").forEach(function(button) {

		button.addEventListener("click", function() {

			const fieldId = button.dataset.demoDuplicate;

			const field = document.getElementById(fieldId);

			if (!field || !field.value.trim()) {

				tripilyToast(
					"값을 먼저 입력해주세요."
				);

				return;
			}

			tripilyToast(
				"사용 가능한 값입니다."
			);
		});
	});


	/* =========================================================
	   회원가입 Form Demo 검증
	========================================================= */

	qsa("[data-signup-form]").forEach(function(form) {

		form.addEventListener("submit", function(event) {

			event.preventDefault();

			let isValid = true;


			/* -------------------------
			   필수 입력값 검사
			------------------------- */

			qsa("[data-required]", form).forEach(
				function(element) {

					const wrapper =
						element.closest(".field") ||
						element.parentElement;

					let errorText =
						wrapper.querySelector(".error-text");


					if (!element.value.trim()) {

						isValid = false;

						if (!errorText) {

							errorText =
								document.createElement("p");

							errorText.className =
								"error-text";

							wrapper.appendChild(
								errorText
							);
						}

						errorText.textContent =
							"필수 항목입니다.";

					} else if (errorText) {

						errorText.remove();
					}
				}
			);


			/* -------------------------
			   비밀번호 확인
			------------------------- */

			const password =
				qs("#password", form);

			const passwordConfirm =
				qs("#passwordConfirm", form);


			if (
				password &&
				passwordConfirm &&
				password.value !== passwordConfirm.value
			) {

				isValid = false;

				tripilyToast(
					"비밀번호 확인이 일치하지 않습니다."
				);
			}


			/* -------------------------
			   검증 완료
			------------------------- */

			if (isValid) {

				tripilyToast(
					"입력 검증 완료! 회원가입 Controller에 연결하면 됩니다."
				);
			}
		});
	});

})();