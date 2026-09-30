/* ========================================
   HOME - Main Hero
======================================== */

/* 메인 배너 높이 자동 계산 */
(function () {

    function setHomeHeroHeight() {

        const header = document.querySelector('header');

        if (!header) {
            return;
        }

        const headerHeight = header.getBoundingClientRect().height;

        document.documentElement.style.setProperty(
            '--header-height',
            headerHeight + 'px'
        );
    }

    setHomeHeroHeight();

    window.addEventListener('resize', setHomeHeroHeight);

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