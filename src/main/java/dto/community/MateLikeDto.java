package dto.community;

import java.time.LocalDateTime;

public class MateLikeDto {
	private Long mateId;				// 메이트 게시글 번호
	private Long userId;				// 회원 번호
	private LocalDateTime createdAt;	// 좋아요 일시
	public MateLikeDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MateLikeDto(Long mateId, Long userId, LocalDateTime createdAt) {
		super();
		this.mateId = mateId;
		this.userId = userId;
		this.createdAt = createdAt;
	}
	public Long getMateId() {
		return mateId;
	}
	public void setMateId(Long mateId) {
		this.mateId = mateId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "MateLikeDto [mateId=" + mateId + ", userId=" + userId + ", createdAt=" + createdAt + "]";
	}
	
}
