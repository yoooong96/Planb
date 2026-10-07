package dto.itinerary;

import java.sql.Date;

public class ItineraryDayCartDto {

    private Long dayCartId;
    private Long cartId;
    private Long sourceDayId;

    private Integer dayOrder;
    private Date dayDate;
    private String title;

    public ItineraryDayCartDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ItineraryDayCartDto(Long dayCartId, Long cartId, Long sourceDayId, Integer dayOrder, Date dayDate,
			String title) {
		super();
		this.dayCartId = dayCartId;
		this.cartId = cartId;
		this.sourceDayId = sourceDayId;
		this.dayOrder = dayOrder;
		this.dayDate = dayDate;
		this.title = title;
	}

	public Long getDayCartId() {
        return dayCartId;
    }

    public void setDayCartId(Long dayCartId) {
        this.dayCartId = dayCartId;
    }

    public Long getCartId() {
        return cartId;
    }

    public void setCartId(Long cartId) {
        this.cartId = cartId;
    }

    public Long getSourceDayId() {
        return sourceDayId;
    }

    public void setSourceDayId(Long sourceDayId) {
        this.sourceDayId = sourceDayId;
    }

    public Integer getDayOrder() {
        return dayOrder;
    }

    public void setDayOrder(Integer dayOrder) {
        this.dayOrder = dayOrder;
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

	@Override
	public String toString() {
		return "ItineraryDayCartDto [dayCartId=" + dayCartId + ", cartId=" + cartId + ", sourceDayId=" + sourceDayId
				+ ", dayOrder=" + dayOrder + ", dayDate=" + dayDate + ", title=" + title + "]";
	}

}