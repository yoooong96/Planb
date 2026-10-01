package dto.itinerary;

public class ItineraryBlockImageDto {

    private Long imageId;                  // 사진 고유번호
    private Long blockId;                  // 블록 고유번호
    private String imageUrl;               // 사진 경로

    // 1 ~ 3, imageOrder=1을 대표 이미지로 사용
    private Integer imageOrder;

    public ItineraryBlockImageDto() {
    }

    public Long getImageId() {
        return imageId;
    }

    public void setImageId(Long imageId) {
        this.imageId = imageId;
    }

    public Long getBlockId() {
        return blockId;
    }

    public void setBlockId(Long blockId) {
        this.blockId = blockId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Integer getImageOrder() {
        return imageOrder;
    }

    public void setImageOrder(Integer imageOrder) {
        this.imageOrder = imageOrder;
    }

    @Override
    public String toString() {
        return "ItineraryBlockImageDto [imageId=" + imageId
                + ", blockId=" + blockId
                + ", imageUrl=" + imageUrl
                + ", imageOrder=" + imageOrder + "]";
    }
}
