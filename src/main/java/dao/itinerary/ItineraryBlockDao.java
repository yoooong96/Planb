package dao.itinerary;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.itinerary.ItineraryBlockDto;

public interface ItineraryBlockDao {

    int insertItineraryBlock(
            SqlSession sqlSession,
            ItineraryBlockDto itineraryBlockDto
    ) throws Exception;

    List<ItineraryBlockDto> selectItineraryBlocks(
            SqlSession sqlSession,
            Long dayId
    ) throws Exception;

    int updateItineraryBlock(
            SqlSession sqlSession,
            ItineraryBlockDto itineraryBlockDto
    ) throws Exception;

    int deleteItineraryBlocksByDayId(
            SqlSession sqlSession,
            Long dayId
    ) throws Exception;
}
