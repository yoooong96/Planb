package dto.advertisement;

import java.sql.Date;
import java.sql.Timestamp;

public class AdvertisementHistoryDto {
	private long historyId;			// 광고 이력 번호
	private long adId;				// 광고 신청 번호
	private long adminUserId;		// 처리 관리자
	private String actionType;		// 이력 유형
	private String fromStatus;		// 이전 상태
	private String toStatus;		// 변경 후 상태
	private Date previousEndDate;	// 변경 전 종료일
	private Date newEndDate;		// 변경 후 종료일
	private String reason;			// 처리 사유
	private String recipientEmail;	// 수신 이메일	
	private String mailStatus;		// 메일 상태
	private Timestamp mailSentAt;	// 메일 발송 시각
	private String mailError;		// 메일 실패 원인
	private Timestamp createdAt;	// 이력 생성 시각
	public AdvertisementHistoryDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public AdvertisementHistoryDto(long historyId, long adId, long adminUserId, String actionType, String fromStatus,
			String toStatus, Date previousEndDate, Date newEndDate, String reason, String recipientEmail,
			String mailStatus, Timestamp mailSentAt, String mailError, Timestamp createdAt) {
		super();
		this.historyId = historyId;
		this.adId = adId;
		this.adminUserId = adminUserId;
		this.actionType = actionType;
		this.fromStatus = fromStatus;
		this.toStatus = toStatus;
		this.previousEndDate = previousEndDate;
		this.newEndDate = newEndDate;
		this.reason = reason;
		this.recipientEmail = recipientEmail;
		this.mailStatus = mailStatus;
		this.mailSentAt = mailSentAt;
		this.mailError = mailError;
		this.createdAt = createdAt;
	}
	public long getHistoryId() {
		return historyId;
	}
	public void setHistoryId(long historyId) {
		this.historyId = historyId;
	}
	public long getAdId() {
		return adId;
	}
	public void setAdId(long adId) {
		this.adId = adId;
	}
	public long getAdminUserId() {
		return adminUserId;
	}
	public void setAdminUserId(long adminUserId) {
		this.adminUserId = adminUserId;
	}
	public String getActionType() {
		return actionType;
	}
	public void setActionType(String actionType) {
		this.actionType = actionType;
	}
	public String getFromStatus() {
		return fromStatus;
	}
	public void setFromStatus(String fromStatus) {
		this.fromStatus = fromStatus;
	}
	public String getToStatus() {
		return toStatus;
	}
	public void setToStatus(String toStatus) {
		this.toStatus = toStatus;
	}
	public Date getPreviousEndDate() {
		return previousEndDate;
	}
	public void setPreviousEndDate(Date previousEndDate) {
		this.previousEndDate = previousEndDate;
	}
	public Date getNewEndDate() {
		return newEndDate;
	}
	public void setNewEndDate(Date newEndDate) {
		this.newEndDate = newEndDate;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getRecipientEmail() {
		return recipientEmail;
	}
	public void setRecipientEmail(String recipientEmail) {
		this.recipientEmail = recipientEmail;
	}
	public String getMailStatus() {
		return mailStatus;
	}
	public void setMailStatus(String mailStatus) {
		this.mailStatus = mailStatus;
	}
	public Timestamp getMailSentAt() {
		return mailSentAt;
	}
	public void setMailSentAt(Timestamp mailSentAt) {
		this.mailSentAt = mailSentAt;
	}
	public String getMailError() {
		return mailError;
	}
	public void setMailError(String mailError) {
		this.mailError = mailError;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "AdvertisementHistoryDto [historyId=" + historyId + ", adId=" + adId + ", adminUserId=" + adminUserId
				+ ", actionType=" + actionType + ", fromStatus=" + fromStatus + ", toStatus=" + toStatus
				+ ", previousEndDate=" + previousEndDate + ", newEndDate=" + newEndDate + ", reason=" + reason
				+ ", recipientEmail=" + recipientEmail + ", mailStatus=" + mailStatus + ", mailSentAt=" + mailSentAt
				+ ", mailError=" + mailError + ", createdAt=" + createdAt + "]";
	}
	
	
}
