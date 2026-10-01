package dao.itinerary;

import java.util.List;
import java.util.Map;

import dto.itinerary.ItineraryDto;

public interface ItineraryDao {
	void insertItinerary(ItineraryDto itineraryDto) throws Exception;
	void selectItinerary(ItineraryDto itineraryDto) throws Exception;
	void updateItinerary(ItineraryDto itineraryDto) throws Exception;
	void deleteItinerary(ItineraryDto itineraryDto) throws Exception;
	
	// 공개 일정 목록 조회 26.10.01 추가
    List<ItineraryDto> selectScheduleList(Map<String, Object> params) throws Exception;
}
