package dto.community;

import java.sql.Timestamp;

public class PostLikeDto {
	private long postId;			// 게시글 번호
	private long userId;			// 회원 번호
	private Timestamp createdAt;	// 좋아요 일시
	public PostLikeDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PostLikeDto(long postId, long userId, Timestamp createdAt) {
		super();
		this.postId = postId;
		this.userId = userId;
		this.createdAt = createdAt;
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
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "PostLikeDto [postId=" + postId + ", userId=" + userId + ", createdAt=" + createdAt + "]";
	}
	
	
}
