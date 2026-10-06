const tipLikeForm = document.getElementById("tipLikeForm");
const tipLikeBtn = document.getElementById("tipLikeBtn");
const tipLikeIcon = document.getElementById("tipLikeIcon");
const tipLikeText = document.getElementById("tipLikeText");

if (tipLikeForm) {

    tipLikeForm.addEventListener("submit", function(event) {

        // 기존 form 제출 방지
        event.preventDefault();

        // 연속 클릭 방지
        tipLikeBtn.disabled = true;

        const formData = new URLSearchParams(
		    new FormData(tipLikeForm)
		);
		
		fetch(tipLikeForm.action, {
		    method: "POST",
		    headers: {
		        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
		    },
		    body: formData.toString()
		})
        .then(function(response) {

            // 로그인하지 않은 경우
            if (response.status === 401) {
                window.location.href = tipLikeForm.dataset.loginUrl;
                return null;
            }

            if (!response.ok) {
                throw new Error("좋아요 처리 실패");
            }

            return response.json();
        })
        .then(function(data) {

            if (data === null) {
                return;
            }

            if (!data.success) {
                throw new Error("좋아요 처리 실패");
            }

            // 좋아요 개수 변경
            tipLikeText.textContent = "좋아요 " + data.likeCount;

            // 하트 상태 변경
            if (data.liked) {
                tipLikeIcon.setAttribute("fill", "currentColor");
            } else {
                tipLikeIcon.setAttribute("fill", "none");
            }
        })
        .catch(function(error) {

            console.error(error);
            alert("좋아요 처리 중 오류가 발생했습니다.");

        })
        .finally(function() {

            tipLikeBtn.disabled = false;

        });
    });
}