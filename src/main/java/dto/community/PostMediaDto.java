package dto.community;

import java.sql.Timestamp;

public class PostMediaDto {
	private long mediaId;		// 미디어 번호
	private long postId;		// 게시글 번호
	private String mediaType;	// 미디어 유형
	private String mediaUrl;	// 파일 URL
	private int sortOrder;		// 노출 순서	
	private Timestamp createdAt;// 등록 일시
	public PostMediaDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PostMediaDto(long mediaId, long postId, String mediaType, String mediaUrl, int sortOrder,
			Timestamp createdAt) {
		super();
		this.mediaId = mediaId;
		this.postId = postId;
		this.mediaType = mediaType;
		this.mediaUrl = mediaUrl;
		this.sortOrder = sortOrder;
		this.createdAt = createdAt;
	}
	public long getMediaId() {
		return mediaId;
	}
	public void setMediaId(long mediaId) {
		this.mediaId = mediaId;
	}
	public long getPostId() {
		return postId;
	}
	public void setPostId(long postId) {
		this.postId = postId;
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
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "PostMediaDto [mediaId=" + mediaId + ", postId=" + postId + ", mediaType=" + mediaType + ", mediaUrl="
				+ mediaUrl + ", sortOrder=" + sortOrder + ", createdAt=" + createdAt + "]";
	}
	
	
}
