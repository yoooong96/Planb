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
/* =========================================================
   FIGMA 통합본 공통 헤더 상호작용
========================================================= */
(function () {
  const toggle = document.querySelector('[data-notification-toggle]');
  const popover = document.querySelector('[data-notification-popover]');
  if (toggle && popover) {
    toggle.addEventListener('click', function (e) {
      e.stopPropagation();
      const willOpen = popover.hasAttribute('hidden');
      if (willOpen) popover.removeAttribute('hidden'); else popover.setAttribute('hidden', '');
      toggle.setAttribute('aria-expanded', willOpen ? 'true' : 'false');
      toggle.classList.toggle('active', willOpen);
    });
    popover.addEventListener('click', function (e) { e.stopPropagation(); });
    document.addEventListener('click', function () {
      popover.setAttribute('hidden', '');
      toggle.setAttribute('aria-expanded', 'false');
      toggle.classList.remove('active');
    });
  }
})();

/* Home interactions from 통합본(9) */
(function(){
  var carousel=document.querySelector('[data-home-carousel]');
  if(carousel){
    var paused=false;
    carousel.addEventListener('mouseenter',function(){paused=true;});
    carousel.addEventListener('mouseleave',function(){paused=false;});
    function step(){ if(!paused){ carousel.scrollLeft+=0.7; var loopWidth=Number(carousel.getAttribute('data-loop-width'))||((carousel.scrollWidth)/2); if(carousel.scrollLeft>=loopWidth) carousel.scrollLeft=0; } requestAnimationFrame(step); }
    requestAnimationFrame(step);
  }
  document.querySelectorAll('[data-bookmark]').forEach(function(btn){ btn.addEventListener('click',function(e){e.preventDefault();e.stopPropagation();btn.classList.toggle('saved');}); });
  var scroll=document.querySelector('[data-scroll-popular]');
  var scroll = document.querySelector('[data-scroll-popular]');

	if (scroll) {
	    scroll.addEventListener('click', function () {
	        var target = document.getElementById('popularPlans');
	        if (target) {
	            var targetPosition = target.getBoundingClientRect().top + window.pageYOffset;
	
	            window.scrollTo({
	                top: targetPosition - 130,
	                behavior: 'smooth'
	            });
	        }
	    });
	}
})();

/* 여행꿀팁 + 여행메이트 게시글/진행바 로테이션 */
document.querySelectorAll('[data-rotate-group]').forEach(function (rotateGroup) {

    const pages = rotateGroup.querySelectorAll('.home-rotate-page');

    const progressWrap = rotateGroup.nextElementSibling;
    const bars = progressWrap.querySelectorAll('.home-progress-bar');

    let current = 0;

    // 진행바가 차는 시간
    const duration = 3000;

    // 게시글 전환 시간
    const fadeDuration = 150;


    function startProgress(index) {

        // 진행바 전부 초기화
        bars.forEach(function (bar) {
            bar.style.backgroundColor = '#e5e7eb';
            bar.innerHTML = '';
        });

        // 현재 진행바 채움 생성
        const fill = document.createElement('span');

        fill.style.position = 'absolute';
        fill.style.left = '0';
        fill.style.top = '0';
        fill.style.height = '100%';
        fill.style.width = '0%';
        fill.style.backgroundColor = '#FFD447';
        fill.style.borderRadius = '9999px';

        bars[index].appendChild(fill);

        // 0% → 100%
        requestAnimationFrame(function () {
            requestAnimationFrame(function () {

                fill.style.transition =
                    'width ' + duration + 'ms linear';

                fill.style.width = '100%';

            });
        });
    }


    function changePage() {

        const oldPage = pages[current];

        // 현재 게시글 살짝 사라짐
        oldPage.style.transition =
            'opacity ' + fadeDuration + 'ms ease';

        oldPage.style.opacity = '0';


        setTimeout(function () {

            oldPage.style.display = 'none';

            // 다음 페이지
            current = (current + 1) % pages.length;

            const newPage = pages[current];

            newPage.style.display = 'flex';
            newPage.style.opacity = '0';

            newPage.style.transition =
                'opacity ' + fadeDuration + 'ms ease';


            // 다음 게시글 살짝 나타남
            requestAnimationFrame(function () {
                requestAnimationFrame(function () {
                    newPage.style.opacity = '1';
                });
            });


            // 다음 진행바 시작
            startProgress(current);


            // 다시 3초 후 다음 페이지
            setTimeout(changePage, duration);

        }, fadeDuration);
    }


    // 처음 상태 설정
    pages.forEach(function (page, i) {

        if (i === 0) {

            page.style.display = 'flex';
            page.style.opacity = '1';

        } else {

            page.style.display = 'none';
            page.style.opacity = '0';

        }

    });


    // 첫 번째 진행바 시작
    startProgress(current);

    // 첫 번째 로테이션 시작
    setTimeout(changePage, duration);

});

