package dao.itinerary;

import org.apache.ibatis.session.SqlSession;

import dto.itinerary.ItineraryDto;

public interface ItineraryDao {

    int insertItinerary(SqlSession sqlSession, ItineraryDto itineraryDto) throws Exception;

    ItineraryDto selectItinerary(SqlSession sqlSession, Long itineraryId) throws Exception;

    int updateItinerary(SqlSession sqlSession, ItineraryDto itineraryDto) throws Exception;

    int deleteItinerary(SqlSession sqlSession, Long itineraryId, Long userId) throws Exception;
}
