package dto.community;

import java.time.LocalDateTime;

public class MateMediaDto {
	private Long mediaId;			// 미디어 번호
	private Long mateId;			// 메이트 게시글 번호
	private String mediaType;		// 미디어 유형
	private String mediaUrl;		// 파일 URL
	private int sortOrder;			// 노출 순서
	private LocalDateTime createdAt;// 등록 일시
	public MateMediaDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MateMediaDto(Long mediaId, Long mateId, String mediaType, String mediaUrl, int sortOrder,
			LocalDateTime createdAt) {
		super();
		this.mediaId = mediaId;
		this.mateId = mateId;
		this.mediaType = mediaType;
		this.mediaUrl = mediaUrl;
		this.sortOrder = sortOrder;
		this.createdAt = createdAt;
	}
	public Long getMediaId() {
		return mediaId;
	}
	public void setMediaId(Long mediaId) {
		this.mediaId = mediaId;
	}
	public Long getMateId() {
		return mateId;
	}
	public void setMateId(Long mateId) {
		this.mateId = mateId;
	}
	public String getMediaType() {
		return mediaType;
	}
	public void setMediaType(String mediaType) {
		this.mediaType = mediaType;
	}
	public String getMediaUrl() {
		return mediaUrl;
	}
	public void setMediaUrl(String mediaUrl) {
		this.mediaUrl = mediaUrl;
	}
	public int getSortOrder() {
		return sortOrder;
	}
	public void setSortOrder(int sortOrder) {
		this.sortOrder = sortOrder;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "MateMediaDto [mediaId=" + mediaId + ", mateId=" + mateId + ", mediaType=" + mediaType + ", mediaUrl="
				+ mediaUrl + ", sortOrder=" + sortOrder + ", createdAt=" + createdAt + "]";
	}
	
}
