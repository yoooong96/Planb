package dao.itinerary;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.itinerary.ItineraryBlockImageDto;

public interface ItineraryBlockImageDao {

    int insertItineraryBlockImage(
            SqlSession sqlSession,
            ItineraryBlockImageDto itineraryBlockImageDto
    ) throws Exception;

    List<ItineraryBlockImageDto> selectItineraryBlockImages(
            SqlSession sqlSession,
            Long blockId
    ) throws Exception;

    int updateItineraryBlockImage(
            SqlSession sqlSession,
            ItineraryBlockImageDto itineraryBlockImageDto
    ) throws Exception;

    int deleteItineraryBlockImagesByBlockId(
            SqlSession sqlSession,
            Long blockId
    ) throws Exception;
}
