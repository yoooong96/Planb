package dto.itinerary;

import java.sql.Timestamp;

public class ItineraryImportDto {
	private long importId;			// 가져오기 번호
	private long userId;			// 가져온 회원
	private int sourceBlockId; 		// 원본 번호
	private long sourceItineraryId; // 원본 일정
	private long sourceDayId;		// 원본 DAY
	private String importType;		// 가져오기 유형
	private Timestamp createdAt;	// 가져오기 일시
	public ItineraryImportDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ItineraryImportDto(long importId, long userId, int sourceBlockId, long sourceItineraryId, long sourceDayId,
			String importType, Timestamp createdAt) {
		super();
		this.importId = importId;
		this.userId = userId;
		this.sourceBlockId = sourceBlockId;
		this.sourceItineraryId = sourceItineraryId;
		this.sourceDayId = sourceDayId;
		this.importType = importType;
		this.createdAt = createdAt;
	}
	public long getImportId() {
		return importId;
	}
	public void setImportId(long importId) {
		this.importId = importId;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public int getSourceBlockId() {
		return sourceBlockId;
	}
	public void setSourceBlockId(int sourceBlockId) {
		this.sourceBlockId = sourceBlockId;
	}
	public long getSourceItineraryId() {
		return sourceItineraryId;
	}
	public void setSourceItineraryId(long sourceItineraryId) {
		this.sourceItineraryId = sourceItineraryId;
	}
	public long getSourceDayId() {
		return sourceDayId;
	}
	public void setSourceDayId(long sourceDayId) {
		this.sourceDayId = sourceDayId;
	}
	public String getImportType() {
		return importType;
	}
	public void setImportType(String importType) {
		this.importType = importType;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "ItineraryImportDto [importId=" + importId + ", userId=" + userId + ", sourceBlockId=" + sourceBlockId
				+ ", sourceItineraryId=" + sourceItineraryId + ", sourceDayId=" + sourceDayId + ", importType="
				+ importType + ", createdAt=" + createdAt + "]";
	}
	
	
}
