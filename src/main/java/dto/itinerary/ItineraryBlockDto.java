package dto.itinerary;

import java.math.BigDecimal;
import java.sql.Time;
import java.util.List;

public class ItineraryBlockDto {

    private Long blockId;                  // 블록 고유번호
    private Long dayId;                    // DAY 고유번호

    private Long placeId;                  // 장소 고유번호 (지도 연결 전에는 null 가능)
    private Long sourceBlockId;            // 원본 블록 번호

    // MEAL / ATTRACTION / LODGING / TRANSPORT / ACTIVITY
    private String blockType;

    private Integer blockOrder;            // DAY 내부 블록 순서
    private String title;                  // 표시 제목
    private String memo;                   // 상세 메모
    private BigDecimal cost;               // 비용

    private Time startTime;                // 시작 시간
    private Time endTime;                  // 종료 시간

    // BLOCK -> IMAGE 계층
    private List<ItineraryBlockImageDto> images;

    public ItineraryBlockDto() {
    }

    public Long getBlockId() {
        return blockId;
    }

    public void setBlockId(Long blockId) {
        this.blockId = blockId;
    }

    public Long getDayId() {
        return dayId;
    }

    public void setDayId(Long dayId) {
        this.dayId = dayId;
    }

    public Long getPlaceId() {
        return placeId;
    }

    public void setPlaceId(Long placeId) {
        this.placeId = placeId;
    }

    public Long getSourceBlockId() {
        return sourceBlockId;
    }

    public void setSourceBlockId(Long sourceBlockId) {
        this.sourceBlockId = sourceBlockId;
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

    public List<ItineraryBlockImageDto> getImages() {
        return images;
    }

    public void setImages(List<ItineraryBlockImageDto> images) {
        this.images = images;
    }

    @Override
    public String toString() {
        return "ItineraryBlockDto [blockId=" + blockId
                + ", dayId=" + dayId
                + ", placeId=" + placeId
                + ", sourceBlockId=" + sourceBlockId
                + ", blockType=" + blockType
                + ", blockOrder=" + blockOrder
                + ", title=" + title
                + ", memo=" + memo
                + ", cost=" + cost
                + ", startTime=" + startTime
                + ", endTime=" + endTime
                + ", images=" + images + "]";
    }
}
