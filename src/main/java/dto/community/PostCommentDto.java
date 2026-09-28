package dto.community;

import java.sql.Timestamp;

public class PostCommentDto {
	private long commentId;		// 댓글 번호
	private long postId;		// 게시글 번호
	private long userId;		// 작성 회원
	private String content;		// 댓글 내용
	private String status;		// 댓글 상태
	private Timestamp createdAt;// 작성 일시
	private Timestamp updatedAt;// 수정 일시
	public PostCommentDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PostCommentDto(long commentId, long postId, long userId, String content, String status, Timestamp createdAt,
			Timestamp updatedAt) {
		super();
		this.commentId = commentId;
		this.postId = postId;
		this.userId = userId;
		this.content = content;
		this.status = status;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}
	public long getCommentId() {
		return commentId;
	}
	public void setCommentId(long commentId) {
		this.commentId = commentId;
	}
	public long getPostId() {
		return postId;
	}
	public void setPostId(long postId) {
		this.postId = postId;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
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
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public Timestamp getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
	@Override
	public String toString() {
		return "PostCommentDto [commentId=" + commentId + ", postId=" + postId + ", userId=" + userId + ", content="
				+ content + ", status=" + status + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + "]";
	}
	
	
}
