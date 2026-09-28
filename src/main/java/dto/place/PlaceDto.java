package dto.place;

import java.math.BigDecimal;

public class PlaceDto {
	private long placeId;			// 장소 고유번호
	private String provider;		// 제공처
	private String providerPlaceId; // 외부 장소 id
	private String placeName;		// 장소명
	private String categoryCode;	// 카테고리 코드
	private String categoryName;	// 카테고리명
	private String addressName;		// 지번 주소
	private String roadAddressName;	// 도로명 주소
	private String phone;			// 장소 전화번호
	private String placeUrl;		// 장소 URL
	private BigDecimal longitude;		// 경도
	private BigDecimal latitude;		// 위도
	public PlaceDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PlaceDto(long placeId, String provider, String providerPlaceId, String placeName, String categoryCode,
			String categoryName, String addressName, String roadAddressName, String phone, String placeUrl,
			BigDecimal longitude, BigDecimal latitude) {
		super();
		this.placeId = placeId;
		this.provider = provider;
		this.providerPlaceId = providerPlaceId;
		this.placeName = placeName;
		this.categoryCode = categoryCode;
		this.categoryName = categoryName;
		this.addressName = addressName;
		this.roadAddressName = roadAddressName;
		this.phone = phone;
		this.placeUrl = placeUrl;
		this.longitude = longitude;
		this.latitude = latitude;
	}
	public long getPlaceId() {
		return placeId;
	}
	public void setPlaceId(long placeId) {
		this.placeId = placeId;
	}
	public String getProvider() {
		return provider;
	}
	public void setProvider(String provider) {
		this.provider = provider;
	}
	public String getProviderPlaceId() {
		return providerPlaceId;
	}
	public void setProviderPlaceId(String providerPlaceId) {
		this.providerPlaceId = providerPlaceId;
	}
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}
	public String getCategoryCode() {
		return categoryCode;
	}
	public void setCategoryCode(String categoryCode) {
		this.categoryCode = categoryCode;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getAddressName() {
		return addressName;
	}
	public void setAddressName(String addressName) {
		this.addressName = addressName;
	}
	public String getRoadAddressName() {
		return roadAddressName;
	}
	public void setRoadAddressName(String roadAddressName) {
		this.roadAddressName = roadAddressName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPlaceUrl() {
		return placeUrl;
	}
	public void setPlaceUrl(String placeUrl) {
		this.placeUrl = placeUrl;
	}
	public BigDecimal getLongitude() {
		return longitude;
	}
	public void setLongitude(BigDecimal longitude) {
		this.longitude = longitude;
	}
	public BigDecimal getLatitude() {
		return latitude;
	}
	public void setLatitude(BigDecimal latitude) {
		this.latitude = latitude;
	}
	@Override
	public String toString() {
		return "PlaceDto [placeId=" + placeId + ", provider=" + provider + ", providerPlaceId=" + providerPlaceId
				+ ", placeName=" + placeName + ", categoryCode=" + categoryCode + ", categoryName=" + categoryName
				+ ", addressName=" + addressName + ", roadAddressName=" + roadAddressName + ", phone=" + phone
				+ ", placeUrl=" + placeUrl + ", longitude=" + longitude + ", latitude=" + latitude + "]";
	}
	
	
}
