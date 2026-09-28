package dto.itinerary;

import java.sql.Date;
import java.sql.Timestamp;

public class ItineraryDayDto {
	private long dayId;			// Day 고유번호
	private long itineraryId;	// 일정 고유번호
	private int dayNo;			// Day 순번
	private Date dayDate;		// 여행 날짜
	private String title;		// Day 제목
	private long sourceDayId;	// 원본 Day 번호
	private Timestamp createdAt;// 가져오기 일시
	public ItineraryDayDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ItineraryDayDto(long dayId, long itineraryId, int dayNo, Date dayDate, String title, long sourceDayId,
			Timestamp createdAt) {
		super();
		this.dayId = dayId;
		this.itineraryId = itineraryId;
		this.dayNo = dayNo;
		this.dayDate = dayDate;
		this.title = title;
		this.sourceDayId = sourceDayId;
		this.createdAt = createdAt;
	}
	public long getDayId() {
		return dayId;
	}
	public void setDayId(long dayId) {
		this.dayId = dayId;
	}
	public long getItineraryId() {
		return itineraryId;
	}
	public void setItineraryId(long itineraryId) {
		this.itineraryId = itineraryId;
	}
	public int getDayNo() {
		return dayNo;
	}
	public void setDayNo(int dayNo) {
		this.dayNo = dayNo;
	}
	public Date getDayDate() {
		return dayDate;
	}
	public void setDayDate(Date dayDate) {
		this.dayDate = dayDate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public long getSourceDayId() {
		return sourceDayId;
	}
	public void setSourceDayId(long sourceDayId) {
		this.sourceDayId = sourceDayId;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "ItineraryDayDto [dayId=" + dayId + ", itineraryId=" + itineraryId + ", dayNo=" + dayNo + ", dayDate="
				+ dayDate + ", title=" + title + ", sourceDayId=" + sourceDayId + ", createdAt=" + createdAt + "]";
	}
	
	
}
