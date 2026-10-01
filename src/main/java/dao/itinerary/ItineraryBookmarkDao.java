package dao.itinerary;

import org.apache.ibatis.session.SqlSession;

import dto.itinerary.ItineraryBookmarkDto;
import dto.itinerary.ItineraryDto;

public interface ItineraryBookmarkDao {

    int insertItineraryBookmark(SqlSession sqlSession,ItineraryBookmarkDto bookmark) throws Exception;

    boolean selectItineraryBookmark(SqlSession sqlSession,ItineraryBookmarkDto bookmark) throws Exception;

    int deleteItineraryBookmark(SqlSession sqlSession,ItineraryBookmarkDto bookmark) throws Exception;
    
    ItineraryDto selectBookmarkTargetForUpdate(SqlSession sqlSession,Long itineraryId) throws Exception;
}