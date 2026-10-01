package dto.community;

import java.time.LocalDateTime;

public class TipMediaDto {
	private Long mediaId;			// 미디어 번호
	private Long tipId;				// 꿀팁 게시글 번호
	private String mediaType;		// 미디어 유형
	private String mediaUrl;		// 파일 URL
	private int sortOrder;			// 노출 순서
	private LocalDateTime createdAt;// 등록 일시
	public TipMediaDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TipMediaDto(Long mediaId, Long tipId, String mediaType, String mediaUrl, int sortOrder,
			LocalDateTime createdAt) {
		super();
		this.mediaId = mediaId;
		this.tipId = tipId;
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
	public Long getTipId() {
		return tipId;
	}
	public void setTipId(Long tipId) {
		this.tipId = tipId;
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
		return "TipMediaDto [mediaId=" + mediaId + ", tipId=" + tipId + ", mediaType=" + mediaType + ", mediaUrl="
				+ mediaUrl + ", sortOrder=" + sortOrder + ", createdAt=" + createdAt + "]";
	}
	
}
