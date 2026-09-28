package dao.itinerary;

import dto.itinerary.ItineraryDto;

public interface ItineraryDao {
	void insertItinerary(ItineraryDto itineraryDto) throws Exception;
	void selectItinerary(ItineraryDto itineraryDto) throws Exception;
	void updateItinerary(ItineraryDto itineraryDto) throws Exception;
	void deleteItinerary(ItineraryDto itineraryDto) throws Exception;
}
