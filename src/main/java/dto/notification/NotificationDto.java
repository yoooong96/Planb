package dto.notification;

import java.sql.Timestamp;

public class NotificationDto {
	private long notificationId;	// 알림 번호
	private long recipientUserId;	// 수신 회원
	private long senderUserId;		// 행동 회원
	private String notificationType;// 알림 유형
	private String targetType;		// 대상 유형
	private long targetId;			// 대상 번호
	private String message;			// 표시 문구
	private Boolean isRead;			// 읽음 여부
	private Timestamp readAt;		// 읽은 일시
	private Timestamp createdAt;	// 생성 일시
	public NotificationDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public NotificationDto(long notificationId, long recipientUserId, long senderUserId, String notificationType,
			String targetType, long targetId, String message, Boolean isRead, Timestamp readAt, Timestamp createdAt) {
		super();
		this.notificationId = notificationId;
		this.recipientUserId = recipientUserId;
		this.senderUserId = senderUserId;
		this.notificationType = notificationType;
		this.targetType = targetType;
		this.targetId = targetId;
		this.message = message;
		this.isRead = isRead;
		this.readAt = readAt;
		this.createdAt = createdAt;
	}
	public long getNotificationId() {
		return notificationId;
	}
	public void setNotificationId(long notificationId) {
		this.notificationId = notificationId;
	}
	public long getRecipientUserId() {
		return recipientUserId;
	}
	public void setRecipientUserId(long recipientUserId) {
		this.recipientUserId = recipientUserId;
	}
	public long getSenderUserId() {
		return senderUserId;
	}
	public void setSenderUserId(long senderUserId) {
		this.senderUserId = senderUserId;
	}
	public String getNotificationType() {
		return notificationType;
	}
	public void setNotificationType(String notificationType) {
		this.notificationType = notificationType;
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
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Boolean getIsRead() {
		return isRead;
	}
	public void setIsRead(Boolean isRead) {
		this.isRead = isRead;
	}
	public Timestamp getReadAt() {
		return readAt;
	}
	public void setReadAt(Timestamp readAt) {
		this.readAt = readAt;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "NotificationDto [notificationId=" + notificationId + ", recipientUserId=" + recipientUserId
				+ ", senderUserId=" + senderUserId + ", notificationType=" + notificationType + ", targetType="
				+ targetType + ", targetId=" + targetId + ", message=" + message + ", isRead=" + isRead + ", readAt="
				+ readAt + ", createdAt=" + createdAt + "]";
	}
	
	
}
