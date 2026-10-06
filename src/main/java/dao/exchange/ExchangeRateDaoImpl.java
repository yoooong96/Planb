package dao.exchange;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.exchange.ExchangeRateDto;

public class ExchangeRateDaoImpl implements ExchangeRateDao {

    private static final String NAMESPACE =
            "mapper.exchange.exchangeRate.";

    @Override
    public List<ExchangeRateDto> selectAll(
            SqlSession sqlSession) throws Exception {

        return sqlSession.selectList(
                NAMESPACE + "selectAll"
        );
    }

    @Override
    public Timestamp selectLatestUpdatedAt(
            SqlSession sqlSession) throws Exception {

        return sqlSession.selectOne(
                NAMESPACE + "selectLatestUpdatedAt"
        );
    }

    @Override
    public int upsert(
            SqlSession sqlSession,
            ExchangeRateDto exchangeRate) throws Exception {

        return sqlSession.insert(
                NAMESPACE + "upsert",
                exchangeRate
        );
    }
}
