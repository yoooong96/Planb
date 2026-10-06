package dao.exchange;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.exchange.ExchangeRateDto;

public interface ExchangeRateDao {

    List<ExchangeRateDto> selectAll(
            SqlSession sqlSession) throws Exception;

    Timestamp selectLatestUpdatedAt(
            SqlSession sqlSession) throws Exception;

    int upsert(
            SqlSession sqlSession,
            ExchangeRateDto exchangeRate) throws Exception;
}
