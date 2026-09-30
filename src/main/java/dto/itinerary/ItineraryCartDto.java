package dto.itinerary;

import java.sql.Timestamp;

public class ItineraryCartDto {
	private long cartItemId;	// 장바구니 항목 번호
	private long userId;		// 회원 번호
	private String itemType;	// 항목 유형
	private long itineraryId;	// 일정 번호
	private long dayId;			// DAY 번호
	private long blockId;		// 블록 번호
	private Timestamp createdAt;// 담기 일시	
	public ItineraryCartDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ItineraryCartDto(long cartItemId, long userId, String itemType, long itineraryId, long dayId, long blockId,
			Timestamp createdAt) {
		super();
		this.cartItemId = cartItemId;
		this.userId = userId;
		this.itemType = itemType;
		this.itineraryId = itineraryId;
		this.dayId = dayId;
		this.blockId = blockId;
		this.createdAt = createdAt;
	}
	public long getCartItemId() {
		return cartItemId;
	}
	public void setCartItemId(long cartItemId) {
		this.cartItemId = cartItemId;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public String getItemType() {
		return itemType;
	}
	public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	public long getItineraryId() {
		return itineraryId;
	}
	public void setItineraryId(long itineraryId) {
		this.itineraryId = itineraryId;
	}
	public long getDayId() {
		return dayId;
	}
	public void setDayId(long dayId) {
		this.dayId = dayId;
	}
	public long getBlockId() {
		return blockId;
	}
	public void setBlockId(long blockId) {
		this.blockId = blockId;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "CartItemDto [cartItemId=" + cartItemId + ", userId=" + userId + ", itemType=" + itemType
				+ ", itineraryId=" + itineraryId + ", dayId=" + dayId + ", blockId=" + blockId + ", createdAt="
				+ createdAt + "]";
	}
	
	
	
}
