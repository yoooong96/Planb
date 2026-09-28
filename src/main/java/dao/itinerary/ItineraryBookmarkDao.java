package dao.itinerary;

import dto.itinerary.ItineraryBookmarkDto;

public interface ItineraryBookmarkDao {
	void insertItineraryBookmark(ItineraryBookmarkDto itineraryBookmarkDto) throws Exception;
	void selectItineraryBookmark(ItineraryBookmarkDto itineraryBookmarkDto) throws Exception;
	void updateItineraryBookmark(ItineraryBookmarkDto itineraryBookmarkDto) throws Exception;
	void deleteItineraryBookmark(ItineraryBookmarkDto itineraryBookmarkDto) throws Exception;
}
