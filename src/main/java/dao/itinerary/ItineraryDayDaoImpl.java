package dao.itinerary;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.itinerary.ItineraryDayDto;

public class ItineraryDayDaoImpl implements ItineraryDayDao {

    private static final String NAMESPACE = "mapper.itinerary.itineraryDay.";

    @Override
    public int insertItineraryDay(
            SqlSession sqlSession,
            ItineraryDayDto itineraryDayDto
    ) throws Exception {

        return sqlSession.insert(
                NAMESPACE + "insertItineraryDay",
                itineraryDayDto
        );
    }

    @Override
    public List<ItineraryDayDto> selectItineraryDays(
            SqlSession sqlSession,
            Long itineraryId
    ) throws Exception {

        return sqlSession.selectList(
                NAMESPACE + "selectItineraryDays",
                itineraryId
        );
    }

    @Override
    public int updateItineraryDay(
            SqlSession sqlSession,
            ItineraryDayDto itineraryDayDto
    ) throws Exception {

        return sqlSession.update(
                NAMESPACE + "updateItineraryDay",
                itineraryDayDto
        );
    }

    @Override
    public int deleteItineraryDaysByItineraryId(
            SqlSession sqlSession,
            Long itineraryId
    ) throws Exception {

        return sqlSession.delete(
                NAMESPACE + "deleteItineraryDaysByItineraryId",
                itineraryId
        );
    }
}
