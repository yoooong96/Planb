package dao.itinerary;

import org.apache.ibatis.session.SqlSession;

import dto.itinerary.ItineraryLikeDto;

public interface ItineraryLikeDao {

	int countItineraryLikes(SqlSession sqlSession, Long itineraryId) throws Exception;

	boolean selectItineraryLike(SqlSession sqlSession, ItineraryLikeDto like) throws Exception;

	int insertItineraryLike(SqlSession sqlSession, ItineraryLikeDto like) throws Exception;

	int deleteItineraryLike(SqlSession sqlSession, ItineraryLikeDto like) throws Exception;
}