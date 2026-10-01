package service.itinerary;

import java.util.List;

import dto.itinerary.ItineraryDto;

public interface ItineraryService {
	List<ItineraryDto> getScheduleList(Long loginUserId) throws Exception;
}
