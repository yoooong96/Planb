package dao.advertisement;

import org.apache.ibatis.session.SqlSession;

import dto.advertisement.AdvertisementDto;

public interface AdvertisementDao {
	int insertAdvertisement(SqlSession sqlSession, AdvertisementDto advertisement) throws Exception;
	int insertSubmittedHistory(SqlSession sqlSession, long adId, String recipientEmail) throws Exception;
}