package dto.itinerary;

import java.sql.Timestamp;

public class ItineraryBookmarkDto {
	private long itineraryId;	// 일정 고유번호
	private long userId;		// 회원 고유번호
	private Timestamp createdAt;// 북마크 일시
	public ItineraryBookmarkDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ItineraryBookmarkDto(long itineraryId, long userId, Timestamp createdAt) {
		super();
		this.itineraryId = itineraryId;
		this.userId = userId;
		this.createdAt = createdAt;
	}
	public long getItineraryId() {
		return itineraryId;
	}
	public void setItineraryId(long itineraryId) {
		this.itineraryId = itineraryId;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "ItineraryBookmarkDto [itineraryId=" + itineraryId + ", userId=" + userId + ", createdAt=" + createdAt
				+ "]";
	}
	
	
}
