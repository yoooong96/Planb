document.addEventListener("DOMContentLoaded", function () {

    const form = document.getElementById("signupForm");

    const loginId = document.getElementById("loginId");
    const password = document.getElementById("password");
    const passwordConfirm = document.getElementById("passwordConfirm");

    const name = document.getElementById("name");
    const nickname = document.getElementById("nickname");
    const email = document.getElementById("email");
    const phone = document.getElementById("phone");

    const postcode = document.getElementById("postcode");
    const address = document.getElementById("address");
    const addressDetail = document.getElementById("addressDetail");

    const profileImage = document.getElementById("profileImage");
    const profilePreview = document.getElementById("profilePreview");

    const bio = document.getElementById("bio");
    const bioCounter = document.getElementById("bioCounter");

    const signupError = document.getElementById("signupError");
    const postcodeButton = document.getElementById("postcodeButton");


    /* ==============================================
       에러 처리
    ============================================== */

    function showError(input, message) {

        input.classList.add("is-invalid");

        const error = document.querySelector(
            '[data-error-for="' + input.id + '"]'
        );

        if (error) {
            error.textContent = message;
        }
    }


    function clearError(input) {

        input.classList.remove("is-invalid");

        const error = document.querySelector(
            '[data-error-for="' + input.id + '"]'
        );

        if (error) {
            error.textContent = "";
        }
    }


    function clearAllErrors() {

        document.querySelectorAll(".is-invalid").forEach(function (element) {
            element.classList.remove("is-invalid");
        });

        document.querySelectorAll(".field-error").forEach(function (element) {
            element.textContent = "";
        });

        signupError.hidden = true;
    }


    /* ==============================================
       전화번호 자동 포맷
    ============================================== */

    phone.addEventListener("input", function () {

        let value = this.value.replace(/[^0-9]/g, "");

        if (value.length > 11) {
            value = value.substring(0, 11);
        }

        if (value.length < 4) {

            this.value = value;

        } else if (value.length < 8) {

            this.value =
                value.substring(0, 3)
                + "-"
                + value.substring(3);

        } else {

            this.value =
                value.substring(0, 3)
                + "-"
                + value.substring(3, 7)
                + "-"
                + value.substring(7, 11);
        }
    });


    /* ==============================================
       소개글 글자수
    ============================================== */

    bio.addEventListener("input", function () {

        bioCounter.textContent =
            this.value.length + " / 300";
    });


    /* ==============================================
       프로필 이미지 미리보기
    ============================================== */

    profileImage.addEventListener("change", function () {

        clearError(profileImage);

        const file = this.files[0];

        if (!file) {

            profilePreview.innerHTML = "<span>사진</span>";

            return;
        }


        const allowedTypes = [
            "image/jpeg",
            "image/png",
            "image/webp"
        ];


        if (!allowedTypes.includes(file.type)) {

            showError(
                profileImage,
                "JPG, PNG, WEBP 이미지 파일만 사용할 수 있습니다."
            );

            this.value = "";

            profilePreview.innerHTML = "<span>사진</span>";

            return;
        }


        const maxFileSize = 5 * 1024 * 1024;


        if (file.size > maxFileSize) {

            showError(
                profileImage,
                "프로필 이미지는 5MB 이하만 등록할 수 있습니다."
            );

            this.value = "";

            profilePreview.innerHTML = "<span>사진</span>";

            return;
        }


        const reader = new FileReader();


        reader.onload = function (event) {

            profilePreview.innerHTML =
                '<img src="' +
                event.target.result +
                '" alt="프로필 이미지 미리보기">';

        };


        reader.readAsDataURL(file);

    });


    /* ==============================================
       주소 검색
    ============================================== */

    postcodeButton.addEventListener("click", function () {

        if (
            typeof kakao === "undefined"
            || typeof kakao.Postcode === "undefined"
        ) {

            alert(
                "주소 검색 서비스를 불러오지 못했습니다.\n"
                + "잠시 후 다시 시도해주세요."
            );

            return;
        }


        new kakao.Postcode({

            oncomplete: function (data) {

                let selectedAddress = "";


                if (data.userSelectedType === "R") {

                    selectedAddress = data.roadAddress;

                } else {

                    selectedAddress = data.jibunAddress;
                }


                postcode.value = data.zonecode;
                address.value = selectedAddress;


                clearError(postcode);
                clearError(address);


                addressDetail.focus();
            }

        }).open();

    });


    /* ==============================================
       입력 시 에러 해제
    ============================================== */

    const inputs = form.querySelectorAll(
        "input, textarea"
    );


    inputs.forEach(function (input) {

        input.addEventListener("input", function () {

            clearError(this);

        });

    });


    /* ==============================================
       회원가입 Validation
    ============================================== */

    form.addEventListener("submit", function (event) {

        clearAllErrors();


        let valid = true;


        /*
         * 아이디
         *
         * 4~20자
         * 영문 / 숫자 / _
         */
        const loginIdPattern =
            /^[A-Za-z0-9_]{4,20}$/;


        if (!loginId.value.trim()) {

            showError(
                loginId,
                "아이디를 입력해주세요."
            );

            valid = false;

        } else if (
            !loginIdPattern.test(loginId.value.trim())
        ) {

            showError(
                loginId,
                "아이디는 영문, 숫자, 밑줄(_)을 사용하여 4~20자로 입력해주세요."
            );

            valid = false;
        }


        /*
         * 비밀번호
         *
         * 최소 8자
         * 영문 + 숫자
         */
        const passwordPattern =
            /^(?=.*[A-Za-z])(?=.*\d).{8,}$/;


        if (!password.value) {

            showError(
                password,
                "비밀번호를 입력해주세요."
            );

            valid = false;

        } else if (
            !passwordPattern.test(password.value)
        ) {

            showError(
                password,
                "비밀번호는 영문과 숫자를 포함하여 8자 이상 입력해주세요."
            );

            valid = false;
        }


        /*
         * 비밀번호 확인
         */
        if (!passwordConfirm.value) {

            showError(
                passwordConfirm,
                "비밀번호 확인을 입력해주세요."
            );

            valid = false;

        } else if (
            password.value !== passwordConfirm.value
        ) {

            showError(
                passwordConfirm,
                "비밀번호가 일치하지 않습니다."
            );

            valid = false;
        }


        /*
         * 이름
         */
        if (!name.value.trim()) {

            showError(
                name,
                "이름을 입력해주세요."
            );

            valid = false;
        }


        /*
         * 닉네임
         */
        if (!nickname.value.trim()) {

            showError(
                nickname,
                "닉네임을 입력해주세요."
            );

            valid = false;

        } else if (
            nickname.value.trim().length < 2
        ) {

            showError(
                nickname,
                "닉네임은 2자 이상 입력해주세요."
            );

            valid = false;
        }


        /*
         * 이메일
         */
        if (!email.value.trim()) {

            showError(
                email,
                "이메일을 입력해주세요."
            );

            valid = false;

        } else if (!email.validity.valid) {

            showError(
                email,
                "올바른 이메일 형식으로 입력해주세요."
            );

            valid = false;
        }


        /*
         * 전화번호
         */
        const phonePattern =
            /^01[016789]-\d{3,4}-\d{4}$/;


        if (!phone.value.trim()) {

            showError(
                phone,
                "전화번호를 입력해주세요."
            );

            valid = false;

        } else if (
            !phonePattern.test(phone.value)
        ) {

            showError(
                phone,
                "올바른 전화번호를 입력해주세요."
            );

            valid = false;
        }


        /*
         * 우편번호
         */
        if (!postcode.value.trim()) {

            showError(
                postcode,
                "우편번호를 입력해주세요."
            );

            valid = false;
        }


        /*
         * 주소
         */
        if (!address.value.trim()) {

            showError(
                address,
                "주소를 입력해주세요."
            );

            valid = false;
        }


        /*
         * Validation 실패
         */
        if (!valid) {

            event.preventDefault();

            signupError.hidden = false;


            const firstInvalid =
                form.querySelector(".is-invalid");


            if (firstInvalid) {

                firstInvalid.focus();

                firstInvalid.scrollIntoView({
                    behavior: "smooth",
                    block: "center"
                });
            }
        }

    });

});