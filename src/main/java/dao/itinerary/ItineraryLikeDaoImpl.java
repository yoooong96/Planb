package dao.itinerary;

import org.apache.ibatis.session.SqlSession;

import dto.itinerary.ItineraryLikeDto;

public class ItineraryLikeDaoImpl implements ItineraryLikeDao {

	@Override
	public int countItineraryLikes(SqlSession sqlSession, Long itineraryId) throws Exception {

		return sqlSession.selectOne("mapper.itinerary.itineraryLike.countItineraryLikes", itineraryId);
	}

	@Override
	public boolean selectItineraryLike(SqlSession sqlSession, ItineraryLikeDto like) throws Exception {

		return sqlSession.selectOne("mapper.itinerary.itineraryLike.selectItineraryLike", like);
	}

	@Override
	public int insertItineraryLike(SqlSession sqlSession, ItineraryLikeDto like) throws Exception {

		return sqlSession.insert("mapper.itinerary.itineraryLike.insertItineraryLike", like);
	}

	@Override
	public int deleteItineraryLike(SqlSession sqlSession, ItineraryLikeDto like) throws Exception {

		return sqlSession.delete("mapper.itinerary.itineraryLike.deleteItineraryLike", like);
	}
}