package service.itinerary;

import dto.itinerary.ItineraryDto;

public interface ItineraryService {

    Long writeItinerary(ItineraryDto itineraryDto) throws Exception;

    void modifyItinerary(ItineraryDto itineraryDto) throws Exception;

    ItineraryDto getItinerary(Long itineraryId) throws Exception;

    void deleteItinerary(Long itineraryId, Long userId) throws Exception;
}
