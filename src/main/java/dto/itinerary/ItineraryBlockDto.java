package dto.itinerary;

import java.math.BigDecimal;
import java.sql.Time;
import java.sql.Timestamp;

public class ItineraryBlockDto {
	private long blockId;			// 블록 고유번호
	private long dayId;				// DAY 고유번호
	private long placeId;			// 장소 고유번호
	private String blockType;		// 블록 종류
	private int blockOrder;			// 블록 순서
	private String title;			// 표시 제목
	private String address;			// 주소 스냅샷
	private BigDecimal latitude;	// 위도 스냅샷
	private BigDecimal longitude;	// 경도 스냅샷
	private String memo;			// 상세 메모
	private BigDecimal cost;		// 비용
	private Time startTime;			// 시작 시간
	private Time endTime;			// 종료 시간
	private Timestamp createdAt;	// 가져오기 일시
	public ItineraryBlockDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ItineraryBlockDto(long blockId, long dayId, long placeId, String blockType, int blockOrder, String title,
			String address, BigDecimal latitude, BigDecimal longitude, String memo, BigDecimal cost, Time startTime,
			Time endTime, Timestamp createdAt) {
		super();
		this.blockId = blockId;
		this.dayId = dayId;
		this.placeId = placeId;
		this.blockType = blockType;
		this.blockOrder = blockOrder;
		this.title = title;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.memo = memo;
		this.cost = cost;
		this.startTime = startTime;
		this.endTime = endTime;
		this.createdAt = createdAt;
	}
	public long getBlockId() {
		return blockId;
	}
	public void setBlockId(long blockId) {
		this.blockId = blockId;
	}
	public long getDayId() {
		return dayId;
	}
	public void setDayId(long dayId) {
		this.dayId = dayId;
	}
	public long getPlaceId() {
		return placeId;
	}
	public void setPlaceId(long placeId) {
		this.placeId = placeId;
	}
	public String getBlockType() {
		return blockType;
	}
	public void setBlockType(String blockType) {
		this.blockType = blockType;
	}
	public int getBlockOrder() {
		return blockOrder;
	}
	public void setBlockOrder(int blockOrder) {
		this.blockOrder = blockOrder;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public BigDecimal getLatitude() {
		return latitude;
	}
	public void setLatitude(BigDecimal latitude) {
		this.latitude = latitude;
	}
	public BigDecimal getLongitude() {
		return longitude;
	}
	public void setLongitude(BigDecimal longitude) {
		this.longitude = longitude;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public BigDecimal getCost() {
		return cost;
	}
	public void setCost(BigDecimal cost) {
		this.cost = cost;
	}
	public Time getStartTime() {
		return startTime;
	}
	public void setStartTime(Time startTime) {
		this.startTime = startTime;
	}
	public Time getEndTime() {
		return endTime;
	}
	public void setEndTime(Time endTime) {
		this.endTime = endTime;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "ItineraryBlockDto [blockId=" + blockId + ", dayId=" + dayId + ", placeId=" + placeId + ", blockType="
				+ blockType + ", blockOrder=" + blockOrder + ", title=" + title + ", address=" + address + ", latitude="
				+ latitude + ", longitude=" + longitude + ", memo=" + memo + ", cost=" + cost + ", startTime="
				+ startTime + ", endTime=" + endTime + ", createdAt=" + createdAt + "]";
	}
	
	
}
