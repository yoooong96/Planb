package dao.itinerary;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.itinerary.ItineraryDayDto;

public interface ItineraryDayDao {

    int insertItineraryDay(SqlSession sqlSession, ItineraryDayDto itineraryDayDto) throws Exception;

    List<ItineraryDayDto> selectItineraryDays(
            SqlSession sqlSession,
            Long itineraryId
    ) throws Exception;

    int updateItineraryDay(
            SqlSession sqlSession,
            ItineraryDayDto itineraryDayDto
    ) throws Exception;

    int deleteItineraryDaysByItineraryId(
            SqlSession sqlSession,
            Long itineraryId
    ) throws Exception;
}
