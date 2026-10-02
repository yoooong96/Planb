package dao.itinerary;

import org.apache.ibatis.session.SqlSession;

import dto.itinerary.ItineraryBookmarkDto;
import dto.itinerary.ItineraryDto;

public class ItineraryBookmarkDaoImpl implements ItineraryBookmarkDao {

	@Override
	public int insertItineraryBookmark(SqlSession sqlSession, ItineraryBookmarkDto bookmark) throws Exception {
		
		return sqlSession.insert("mapper.itinerary.itineraryBookmark.insertItineraryBookmark",bookmark);
	}

	@Override
	public boolean selectItineraryBookmark(SqlSession sqlSession, ItineraryBookmarkDto bookmark) throws Exception {
		return sqlSession.selectOne("mapper.itinerary.itineraryBookmark.selectItineraryBookmark", bookmark);
	}

	@Override
	public int deleteItineraryBookmark(SqlSession sqlSession, ItineraryBookmarkDto bookmark) throws Exception {
		return sqlSession.delete("mapper.itinerary.itineraryBookmark.deleteItineraryBookmark", bookmark);
	}

	@Override
	public ItineraryDto selectBookmarkTargetForUpdate(SqlSession sqlSession,Long itineraryId) throws Exception {
	    return sqlSession.selectOne("mapper.itinerary.itineraryBookmark.selectBookmarkTargetForUpdate",itineraryId);
	}

}
