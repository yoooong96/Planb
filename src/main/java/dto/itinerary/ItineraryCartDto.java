package dto.itinerary;

import java.sql.Timestamp;

public class ItineraryCartDto {

    private Long cartId;
    private Long userId;
    private Long sourceItineraryId;

    private String authorNickname;
    private String title;
    private String country;

    private Timestamp addedAt;

    public ItineraryCartDto() {
		super();
		// TODO Auto-generated constructor stub
	}
    
	public ItineraryCartDto(Long cartId, Long userId, Long sourceItineraryId, String authorNickname, String title,
			String country, Timestamp addedAt) {
		super();
		this.cartId = cartId;
		this.userId = userId;
		this.sourceItineraryId = sourceItineraryId;
		this.authorNickname = authorNickname;
		this.title = title;
		this.country = country;
		this.addedAt = addedAt;
	}

	public Long getCartId() {
        return cartId;
    }

    public void setCartId(Long cartId) {
        this.cartId = cartId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getSourceItineraryId() {
        return sourceItineraryId;
    }

    public void setSourceItineraryId(Long sourceItineraryId) {
        this.sourceItineraryId = sourceItineraryId;
    }

    public String getAuthorNickname() {
        return authorNickname;
    }

    public void setAuthorNickname(String authorNickname) {
        this.authorNickname = authorNickname;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public Timestamp getAddedAt() {
        return addedAt;
    }

    public void setAddedAt(Timestamp addedAt) {
        this.addedAt = addedAt;
    }

	@Override
	public String toString() {
		return "ItineraryCartDto [cartId=" + cartId + ", userId=" + userId + ", sourceItineraryId=" + sourceItineraryId
				+ ", authorNickname=" + authorNickname + ", title=" + title + ", country=" + country + ", addedAt="
				+ addedAt + "]";
	}
    
}