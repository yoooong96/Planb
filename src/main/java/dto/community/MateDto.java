package dto.community;

import java.time.LocalDateTime;

public class MateDto {
	private Long mateId;				// 메이트 게시글 번호
	private Long userId;				// 작성 회원
	private String title;				// 제목
	private String content;				// 내용
	private String img;					// 대표 이미지
	private String visibility;			// 공개 설정
	private int viewCount;				// 조회수
	private String status;				// 게시글 상태
	private Long deletedByUserId;		// 삭제 처리자
	private LocalDateTime deletedAt;	// 삭제 일시
	private LocalDateTime createdAt;	// 작성 일시
	private LocalDateTime updatedAt;	// 수정 일시
	private String country;				// 나라
	private int recruitCount;			// 모집 인원
	private String recruitStatus;		// 모집 상태
	public MateDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MateDto(Long mateId, Long userId, String title, String content, String img, String visibility, int viewCount,
			String status, Long deletedByUserId, LocalDateTime deletedAt, LocalDateTime createdAt,
			LocalDateTime updatedAt, String country, int recruitCount, String recruitStatus) {
		super();
		this.mateId = mateId;
		this.userId = userId;
		this.title = title;
		this.content = content;
		this.img = img;
		this.visibility = visibility;
		this.viewCount = viewCount;
		this.status = status;
		this.deletedByUserId = deletedByUserId;
		this.deletedAt = deletedAt;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.country = country;
		this.recruitCount = recruitCount;
		this.recruitStatus = recruitStatus;
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
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
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
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public int getRecruitCount() {
		return recruitCount;
	}
	public void setRecruitCount(int recruitCount) {
		this.recruitCount = recruitCount;
	}
	public String getRecruitStatus() {
		return recruitStatus;
	}
	public void setRecruitStatus(String recruitStatus) {
		this.recruitStatus = recruitStatus;
	}
	@Override
	public String toString() {
		return "MateDto [mateId=" + mateId + ", userId=" + userId + ", title=" + title + ", content=" + content
				+ ", img=" + img + ", visibility=" + visibility + ", viewCount=" + viewCount + ", status=" + status
				+ ", deletedByUserId=" + deletedByUserId + ", deletedAt=" + deletedAt + ", createdAt=" + createdAt
				+ ", updatedAt=" + updatedAt + ", country=" + country + ", recruitCount=" + recruitCount
				+ ", recruitStatus=" + recruitStatus + "]";
	}
}
