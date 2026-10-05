package service.itinerary;

import java.util.List;

import dto.itinerary.ItineraryDto;

public interface ItineraryService {
	List<ItineraryDto> getScheduleList(Long loginUserId) throws Exception;

    List<ItineraryDto> getScheduleList(Long loginUserId, String keyword) throws Exception;
    
    List<ItineraryDto> getScheduleList(Long loginUserId, String keyword, String country) throws Exception;
    
    List<ItineraryDto> getScheduleList(Long loginUserId, String keyword, String country, String[] durations, String[] budgets, String[] travelers) throws Exception;
    
    List<ItineraryDto> getScheduleList(Long loginUserId, String keyword, String country, String[] durations, String[] budgets, String[] travelers, String sort) throws Exception;
    
    long countScheduleList(String keyword, String country, String[] durations, String[] budgets, String[] travelers) throws Exception;
    
    List<ItineraryDto> getScheduleList(Long loginUserId, String keyword, String country, String[] durations, String[] budgets, String[] travelers, String sort, int offset) throws Exception;
	
    Long writeItinerary(ItineraryDto itineraryDto) throws Exception;

    void modifyItinerary(ItineraryDto itineraryDto) throws Exception;

    ItineraryDto getItinerary(Long itineraryId) throws Exception;

    void deleteItinerary(Long itineraryId, Long userId) throws Exception;
    
    boolean toggleBookmark(Long itineraryId,Long loginUserId) throws Exception;

}
