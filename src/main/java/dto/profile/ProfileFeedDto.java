package dto.profile;

public class ProfileFeedDto {
	private long itineraryId;
	private String title;
	private String country;
	private String city;
	private String thumbnailImg;
	private String visibility;
	
	private int bookmarkCount;
	private int likeCount;
	private int commentCount;
	
	
	
	public ProfileFeedDto() {
		super();
	}



	public ProfileFeedDto(long itineraryId, String title, String country, String city, String thumbnailImg,
			String visibility, int bookmarkCount, int likeCount, int commentCount) {
		super();
		this.itineraryId = itineraryId;
		this.title = title;
		this.country = country;
		this.city = city;
		this.thumbnailImg = thumbnailImg;
		this.visibility = visibility;
		this.bookmarkCount = bookmarkCount;
		this.likeCount = likeCount;
		this.commentCount = commentCount;
	}



	public long getItineraryId() {
		return itineraryId;
	}



	public void setItineraryId(long itineraryId) {
		this.itineraryId = itineraryId;
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



	public String getCity() {
		return city;
	}



	public void setCity(String city) {
		this.city = city;
	}



	public String getThumbnailImg() {
		return thumbnailImg;
	}



	public void setThumbnailImg(String thumbnailImg) {
		this.thumbnailImg = thumbnailImg;
	}



	public String getVisibility() {
		return visibility;
	}



	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}



	public int getBookmarkCount() {
		return bookmarkCount;
	}



	public void setBookmarkCount(int bookmarkCount) {
		this.bookmarkCount = bookmarkCount;
	}



	public int getLikeCount() {
		return likeCount;
	}



	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}



	public int getCommentCount() {
		return commentCount;
	}



	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}



	@Override
	public String toString() {
		return "ProfileFeedDto [itineraryId=" + itineraryId + ", title=" + title + ", country=" + country + ", city="
				+ city + ", thumbnailImg=" + thumbnailImg + ", visibility=" + visibility + ", bookmarkCount="
				+ bookmarkCount + ", likeCount=" + likeCount + ", commentCount=" + commentCount + "]";
	}
	
	
	
	
}
