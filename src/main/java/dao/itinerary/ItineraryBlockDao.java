package dao.itinerary;

import dto.itinerary.ItineraryBlockDto;

public interface ItineraryBlockDao {
	void insertItineraryBlock(ItineraryBlockDto itineraryBlockDto) throws Exception;
	void selectItineraryBlock(ItineraryBlockDto itineraryBlockDto) throws Exception;
	void updateItineraryBlock(ItineraryBlockDto itineraryBlockDto) throws Exception;
	void deleteItineraryBlock(ItineraryBlockDto itineraryBlockDto) throws Exception;
}
