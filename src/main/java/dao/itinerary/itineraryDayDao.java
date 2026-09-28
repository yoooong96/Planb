package dao.itinerary;

import dto.itinerary.ItineraryDayDto;

public interface itineraryDayDao {
	void insertItineraryDay(ItineraryDayDto itineraryDayDto) throws Exception;
    void selectItineraryDay(ItineraryDayDto itineraryDayDto) throws Exception;
    void updateItineraryDay(ItineraryDayDto itineraryDayDto) throws Exception;
    void deleteItineraryDay(ItineraryDayDto itineraryDayDto) throws Exception;
}
