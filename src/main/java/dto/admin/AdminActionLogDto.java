package dto.admin;

import java.sql.Timestamp;

public class AdminActionLogDto {
	private long actionId;		// 조치 번호
	private long adminUserId;	// 관리자 번호
	private String actionType;	// 조치 유형
	private String targetType;	// 대상 유형
	private long targetId;		// 대상 번호
	private long reportId;		// 연결 신고 번호
	private String memo;		// 관리자 메모
	private Timestamp createdAt;// 처리 일시
	public AdminActionLogDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public AdminActionLogDto(long actionId, long adminUserId, String actionType, String targetType, long targetId,
			long reportId, String memo, Timestamp createdAt) {
		super();
		this.actionId = actionId;
		this.adminUserId = adminUserId;
		this.actionType = actionType;
		this.targetType = targetType;
		this.targetId = targetId;
		this.reportId = reportId;
		this.memo = memo;
		this.createdAt = createdAt;
	}
	public long getActionId() {
		return actionId;
	}
	public void setActionId(long actionId) {
		this.actionId = actionId;
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
	public long getReportId() {
		return reportId;
	}
	public void setReportId(long reportId) {
		this.reportId = reportId;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "AdminActionLogDto [actionId=" + actionId + ", adminUserId=" + adminUserId + ", actionType=" + actionType
				+ ", targetType=" + targetType + ", targetId=" + targetId + ", reportId=" + reportId + ", memo=" + memo
				+ ", createdAt=" + createdAt + "]";
	}
}