/* =========================================================
   통합본(9) JSP 화면 상호작용
========================================================= */
(function () {
  function all(selector, root) { return Array.prototype.slice.call((root || document).querySelectorAll(selector)); }

  all('.continent-toggle').forEach(function (button) {
    button.addEventListener('click', function () {
      var panel = button.parentElement && button.parentElement.querySelector('.continent-panel');
      if (!panel) return;
      panel.classList.toggle('open');
      button.classList.toggle('open');
    });
  });

  var filterToggle = document.getElementById('scheduleFilterToggle');
  var filterPanel = document.getElementById('scheduleFilterPanel');
  var filterBar = document.getElementById('scheduleSearchBar');
  if (filterToggle && filterPanel) {
    filterToggle.addEventListener('click', function (event) {
      event.preventDefault();
      event.stopPropagation();
      filterPanel.classList.toggle('hidden');
      if (filterBar) filterBar.style.borderColor = filterPanel.classList.contains('hidden') ? '#D1D2F9' : '#6369D1';
    });
    filterPanel.addEventListener('click', function (event) { event.stopPropagation(); });
    document.addEventListener('click', function () {
      filterPanel.classList.add('hidden');
      if (filterBar) filterBar.style.borderColor = '#D1D2F9';
    });
  }

  all('[data-chip-group]').forEach(function (group) {
    all('button', group).forEach(function (button) {
      button.addEventListener('click', function () {
        all('button', group).forEach(function (item) {
          item.classList.remove('bg-[#6369D1]', 'border-[#6369D1]', 'text-white');
          if (!item.classList.contains('bg-white')) item.classList.add('bg-gray-100');
          item.classList.add('text-gray-500');
        });
        button.classList.remove('bg-gray-100', 'text-gray-500');
        button.classList.add('bg-[#6369D1]', 'border-[#6369D1]', 'text-white');
      });
    });
  });

  all('[data-tab-group]').forEach(function (group) {
    all('button', group).forEach(function (button) {
      button.addEventListener('click', function () {
        all('button', group).forEach(function (item) {
          item.classList.remove('text-[#6369D1]', 'border-b-2', 'border-[#6369D1]', 'font-black');
          item.classList.add('text-gray-400', 'font-bold');
        });
        button.classList.remove('text-gray-400', 'font-bold');
        button.classList.add('text-[#6369D1]', 'border-b-2', 'border-[#6369D1]', 'font-black');
      });
    });
  });

  all('[data-read-all]').forEach(function (button) {
    button.addEventListener('click', function () {
      all('.unread').forEach(function (item) { item.classList.remove('unread'); });
      if (window.tripilyToast) window.tripilyToast('모든 알림을 읽음 처리했습니다.');
    });
  });

  all('[data-char-input]').forEach(function (input) {
    function sync() {
      var counterId = input.getAttribute('data-char-input');
      var counter = counterId ? document.getElementById(counterId) : input.parentElement && input.parentElement.querySelector('[data-char-count]');
      if (counter) counter.textContent = String(input.value.length);
    }
    input.addEventListener('input', sync);
    sync();
  });
})();
