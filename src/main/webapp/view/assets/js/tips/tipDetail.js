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
        const formData = new URLSearchParams(new FormData(tipLikeForm));
		
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

		    if (!data.success) {
		        throw new Error("LIKE_FAILED");
		    }		
		
		    // 화면에 표시된 모든 좋아요 개수 즉시 변경
			const likeCountElements =
			    document.querySelectorAll(".tip-like-count");
			
			likeCountElements.forEach(function(element) {
			    element.textContent = data.likeCount;
			});
		
		
		    if (data.liked) {

			    tipLikeIcon.setAttribute(
			        "fill",
			        "currentColor"
			    );
			
			    tipLikeBtn.classList.add("active");
			
			} else {
			
			    tipLikeIcon.setAttribute(
			        "fill",
			        "none"
			    );
			
			    tipLikeBtn.classList.remove("active");
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
// =========================
// 댓글 등록
// =========================
const tipCommentForm = document.getElementById("tipCommentForm");

if (tipCommentForm) {
    tipCommentForm.addEventListener("submit", function(e) {
        e.preventDefault();
        const commentInput = document.getElementById("tipCommentContent");
        const content = commentInput.value.trim();
        // 빈 댓글 방지
        if (content === "") {
            alert("댓글을 입력해주세요.");
            commentInput.focus();
            return;
        }
        const submitButton = tipCommentForm.querySelector('button[type="submit"]');
        // 중복 등록 방지
        submitButton.disabled = true;
        const formData = new URLSearchParams( new FormData(tipCommentForm));

        fetch(tipCommentForm.action, {
            method: "POST",
            headers: {
                "Content-Type":
                    "application/x-www-form-urlencoded; charset=UTF-8"
            },
            body: formData.toString()
        })
        .then(function(response) {
            if (response.status === 401) {
                throw new Error("LOGIN_REQUIRED");
            }
            if (!response.ok) {
                throw new Error("COMMENT_WRITE_FAILED");
            }
            return response.json();
        })
        .then(function(data) {
            if (!data.success) {
                throw new Error("COMMENT_WRITE_FAILED");
            }
            /*
             * 우선 DB 저장 성공 여부를 확실하게 확인하기 위해
             * 상세페이지를 다시 불러온다.
             *
             * replace가 아니라 reload이므로
             * 현재 tipId 주소는 그대로 유지된다.
             */
            window.location.reload();
        })
        .catch(function(error) {
            if (error.message === "LOGIN_REQUIRED") {
                alert("로그인이 필요합니다.");
                return;
            }
            console.error(error);
            alert("댓글 등록 중 오류가 발생했습니다.");
        })
        .finally(function() {
            submitButton.disabled = false;
        });
    });
}

// =========================
// 댓글 수정 / 삭제
// =========================
const tipCommentList = document.getElementById("tipCommentList");

if (tipCommentList) {
    tipCommentList.addEventListener("click", function(e) {
        // =========================
		// 수정 시작
		// =========================
		const editButton = e.target.closest(".tip-comment-edit");
		
		if (editButton) {
		    const commentItem = editButton.closest("[data-comment-id]");
		    if (commentItem.classList.contains("editing")) {
		        return;
		    }
		    const contentElement = commentItem.querySelector(".tip-comment-content");
		    const currentContent = contentElement.textContent.trim();
		    commentItem.classList.add("editing");
		
		    // 기존 댓글 숨김
		    contentElement.style.display = "none";
		
		    // 기존 수정/삭제 버튼 숨김
		    const originalEditButton = commentItem.querySelector(".tip-comment-edit");
		    const originalDeleteButton = commentItem.querySelector(".tip-comment-delete");
		
		    originalEditButton.style.display = "none";
		    originalDeleteButton.style.display = "none";
		
		    // 수정 영역 생성
		    const editArea = document.createElement("div");
		
		    editArea.className = "tip-comment-edit-area mt-2";
		
		    editArea.innerHTML =
		        '<div class="flex items-center gap-2">' +
		            '<input type="text" ' +
		                'class="tip-comment-edit-input ' +
		                'jsp-focus flex-1 min-w-0 ' +
		                'text-sm text-gray-700 outline-none ' +
		                'border border-gray-200 rounded-xl ' +
		                'px-3 py-2 transition-all">' +
		            '<button type="button" ' +
		                'class="tip-comment-save shrink-0 ' +
		                'text-xs font-semibold">' +
		                '저장' +
		            '</button>' +
		            '<button type="button" ' +
		                'class="tip-comment-cancel shrink-0 ' +
		                'text-xs text-gray-400">' +
		                '취소' +
		            '</button>' +
		        '</div>';
		    contentElement.after(editArea);
		    const input = editArea.querySelector(".tip-comment-edit-input");
		    const saveButton = editArea.querySelector(".tip-comment-save");
		    const cancelButton = editArea.querySelector(".tip-comment-cancel");
		
		    input.value = currentContent;
		    input.focus();
		    input.setSelectionRange(
		        input.value.length,
		        input.value.length
		    );
		    // =========================
		    // 저장
		    // =========================
		    saveButton.addEventListener("click", function() {
		        const newContent = input.value.trim();
		        if (newContent === "") {
		            alert("댓글 내용을 입력해주세요.");
		            input.focus();
		            return;
		        }
		        saveButton.disabled = true;
		        const params = new URLSearchParams();
		
		        params.append("commentId", commentItem.dataset.commentId);
		        params.append("content", newContent);
		
		        fetch(
		            getContextPath() + "/tipCommentUpdate",
		            {
		                method: "POST",
		                headers: {
		                    "Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
		                },
						body: params.toString()
		            }
		        )
		        .then(function(response) {
		            if (response.status === 401) {
		                throw new Error("LOGIN_REQUIRED");
		            }
		            if (response.status === 403) {
		                throw new Error("FORBIDDEN");
		            }
		            if (!response.ok) {
		                throw new Error("UPDATE_FAILED");
		            }
		            return response.json();
		        })
		        .then(function(data) {
		
		            if (!data.success) {
		                throw new Error("UPDATE_FAILED");
		            }
		            // 수정된 내용 반영
		            contentElement.textContent = newContent;
		            
		            // =========================
				    // (수정됨) 표시
				    // =========================
				    const timeElement = commentItem.querySelector(".tip-comment-time");
				    if (
				        timeElement &&
				        !timeElement.querySelector(".tip-comment-edited")
				    ) {
				        const editedElement = document.createElement("span");
				        editedElement.className = "tip-comment-edited ml-1";
				
				        editedElement.textContent = "(수정됨)";
				
				        timeElement.appendChild(editedElement);
				    }
		            closeCommentEdit(commentItem);
		        })
		        .catch(function(error) {
		
		            saveButton.disabled = false;
		            console.error(error);
		            if (error.message === "LOGIN_REQUIRED") {
		                alert("로그인이 필요합니다.");
		                return;
		            }
		            if (error.message === "FORBIDDEN") {
		                alert("본인이 작성한 댓글만 수정할 수 있습니다.");
		                return;
		            }
		            alert("댓글 수정 중 오류가 발생했습니다.");
		        });
		
		    });
		    // =========================
		    // 취소
		    // =========================
		    cancelButton.addEventListener("click", function() {
		        closeCommentEdit(commentItem);
		    });
		
		    // Enter 키로 저장
		    input.addEventListener("keydown", function(event) {
		        if (event.key === "Enter") {
		            event.preventDefault();
		            saveButton.click();
		        }
		        // ESC로 취소
		        if (event.key === "Escape") {
		            event.preventDefault();
		            cancelButton.click();
		        }
		    });
		    return;
		}
        // =========================
        // 댓글 삭제
        // =========================
        const deleteButton = e.target.closest(".tip-comment-delete");
        if (deleteButton) {
            const commentItem = deleteButton.closest("[data-comment-id]");
            const commentId = commentItem.dataset.commentId;
            const confirmed = confirm("댓글을 삭제하시겠습니까?");
            if (!confirmed) {
                return;
            }
            const params = new URLSearchParams();
            params.append("commentId", commentId);
            fetch(
                window.location.origin
                + window.location.pathname.substring(
                    0,
                    window.location.pathname.indexOf("/", 1)
                )
                + "/tipCommentDelete",
                {
                    method: "POST",
                    headers: {
                        "Content-Type":
                            "application/x-www-form-urlencoded; charset=UTF-8"
                    },
                    body: params.toString()
                }
            )
            .then(function(response) {
                if (response.status === 401) {
                    throw new Error("LOGIN_REQUIRED");
                }
                if (response.status === 403) {
                    throw new Error("FORBIDDEN");
                }
                if (!response.ok) {
                    throw new Error("DELETE_FAILED");
                }
                return response.json();
            })
            .then(function(data) {

                if (!data.success) {
                    throw new Error("DELETE_FAILED");
                }
                // 화면에서 바로 제거
                commentItem.remove();
                updateCommentCount();
            })
            .catch(function(error) {
                if (error.message === "LOGIN_REQUIRED") {
                    alert("로그인이 필요합니다.");
                    return;
                }
                if (error.message === "FORBIDDEN") {
                    alert("본인이 작성한 댓글만 삭제할 수 있습니다.");
                    return;
                }
                console.error(error);
                alert("댓글 삭제 중 오류가 발생했습니다.");
            });
        }
    });
}

// =========================
// 댓글 수정 화면 닫기
// =========================
function closeCommentEdit(commentItem) {
    const contentElement = commentItem.querySelector(".tip-comment-content");
    const editArea = commentItem.querySelector(".tip-comment-edit-area");
    const editButton = commentItem.querySelector(".tip-comment-edit");
    const deleteButton = commentItem.querySelector(".tip-comment-delete");

    // 수정 입력창 제거
    if (editArea) {
        editArea.remove();
    }
    // 기존 댓글 내용 다시 표시
    if (contentElement) {
        contentElement.style.display = "";
    }
    // 수정 버튼 다시 표시
    if (editButton) {
        editButton.style.display = "";
    }
    // 삭제 버튼 다시 표시
    if (deleteButton) {
        deleteButton.style.display = "";
    }
    // 수정 상태 해제
    commentItem.classList.remove("editing");
}

// =========================
// Context Path
// =========================
function getContextPath() {
    const path = window.location.pathname;
    const secondSlash =
        path.indexOf("/", 1);
    if (secondSlash === -1) {
        return "";
    }
    return path.substring(0, secondSlash);
}

// =========================
// 댓글 개수 화면 갱신
// =========================
function updateCommentCount() {
    const commentList =  document.getElementById("tipCommentList");
    if (!commentList) {
        return;
    }
    // 현재 화면에 남아있는 실제 댓글 개수
    const comments = commentList.querySelectorAll("[data-comment-id]");
    const count = comments.length;

    // 화면의 모든 댓글 카운트 변경
    const countElements = document.querySelectorAll(".tip-comment-count");

    countElements.forEach(function(element) {
        element.textContent = count;
    });
    // 마지막 댓글까지 삭제한 경우
    if (count === 0) {
        commentList.innerHTML =
            '<div class="py-6 text-center text-sm text-gray-400">' +
                '아직 작성된 댓글이 없습니다.' +
            '</div>';
    }
}

// =========================
// 게시글 삭제
// =========================
const tipDeleteButton = document.getElementById("tipDeleteButton");

if (tipDeleteButton) {
    tipDeleteButton.addEventListener("click", function() {
        const confirmed = confirm("게시글을 삭제하시겠습니까?");
        if (!confirmed) {
            return;
        }
        const tipId = tipDeleteButton.dataset.tipId;
        const params = new URLSearchParams();
        params.append("tipId", tipId);
        // 중복 클릭 방지
        tipDeleteButton.disabled = true;
        fetch(
            getContextPath() + "/tipDelete",
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
                },
                body: params.toString()
            }
        )
        .then(function(response) {
            if (response.status === 401) {
                throw new Error("LOGIN_REQUIRED");
            }
            if (response.status === 403) {
                throw new Error("FORBIDDEN");
            }
            if (response.status === 404) {
                throw new Error("NOT_FOUND");
            }
            if (!response.ok) {
                throw new Error("DELETE_FAILED");
            }
            return response.json();
        })
        .then(function(data) {
            if (!data.success) {
                throw new Error("DELETE_FAILED");
            }
            // 삭제 성공 → 여행꿀팁 목록으로 이동
            window.location.href = getContextPath() + "/tips";
        })
        .catch(function(error) {
            tipDeleteButton.disabled = false;
            console.error(error);
            if (error.message === "LOGIN_REQUIRED") {
                alert("로그인이 필요합니다.");
                return;
            }
            if (error.message === "FORBIDDEN") {
                alert("본인이 작성한 게시글만 삭제할 수 있습니다.");
                return;
            }
            if (error.message === "NOT_FOUND") {
                alert("존재하지 않는 게시글입니다.");
                return;
            }
            alert("게시글 삭제 중 오류가 발생했습니다.");
        });
    });
}

