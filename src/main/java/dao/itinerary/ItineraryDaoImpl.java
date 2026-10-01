package dao.itinerary;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.itinerary.ItineraryDto;

public class ItineraryDaoImpl implements ItineraryDao {

	@Override
	public void insertItinerary(ItineraryDto itineraryDto) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void selectItinerary(ItineraryDto itineraryDto) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void updateItinerary(ItineraryDto itineraryDto) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteItinerary(ItineraryDto itineraryDto) throws Exception {
		// TODO Auto-generated method stub

	}

	//26.10.01 추가.
	@Override
	public List<ItineraryDto> selectScheduleList(Map<String, Object> params) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.itinerary.itinerary.selectScheduleList",params);
		}
	}

}
