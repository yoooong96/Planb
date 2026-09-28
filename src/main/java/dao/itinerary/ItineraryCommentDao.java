package dao.itinerary;

import dto.itinerary.ItineraryCommentDto;

public interface ItineraryCommentDao {
	void insertItineraryComment(ItineraryCommentDto itineraryCommentDto) throws Exception;
	void selectItineraryComment(ItineraryCommentDto itineraryCommentDto) throws Exception;
	void updateItineraryComment(ItineraryCommentDto itineraryCommentDto) throws Exception;
	void deleteItineraryComment(ItineraryCommentDto itineraryCommentDto) throws Exception;
}