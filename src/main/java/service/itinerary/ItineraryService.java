package service.itinerary;

import java.util.List;

import dto.itinerary.ItineraryDto;

public interface ItineraryService {
	List<ItineraryDto> getScheduleList(Long loginUserId) throws Exception;
	
    Long writeItinerary(ItineraryDto itineraryDto) throws Exception;

    void modifyItinerary(ItineraryDto itineraryDto) throws Exception;

    ItineraryDto getItinerary(Long itineraryId) throws Exception;

    void deleteItinerary(Long itineraryId, Long userId) throws Exception;
}
