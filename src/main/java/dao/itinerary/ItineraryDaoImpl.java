package dao.itinerary;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.itinerary.ItineraryDto;

public class ItineraryDaoImpl implements ItineraryDao {

    private static final String NAMESPACE = "mapper.itinerary.itinerary.";

    @Override
    public int insertItinerary(SqlSession sqlSession, ItineraryDto itineraryDto) throws Exception {
        return sqlSession.insert(
                NAMESPACE + "insertItinerary",
                itineraryDto
        );
    }

    @Override
    public ItineraryDto selectItinerary(SqlSession sqlSession, Long itineraryId) throws Exception {
        return sqlSession.selectOne(
                NAMESPACE + "selectItinerary",
                itineraryId
        );
    }

    @Override
    public int updateItinerary(SqlSession sqlSession, ItineraryDto itineraryDto) throws Exception {
        return sqlSession.update(
                NAMESPACE + "updateItinerary",
                itineraryDto
        );
    }

    @Override
    public int deleteItinerary(SqlSession sqlSession, Long itineraryId, Long userId) throws Exception {

        Map<String, Object> param = new HashMap<>();
        param.put("itineraryId", itineraryId);
        param.put("userId", userId);

        return sqlSession.update(
                NAMESPACE + "deleteItinerary",
                param
        );
    }
}
