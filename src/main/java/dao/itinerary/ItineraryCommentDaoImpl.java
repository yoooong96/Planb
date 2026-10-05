package dao.itinerary;

import org.apache.ibatis.session.SqlSession;

public class ItineraryCommentDaoImpl implements ItineraryCommentDao {

	@Override
	public int countItineraryComments(SqlSession sqlSession, Long itineraryId) throws Exception {
		return sqlSession.selectOne("mapper.itinerary.itineraryComment.countItineraryComments", itineraryId);
	}
}
