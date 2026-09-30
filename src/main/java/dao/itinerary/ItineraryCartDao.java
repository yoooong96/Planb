package dao.itinerary;

import dto.itinerary.ItineraryCartDto;

public interface ItineraryCartDao {
	void insertCartItem(ItineraryCartDto cartItemDto) throws Exception;
	void selectCartItem(ItineraryCartDto cartItemDto) throws Exception;
	void updateCartItem(ItineraryCartDto cartItemDto) throws Exception;
	void deleteCartItem(ItineraryCartDto cartItemDto) throws Exception;
}
