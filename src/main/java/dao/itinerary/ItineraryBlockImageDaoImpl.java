package dao.itinerary;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.itinerary.ItineraryBlockImageDto;

public class ItineraryBlockImageDaoImpl implements ItineraryBlockImageDao {

    private static final String NAMESPACE = "mapper.itinerary.itineraryBlockImage.";

    @Override
    public int insertItineraryBlockImage(
            SqlSession sqlSession,
            ItineraryBlockImageDto itineraryBlockImageDto
    ) throws Exception {

        return sqlSession.insert(
                NAMESPACE + "insertItineraryBlockImage",
                itineraryBlockImageDto
        );
    }

    @Override
    public List<ItineraryBlockImageDto> selectItineraryBlockImages(
            SqlSession sqlSession,
            Long blockId
    ) throws Exception {

        return sqlSession.selectList(
                NAMESPACE + "selectItineraryBlockImages",
                blockId
        );
    }

    @Override
    public int updateItineraryBlockImage(
            SqlSession sqlSession,
            ItineraryBlockImageDto itineraryBlockImageDto
    ) throws Exception {

        return sqlSession.update(
                NAMESPACE + "updateItineraryBlockImage",
                itineraryBlockImageDto
        );
    }

    @Override
    public int deleteItineraryBlockImagesByBlockId(
            SqlSession sqlSession,
            Long blockId
    ) throws Exception {

        return sqlSession.delete(
                NAMESPACE + "deleteItineraryBlockImagesByBlockId",
                blockId
        );
    }
}
