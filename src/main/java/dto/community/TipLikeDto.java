package dto.community;

import java.time.LocalDateTime;

public class TipLikeDto {
	private Long tipId;				// 꿀팁 게시글 번호
	private Long userId;			// 회원 번호
	private LocalDateTime createdAt;// 좋아요 일시
	public TipLikeDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TipLikeDto(Long tipId, Long userId, LocalDateTime createdAt) {
		super();
		this.tipId = tipId;
		this.userId = userId;
		this.createdAt = createdAt;
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
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "TipLikeDto [tipId=" + tipId + ", userId=" + userId + ", createdAt=" + createdAt + "]";
	}
	
}
