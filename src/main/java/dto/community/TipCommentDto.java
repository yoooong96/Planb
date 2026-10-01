package dto.community;

import java.time.LocalDateTime;

public class TipCommentDto {
	private Long commentId;			// 댓글 번호
	private Long tipId;				// 꿀팁 게시글 번호
	private Long userId;			// 작성 회원
	private String content;			// 댓글 내용
	private String status;			// 댓글 상태
	private LocalDateTime createdAt;// 작성 일시
	private LocalDateTime updatedAt;// 수정 일시
	public TipCommentDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TipCommentDto(Long commentId, Long tipId, Long userId, String content, String status,
			LocalDateTime createdAt, LocalDateTime updatedAt) {
		super();
		this.commentId = commentId;
		this.tipId = tipId;
		this.userId = userId;
		this.content = content;
		this.status = status;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}
	public Long getCommentId() {
		return commentId;
	}
	public void setCommentId(Long commentId) {
		this.commentId = commentId;
	}
	public Long getTipId() {
		return tipId;
	}
	public void setTipId(Long tipId) {
		this.tipId = tipId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}
	@Override
	public String toString() {
		return "TipCommentDto [commentId=" + commentId + ", tipId=" + tipId + ", userId=" + userId + ", content="
				+ content + ", status=" + status + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + "]";
	}
	
}
