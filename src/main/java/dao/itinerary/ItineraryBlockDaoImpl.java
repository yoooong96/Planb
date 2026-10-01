package dao.itinerary;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.itinerary.ItineraryBlockDto;

public class ItineraryBlockDaoImpl implements ItineraryBlockDao {

    private static final String NAMESPACE = "mapper.itinerary.itineraryBlock.";

    @Override
    public int insertItineraryBlock(
            SqlSession sqlSession,
            ItineraryBlockDto itineraryBlockDto
    ) throws Exception {

        return sqlSession.insert(
                NAMESPACE + "insertItineraryBlock",
                itineraryBlockDto
        );
    }

    @Override
    public List<ItineraryBlockDto> selectItineraryBlocks(
            SqlSession sqlSession,
            Long dayId
    ) throws Exception {

        return sqlSession.selectList(
                NAMESPACE + "selectItineraryBlocks",
                dayId
        );
    }

    @Override
    public int updateItineraryBlock(
            SqlSession sqlSession,
            ItineraryBlockDto itineraryBlockDto
    ) throws Exception {

        return sqlSession.update(
                NAMESPACE + "updateItineraryBlock",
                itineraryBlockDto
        );
    }

    @Override
    public int deleteItineraryBlocksByDayId(
            SqlSession sqlSession,
            Long dayId
    ) throws Exception {

        return sqlSession.delete(
                NAMESPACE + "deleteItineraryBlocksByDayId",
                dayId
        );
    }
}
