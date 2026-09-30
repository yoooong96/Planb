package dto.itinerary;

public class ItineraryBlockImageDto {
	private long image_id;
	private long block_id;
	private String image_url;
	private int image_order;
	public ItineraryBlockImageDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ItineraryBlockImageDto(long image_id, long block_id, String image_url, int image_order) {
		super();
		this.image_id = image_id;
		this.block_id = block_id;
		this.image_url = image_url;
		this.image_order = image_order;
	}
	public long getImage_id() {
		return image_id;
	}
	public void setImage_id(long image_id) {
		this.image_id = image_id;
	}
	public long getBlock_id() {
		return block_id;
	}
	public void setBlock_id(long block_id) {
		this.block_id = block_id;
	}
	public String getImage_url() {
		return image_url;
	}
	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}
	public int getImage_order() {
		return image_order;
	}
	public void setImage_order(int image_order) {
		this.image_order = image_order;
	}
	@Override
	public String toString() {
		return "ItineraryBlockImageDto [image_id=" + image_id + ", block_id=" + block_id + ", image_url=" + image_url
				+ ", image_order=" + image_order + "]";
	}
	
}
