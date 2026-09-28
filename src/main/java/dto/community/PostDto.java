package dto.community;

import java.sql.Date;
import java.sql.Timestamp;

public class PostDto {
	private long postId;			// 게시글 번호
	private long userId;			// 작성 회원
	private String postType;		// 게시글 유형
	private String category;		// 카테고리
	private String title;			// 제목
	private String content;			// 내용
	private String thumbnailImg;	// 대표이미지
	private String visibility;		// 공개 설정
	private int viewCount;			// 유효 조회
	private String status;			// 게시글 상
	private long deletedByuserId;	// 삭제 처리
	private Timestamp createdAt;	// 삭제 일시
	private Timestamp deletedAt;	// 작성 일시
	private Timestamp updatedAt;	// 수정 일시
	private String destination;		// 여행지
	private Date startDate;			// 시작일
	private Date endDate;			// 종료일	
	private int recruitCount;		// 모집 인원
	private String recruitStatus;	// 모집 상태
	public PostDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PostDto(long postId, long userId, String postType, String category, String title, String content,
			String thumbnailImg, String visibility, int viewCount, String status, long deletedByuserId,
			Timestamp createdAt, Timestamp deletedAt, Timestamp updatedAt, String destination, Date startDate,
			Date endDate, int recruitCount, String recruitStatus) {
		super();
		this.postId = postId;
		this.userId = userId;
		this.postType = postType;
		this.category = category;
		this.title = title;
		this.content = content;
		this.thumbnailImg = thumbnailImg;
		this.visibility = visibility;
		this.viewCount = viewCount;
		this.status = status;
		this.deletedByuserId = deletedByuserId;
		this.createdAt = createdAt;
		this.deletedAt = deletedAt;
		this.updatedAt = updatedAt;
		this.destination = destination;
		this.startDate = startDate;
		this.endDate = endDate;
		this.recruitCount = recruitCount;
		this.recruitStatus = recruitStatus;
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
	public String getPostType() {
		return postType;
	}
	public void setPostType(String postType) {
		this.postType = postType;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
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
	public long getDeletedByuserId() {
		return deletedByuserId;
	}
	public void setDeletedByuserId(long deletedByuserId) {
		this.deletedByuserId = deletedByuserId;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public Timestamp getDeletedAt() {
		return deletedAt;
	}
	public void setDeletedAt(Timestamp deletedAt) {
		this.deletedAt = deletedAt;
	}
	public Timestamp getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
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
		return "PostDto [postId=" + postId + ", userId=" + userId + ", postType=" + postType + ", category=" + category
				+ ", title=" + title + ", content=" + content + ", thumbnailImg=" + thumbnailImg + ", visibility="
				+ visibility + ", viewCount=" + viewCount + ", status=" + status + ", deletedByuserId="
				+ deletedByuserId + ", createdAt=" + createdAt + ", deletedAt=" + deletedAt + ", updatedAt=" + updatedAt
				+ ", destination=" + destination + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", recruitCount=" + recruitCount + ", recruitStatus=" + recruitStatus + "]";
	}
	
	
}
