package dto.report;

import java.sql.Timestamp;

public class ReportReasonDto {
	private Integer reasonId;	// 사유 번호
	private String reasonCode;	// 사유 코드
	private String reasonName;	// 사유명
	private String targetType;	// 대상 범위
	private Boolean isActive;	// 사용 여부	
	private Timestamp createdAt;// 등록 일시
	public ReportReasonDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReportReasonDto(Integer reasonId, String reasonCode, String reasonName, String targetType, Boolean isActive,
			Timestamp createdAt) {
		super();
		this.reasonId = reasonId;
		this.reasonCode = reasonCode;
		this.reasonName = reasonName;
		this.targetType = targetType;
		this.isActive = isActive;
		this.createdAt = createdAt;
	}
	public Integer getReasonId() {
		return reasonId;
	}
	public void setReasonId(Integer reasonId) {
		this.reasonId = reasonId;
	}
	public String getReasonCode() {
		return reasonCode;
	}
	public void setReasonCode(String reasonCode) {
		this.reasonCode = reasonCode;
	}
	public String getReasonName() {
		return reasonName;
	}
	public void setReasonName(String reasonName) {
		this.reasonName = reasonName;
	}
	public String getTargetType() {
		return targetType;
	}
	public void setTargetType(String targetType) {
		this.targetType = targetType;
	}
	public Boolean getIsActive() {
		return isActive;
	}
	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "ReportReasonDto [reasonId=" + reasonId + ", reasonCode=" + reasonCode + ", reasonName=" + reasonName
				+ ", targetType=" + targetType + ", isActive=" + isActive + ", createdAt=" + createdAt + "]";
	}
	
	
}
