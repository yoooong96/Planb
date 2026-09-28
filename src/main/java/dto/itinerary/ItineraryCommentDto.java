package dto.itinerary;

import java.sql.Timestamp;

public class ItineraryCommentDto {
	private long commentId;		// 댓글 번호
	private long itineraryId;	// 일정 번호
	private long userId;		// 작성 회원
	private String content;		// 댓글 내용
	private String status;		// 댓글 상태
	private Timestamp createdAt;// 작성 일시
	private Timestamp updatedAt;// 수정 일시
	public ItineraryCommentDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ItineraryCommentDto(long commentId, long itineraryId, long userId, String content, String status,
			Timestamp createdAt, Timestamp updatedAt) {
		super();
		this.commentId = commentId;
		this.itineraryId = itineraryId;
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
	public long getItineraryId() {
		return itineraryId;
	}
	public void setItineraryId(long itineraryId) {
		this.itineraryId = itineraryId;
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
		return "ItineraryCommentDto [commentId=" + commentId + ", itineraryId=" + itineraryId + ", userId=" + userId
				+ ", content=" + content + ", status=" + status + ", createdAt=" + createdAt + ", updatedAt="
				+ updatedAt + "]";
	}
	
	
}
