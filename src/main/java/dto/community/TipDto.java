package dto.community;

import java.time.LocalDateTime;

public class TipDto {
	private Long tipId;				// 꿀팁 게시글 번호
	private Long userId;			// 작성 회원
	private String title;			// 제목
	private String content;			// 내용
	private String thumbnailImg;	// 대표 이미지
	private String visibility;		// 공개 설정 여부
	private int viewCount;			// 조회수
	private String status;			// 게시글 상태
	private Long deletedByUserId;	// 삭제 처리자
	private LocalDateTime deletedAt;// 삭제 일시
	private LocalDateTime createdAt;// 작성 일시
	private LocalDateTime updatedAt;// 수정 일시
	private String hashtag;			// 해시태그
	public TipDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TipDto(Long tipId, Long userId, String title, String content, String thumbnailImg, String visibility,
			int viewCount, String status, Long deletedByUserId, LocalDateTime deletedAt, LocalDateTime createdAt,
			LocalDateTime updatedAt, String hashtag) {
		super();
		this.tipId = tipId;
		this.userId = userId;
		this.title = title;
		this.content = content;
		this.thumbnailImg = thumbnailImg;
		this.visibility = visibility;
		this.viewCount = viewCount;
		this.status = status;
		this.deletedByUserId = deletedByUserId;
		this.deletedAt = deletedAt;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.hashtag = hashtag;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getThumbnailImg() {
		return thumbnailImg;
	}
	public void setThumbnailImg(String thumbnailImg) {
		this.thumbnailImg = thumbnailImg;
	}
	public String getVisibility() {
		return visibility;
	}
	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Long getDeletedByUserId() {
		return deletedByUserId;
	}
	public void setDeletedByUserId(Long deletedByUserId) {
		this.deletedByUserId = deletedByUserId;
	}
	public LocalDateTime getDeletedAt() {
		return deletedAt;
	}
	public void setDeletedAt(LocalDateTime deletedAt) {
		this.deletedAt = deletedAt;
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
	public String getHashtag() {
		return hashtag;
	}
	public void setHashtag(String hashtag) {
		this.hashtag = hashtag;
	}
	@Override
	public String toString() {
		return "TipDto [tipId=" + tipId + ", userId=" + userId + ", title=" + title + ", content=" + content
				+ ", thumbnailImg=" + thumbnailImg + ", visibility=" + visibility + ", viewCount=" + viewCount
				+ ", status=" + status + ", deletedByUserId=" + deletedByUserId + ", deletedAt=" + deletedAt
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", hashtag=" + hashtag + "]";
	}
	
	
}
