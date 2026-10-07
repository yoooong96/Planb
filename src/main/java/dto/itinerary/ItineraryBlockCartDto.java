package dto.itinerary;

import java.math.BigDecimal;
import java.sql.Time;

public class ItineraryBlockCartDto {

    private Long blockCartId;
    private Long dayCartId;
    private Long sourceBlockId;

    private String googlePlaceId;
    private String placeName;
    private String placeAddress;

    private BigDecimal placeLat;
    private BigDecimal placeLng;

    private String blockType;
    private Integer blockOrder;

    private String title;
    private String memo;

    private BigDecimal cost;
    private String costType;

    private Time startTime;
    private Time endTime;

    public ItineraryBlockCartDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ItineraryBlockCartDto(Long blockCartId, Long dayCartId, Long sourceBlockId, String googlePlaceId,
			String placeName, String placeAddress, BigDecimal placeLat, BigDecimal placeLng, String blockType,
			Integer blockOrder, String title, String memo, BigDecimal cost, String costType, Time startTime,
			Time endTime) {
		super();
		this.blockCartId = blockCartId;
		this.dayCartId = dayCartId;
		this.sourceBlockId = sourceBlockId;
		this.googlePlaceId = googlePlaceId;
		this.placeName = placeName;
		this.placeAddress = placeAddress;
		this.placeLat = placeLat;
		this.placeLng = placeLng;
		this.blockType = blockType;
		this.blockOrder = blockOrder;
		this.title = title;
		this.memo = memo;
		this.cost = cost;
		this.costType = costType;
		this.startTime = startTime;
		this.endTime = endTime;
	}

	public Long getBlockCartId() {
        return blockCartId;
    }

    public void setBlockCartId(Long blockCartId) {
        this.blockCartId = blockCartId;
    }

    public Long getDayCartId() {
        return dayCartId;
    }

    public void setDayCartId(Long dayCartId) {
        this.dayCartId = dayCartId;
    }

    public Long getSourceBlockId() {
        return sourceBlockId;
    }

    public void setSourceBlockId(Long sourceBlockId) {
        this.sourceBlockId = sourceBlockId;
    }

    public String getGooglePlaceId() {
        return googlePlaceId;
    }

    public void setGooglePlaceId(String googlePlaceId) {
        this.googlePlaceId = googlePlaceId;
    }

    public String getPlaceName() {
        return placeName;
    }

    public void setPlaceName(String placeName) {
        this.placeName = placeName;
    }

    public String getPlaceAddress() {
        return placeAddress;
    }

    public void setPlaceAddress(String placeAddress) {
        this.placeAddress = placeAddress;
    }

    public BigDecimal getPlaceLat() {
        return placeLat;
    }

    public void setPlaceLat(BigDecimal placeLat) {
        this.placeLat = placeLat;
    }

    public BigDecimal getPlaceLng() {
        return placeLng;
    }

    public void setPlaceLng(BigDecimal placeLng) {
        this.placeLng = placeLng;
    }

    public String getBlockType() {
        return blockType;
    }

    public void setBlockType(String blockType) {
        this.blockType = blockType;
    }

    public Integer getBlockOrder() {
        return blockOrder;
    }

    public void setBlockOrder(Integer blockOrder) {
        this.blockOrder = blockOrder;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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

    public String getCostType() {
        return costType;
    }

    public void setCostType(String costType) {
        this.costType = costType;
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

	@Override
	public String toString() {
		return "ItineraryBlockCartDto [blockCartId=" + blockCartId + ", dayCartId=" + dayCartId + ", sourceBlockId="
				+ sourceBlockId + ", googlePlaceId=" + googlePlaceId + ", placeName=" + placeName + ", placeAddress="
				+ placeAddress + ", placeLat=" + placeLat + ", placeLng=" + placeLng + ", blockType=" + blockType
				+ ", blockOrder=" + blockOrder + ", title=" + title + ", memo=" + memo + ", cost=" + cost
				+ ", costType=" + costType + ", startTime=" + startTime + ", endTime=" + endTime + "]";
	}
    
}