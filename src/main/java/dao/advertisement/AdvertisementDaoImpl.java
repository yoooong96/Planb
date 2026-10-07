package dao.advertisement;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.advertisement.AdvertisementDto;

public class AdvertisementDaoImpl implements AdvertisementDao {

	@Override
	public int insertAdvertisement(SqlSession sqlSession, AdvertisementDto advertisement) throws Exception {
		return sqlSession.insert("mapper.advertisement.advertisement.insertAdvertisement", advertisement);
	}

	@Override
	public int insertSubmittedHistory(SqlSession sqlSession, long adId, String recipientEmail) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("adId", adId);
		params.put("recipientEmail", recipientEmail);
		return sqlSession.insert("mapper.advertisement.advertisement.insertSubmittedHistory", params);
	}

	

}
