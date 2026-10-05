package dao.itinerary;

import org.apache.ibatis.session.SqlSession;

public interface ItineraryCommentDao {
	int countItineraryComments(SqlSession sqlSession, Long itineraryId) throws Exception;
}