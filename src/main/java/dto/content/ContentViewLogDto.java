package dto.content;

import java.sql.Timestamp;

public class ContentViewLogDto {
	private long viewId;		// 조회 로그 번호
	private String targetType;	// 대상 유형
	private long targetId;		// 대상 번호
	private long viewerUserId;	// 조회 회원
	private String viewerKey;	// 비로그인 식별키
	private Boolean isValid;	// 유효 조회 여부
	private Timestamp viewedAt;	// 조회 일시
	public ContentViewLogDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ContentViewLogDto(long viewId, String targetType, long targetId, long viewerUserId, String viewerKey,
			Boolean isValid, Timestamp viewedAt) {
		super();
		this.viewId = viewId;
		this.targetType = targetType;
		this.targetId = targetId;
		this.viewerUserId = viewerUserId;
		this.viewerKey = viewerKey;
		this.isValid = isValid;
		this.viewedAt = viewedAt;
	}
	public long getViewId() {
		return viewId;
	}
	public void setViewId(long viewId) {
		this.viewId = viewId;
	}
	public String getTargetType() {
		return targetType;
	}
	public void setTargetType(String targetType) {
		this.targetType = targetType;
	}
	public long getTargetId() {
		return targetId;
	}
	public void setTargetId(long targetId) {
		this.targetId = targetId;
	}
	public long getViewerUserId() {
		return viewerUserId;
	}
	public void setViewerUserId(long viewerUserId) {
		this.viewerUserId = viewerUserId;
	}
	public String getViewerKey() {
		return viewerKey;
	}
	public void setViewerKey(String viewerKey) {
		this.viewerKey = viewerKey;
	}
	public Boolean getIsValid() {
		return isValid;
	}
	public void setIsValid(Boolean isValid) {
		this.isValid = isValid;
	}
	public Timestamp getViewedAt() {
		return viewedAt;
	}
	public void setViewedAt(Timestamp viewedAt) {
		this.viewedAt = viewedAt;
	}
	@Override
	public String toString() {
		return "ContentViewLogDto [viewId=" + viewId + ", targetType=" + targetType + ", targetId=" + targetId
				+ ", viewerUserId=" + viewerUserId + ", viewerKey=" + viewerKey + ", isValid=" + isValid + ", viewedAt="
				+ viewedAt + "]";
	}
	
	
}
