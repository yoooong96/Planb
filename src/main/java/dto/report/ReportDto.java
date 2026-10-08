package dto.report;

import java.sql.Timestamp;

public class ReportDto {
	private long reportId;			// 신고번호
	private Long reporterUserId;	// 신고자
	private String targetType;		// 신고 대상 유형
	private long targetId;			// 신고 대상 번호
	private Long targetUserId;		// 신고 대상 회원
	private String targetField;		// 신고 대상 필드
	private Integer reasonId;		// 신고 사유	
	private String detail;			// 상세 내용
	private String status;			// 처리 상태	
	private String actionType;		// 처리 조치
	private Long processedByUserId;	// 처리 관리자
	private Timestamp processedAt;	// 처리 일시
	private Timestamp createdAt;	// 신고 일시
	private Timestamp updatedAt;	// 수정 일시
	
	private String reporterLoginId;

	private String targetLoginId;
	private String targetNickname;

	private String reasonName;

	private String targetTitle;

	/*
	 * 댓글 신고일 경우
	 * 댓글 자체 ID가 아니라
	 * 원글로 이동하기 위한 게시글 ID
	 */
	private long viewTargetId;
	
	
	public ReportDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReportDto(long reportId, Long reporterUserId, String targetType, long targetId, Long targetUserId,
			String targetField, Integer reasonId, String detail, String status, String actionType,
			Long processedByUserId, Timestamp processedAt, Timestamp createdAt, Timestamp updatedAt) {
		super();
		this.reportId = reportId;
		this.reporterUserId = reporterUserId;
		this.targetType = targetType;
		this.targetId = targetId;
		this.targetUserId = targetUserId;
		this.targetField = targetField;
		this.reasonId = reasonId;
		this.detail = detail;
		this.status = status;
		this.actionType = actionType;
		this.processedByUserId = processedByUserId;
		this.processedAt = processedAt;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}
	public long getReportId() {
		return reportId;
	}
	public void setReportId(long reportId) {
		this.reportId = reportId;
	}
	public Long getReporterUserId() {
		return reporterUserId;
	}
	public void setReporterUserId(Long reporterUserId) {
		this.reporterUserId = reporterUserId;
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
	public Long getTargetUserId() {
		return targetUserId;
	}
	public void setTargetUserId(Long targetUserId) {
		this.targetUserId = targetUserId;
	}
	public String getTargetField() {
		return targetField;
	}
	public void setTargetField(String targetField) {
		this.targetField = targetField;
	}
	public Integer getReasonId() {
		return reasonId;
	}
	public void setReasonId(Integer reasonId) {
		this.reasonId = reasonId;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getActionType() {
		return actionType;
	}
	public void setActionType(String actionType) {
		this.actionType = actionType;
	}
	public Long getProcessedByUserId() {
		return processedByUserId;
	}
	public void setProcessedByUserId(Long processedByUserId) {
		this.processedByUserId = processedByUserId;
	}
	public Timestamp getProcessedAt() {
		return processedAt;
	}
	public void setProcessedAt(Timestamp processedAt) {
		this.processedAt = processedAt;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public Timestamp getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
	
	public String getReporterLoginId() {
		return reporterLoginId;
	}
	public void setReporterLoginId(String reporterLoginId) {
		this.reporterLoginId = reporterLoginId;
	}
	public String getTargetLoginId() {
		return targetLoginId;
	}
	public void setTargetLoginId(String targetLoginId) {
		this.targetLoginId = targetLoginId;
	}
	public String getTargetNickname() {
		return targetNickname;
	}
	public void setTargetNickname(String targetNickname) {
		this.targetNickname = targetNickname;
	}
	public String getReasonName() {
		return reasonName;
	}
	public void setReasonName(String reasonName) {
		this.reasonName = reasonName;
	}
	public String getTargetTitle() {
		return targetTitle;
	}
	public void setTargetTitle(String targetTitle) {
		this.targetTitle = targetTitle;
	}
	public long getViewTargetId() {
		return viewTargetId;
	}
	public void setViewTargetId(long viewTargetId) {
		this.viewTargetId = viewTargetId;
	}
	@Override
	public String toString() {
		return "ReportDto [reportId=" + reportId + ", reporterUserId=" + reporterUserId + ", targetType=" + targetType
				+ ", targetId=" + targetId + ", targetUserId=" + targetUserId + ", targetField=" + targetField
				+ ", reasonId=" + reasonId + ", detail=" + detail + ", status=" + status + ", actionType=" + actionType
				+ ", processedByUserId=" + processedByUserId + ", processedAt=" + processedAt + ", createdAt="
				+ createdAt + ", updatedAt=" + updatedAt + "]";
	}
	
	
}
