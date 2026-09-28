package dto.member;

import java.sql.Timestamp;

public class UserConsentDto {
	private long consentId;			// 동의 이력 번호
	private long userId;			// 회원 고유번호
	private String consentType;		// 동의 유형
	private String version;			// 약관 버전
	private Boolean isAgreed;		// 동의 여부
	private Timestamp agreedAt;		// 동의 일시
	private Timestamp withdrawnAt;	// 철회 일시
	private String note;			// 비고
	public UserConsentDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public UserConsentDto(long consentId, long userId, String consentType, String version, Boolean isAgreed,
			Timestamp agreedAt, Timestamp withdrawnAt, String note) {
		super();
		this.consentId = consentId;
		this.userId = userId;
		this.consentType = consentType;
		this.version = version;
		this.isAgreed = isAgreed;
		this.agreedAt = agreedAt;
		this.withdrawnAt = withdrawnAt;
		this.note = note;
	}
	public long getConsentId() {
		return consentId;
	}
	public void setConsentId(long consentId) {
		this.consentId = consentId;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public String getConsentType() {
		return consentType;
	}
	public void setConsentType(String consentType) {
		this.consentType = consentType;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public Boolean getIsAgreed() {
		return isAgreed;
	}
	public void setIsAgreed(Boolean isAgreed) {
		this.isAgreed = isAgreed;
	}
	public Timestamp getAgreedAt() {
		return agreedAt;
	}
	public void setAgreedAt(Timestamp agreedAt) {
		this.agreedAt = agreedAt;
	}
	public Timestamp getWithdrawnAt() {
		return withdrawnAt;
	}
	public void setWithdrawnAt(Timestamp withdrawnAt) {
		this.withdrawnAt = withdrawnAt;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	@Override
	public String toString() {
		return "UserConsentDto [consentId=" + consentId + ", userId=" + userId + ", consentType=" + consentType
				+ ", version=" + version + ", isAgreed=" + isAgreed + ", agreedAt=" + agreedAt + ", withdrawnAt="
				+ withdrawnAt + ", note=" + note + "]";
	}
	
	
}
