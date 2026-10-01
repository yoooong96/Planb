document.addEventListener("DOMContentLoaded", function () {

    const loginForm =
        document.getElementById("loginForm");

    const loginId =
        document.getElementById("loginId");

    const password =
        document.getElementById("password");

    const passwordToggle =
        document.getElementById("passwordToggle");

    const loginError =
        document.getElementById("loginError");

    const rememberLogin =
        document.getElementById("rememberLogin");


    /* ==========================================
       에러 출력
    ========================================== */

    function showError(input, message) {

        input.classList.add("is-invalid");


        const errorElement =
            document.querySelector(
                '[data-error-for="' + input.id + '"]'
            );


        if (errorElement) {

            errorElement.textContent = message;

        }

    }


    /* ==========================================
       에러 제거
    ========================================== */

    function clearError(input) {

        input.classList.remove("is-invalid");


        const errorElement =
            document.querySelector(
                '[data-error-for="' + input.id + '"]'
            );


        if (errorElement) {

            errorElement.textContent = "";

        }

    }


    /* ==========================================
       전체 에러 제거
    ========================================== */

    function clearAllErrors() {

        clearError(loginId);
        clearError(password);

        loginError.hidden = true;

    }


    /* ==========================================
       비밀번호 보기 / 숨기기
    ========================================== */

    passwordToggle.addEventListener(
        "click",
        function () {

            if (password.type === "password") {

                password.type = "text";

                passwordToggle.textContent = "숨기기";

                passwordToggle.setAttribute(
                    "aria-label",
                    "비밀번호 숨기기"
                );

            } else {

                password.type = "password";

                passwordToggle.textContent = "보기";

                passwordToggle.setAttribute(
                    "aria-label",
                    "비밀번호 보기"
                );

            }

        }
    );


    /* ==========================================
       입력하면 에러 제거
    ========================================== */

    loginId.addEventListener(
        "input",
        function () {

            clearError(loginId);
            loginError.hidden = true;

        }
    );


    password.addEventListener(
        "input",
        function () {

            clearError(password);
            loginError.hidden = true;

        }
    );


    /* ==========================================
       아이디 저장
       브라우저 localStorage 사용
    ========================================== */

    const savedLoginId =
        localStorage.getItem("tripilySavedLoginId");


    if (savedLoginId) {

        loginId.value = savedLoginId;

        rememberLogin.checked = true;

    }


    /* ==========================================
       로그인 제출 검사
    ========================================== */

    loginForm.addEventListener(
        "submit",
        function (event) {

            clearAllErrors();


            let valid = true;


            /* 아이디 */
            if (!loginId.value.trim()) {

                showError(
                    loginId,
                    "아이디를 입력해주세요."
                );

                valid = false;

            }


            /* 비밀번호 */
            if (!password.value) {

                showError(
                    password,
                    "비밀번호를 입력해주세요."
                );

                valid = false;

            }


            /* 유효성 검사 실패 */
            if (!valid) {

                event.preventDefault();

                loginError.textContent =
                    "아이디와 비밀번호를 입력해주세요.";

                loginError.hidden = false;


                const firstInvalid =
                    loginForm.querySelector(
                        ".is-invalid"
                    );


                if (firstInvalid) {

                    firstInvalid.focus();

                }


                return;

            }


            /* 아이디 저장 */
            if (rememberLogin.checked) {

                localStorage.setItem(
                    "tripilySavedLoginId",
                    loginId.value.trim()
                );

            } else {

                localStorage.removeItem(
                    "tripilySavedLoginId"
                );

            }

        }
    );
    
    const loginErrorModal = document.getElementById('loginErrorModal');

	if (loginErrorModal) {
	    loginErrorModal.showModal();
	
	    // 배경(바깥) 클릭 시 닫기
	    loginErrorModal.addEventListener('click', (e) => {
	        if (e.target === loginErrorModal) loginErrorModal.close();
	    });
	
	    // 닫히면 비밀번호 칸으로 포커스
	    loginErrorModal.addEventListener('close', () => {
	        document.getElementById('password')?.focus();
	    });
	}

});

