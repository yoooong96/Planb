package dao.itinerary;

import dto.itinerary.ItineraryLikeDto;

public interface ItineraryLikeDao {
	void insertItineraryLike(ItineraryLikeDto itineraryLikeDto) throws Exception;
	void selectItineraryLike(ItineraryLikeDto itineraryLikeDto) throws Exception;
	void updateItineraryLike(ItineraryLikeDto itineraryLikeDto) throws Exception;
	void deleteItineraryLike(ItineraryLikeDto itineraryLikeDto) throws Exception;
}
