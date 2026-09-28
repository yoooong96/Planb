package dto.support;

import java.sql.Timestamp;

public class SupportInquiryDto {
	private long inquiryId;			// 문의 번호
	private long userId;			// 문의 회원
	private String category;		// 문의 유형
	private String title;			// 문의 제목
	private String content;			// 문의 내용
	private String contactEmail;	// 회신 이메일
	private String status;			// 처리 상태
	private String answer;			// 답변 내용
	private long answeredByUserId;	// 답변 관리자
	private Timestamp answeredAt;	// 답변 일시
	private Timestamp createdAt;	// 문의 일시
	private Timestamp updatedAt;	// 수정 일시
	public SupportInquiryDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public SupportInquiryDto(long inquiryId, long userId, String category, String title, String content,
			String contactEmail, String status, String answer, long answeredByUserId, Timestamp answeredAt,
			Timestamp createdAt, Timestamp updatedAt) {
		super();
		this.inquiryId = inquiryId;
		this.userId = userId;
		this.category = category;
		this.title = title;
		this.content = content;
		this.contactEmail = contactEmail;
		this.status = status;
		this.answer = answer;
		this.answeredByUserId = answeredByUserId;
		this.answeredAt = answeredAt;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}
	public long getInquiryId() {
		return inquiryId;
	}
	public void setInquiryId(long inquiryId) {
		this.inquiryId = inquiryId;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getContactEmail() {
		return contactEmail;
	}
	public void setContactEmail(String contactEmail) {
		this.contactEmail = contactEmail;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public long getAnsweredByUserId() {
		return answeredByUserId;
	}
	public void setAnsweredByUserId(long answeredByUserId) {
		this.answeredByUserId = answeredByUserId;
	}
	public Timestamp getAnsweredAt() {
		return answeredAt;
	}
	public void setAnsweredAt(Timestamp answeredAt) {
		this.answeredAt = answeredAt;
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
	@Override
	public String toString() {
		return "SupportInquiryDto [inquiryId=" + inquiryId + ", userId=" + userId + ", category=" + category
				+ ", title=" + title + ", content=" + content + ", contactEmail=" + contactEmail + ", status=" + status
				+ ", answer=" + answer + ", answeredByUserId=" + answeredByUserId + ", answeredAt=" + answeredAt
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + "]";
	}
	
	
}
