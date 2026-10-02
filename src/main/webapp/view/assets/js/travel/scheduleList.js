(function () {

    document.addEventListener("click", function (event) {

        const button =
            event.target.closest("[data-schedule-bookmark]");

        if (!button) {
            return;
        }

        event.preventDefault();
        event.stopPropagation();

        if (button.dataset.loggedIn !== "true") {
            window.tripilyToast("로그인 후 이용할 수 있습니다.");
            return;
        }

        if (button.dataset.loading === "true") {
            return;
        }

        toggleBookmark(button);
    });

    async function toggleBookmark(button) {

        const itineraryId = button.dataset.itineraryId;
        const url = button.dataset.bookmarkUrl;

        if (!itineraryId || !url) {
            window.tripilyToast(
                "북마크 요청 정보를 확인해주세요."
            );
            return;
        }

        button.dataset.loading = "true";
        button.disabled = true;
        button.setAttribute("aria-busy", "true");

        try {
            const params = new URLSearchParams();

            params.set("itineraryId", itineraryId);

            const response = await fetch(url, {
                method: "POST",
                credentials: "same-origin",
                headers: {
                    "Content-Type":
                        "application/x-www-form-urlencoded;charset=UTF-8",
                    "Accept": "application/json"
                },
                body: params.toString()
            });

            const result = await response.json();

            if (!response.ok || result.success !== true) {
                throw new Error(
                    result.message || "북마크 처리에 실패했습니다."
                );
            }

            if (typeof result.bookmarked !== "boolean") {
                throw new Error("서버 응답을 확인해주세요.");
            }

            updateBookmarkButton(button, result.bookmarked);

            window.tripilyToast(
                result.bookmarked
                    ? "일정을 북마크했어요."
                    : "북마크를 해제했어요."
            );

        } catch (error) {
            console.error(error);

            window.tripilyToast(
                error.message || "북마크 처리 중 오류가 발생했습니다."
            );

        } finally {
            delete button.dataset.loading;

            button.disabled = false;
            button.removeAttribute("aria-busy");
        }
    }

    function updateBookmarkButton(button, bookmarked) {

        button.setAttribute(
            "aria-pressed",
            String(bookmarked)
        );

        button.setAttribute(
            "aria-label",
            bookmarked ? "북마크 해제" : "북마크 추가"
        );

        const icon = button.querySelector("svg");

        if (icon) {
            icon.setAttribute(
                "fill",
                bookmarked ? "#6369D1" : "none"
            );

            icon.setAttribute(
                "stroke",
                bookmarked ? "#6369D1" : "#9ca3af"
            );
        }
    }

})();