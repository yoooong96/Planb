package service.itinerary;

import java.util.List;
import java.util.Map;

import dto.itinerary.ItineraryDto;

public interface ItineraryCartService {

	/*
	 * 카트와 planner 일정 가져오기가 공통으로 사용하는 조회 결과.
	 */
	List<ItineraryDto> getCartItineraries(Long userId) throws Exception;

	void addItinerary(Long userId, Long itineraryId) throws Exception;

	void addDay(Long userId, Long dayId) throws Exception;

	void addBlock(Long userId, Long blockId) throws Exception;

	void removeItinerary(Long userId, Long itineraryId) throws Exception;

	void removeDay(Long userId, Long dayId) throws Exception;

	void removeBlock(Long userId, Long blockId) throws Exception;

	// 새 서비스
	////////////////////////////////////////////////////////////////////////////
	
	Map<String, Object> addToCart(Long loginUserId, Long itineraryId, String itemType, Long targetId) throws Exception;
}
