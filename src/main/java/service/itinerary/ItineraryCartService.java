package service.itinerary;

import java.util.List;
import java.util.Map;

import dto.itinerary.ItineraryDto;

public interface ItineraryCartService {

    List<ItineraryDto> getCartItineraries(Long userId) throws Exception;

    void removeItinerary(Long userId, Long itineraryId) throws Exception;

    void removeDay(Long userId, Long dayId) throws Exception;

    void removeBlock(Long userId, Long blockId) throws Exception;

    Map<String, Object> addToCart(Long loginUserId, Long itineraryId, String itemType, Long targetId) throws Exception;

    int getCartCount(Long loginUserId) throws Exception;
}
