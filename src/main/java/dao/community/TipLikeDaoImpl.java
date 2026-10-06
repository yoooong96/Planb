package dao.community;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.community.TipLikeDto;

public class TipLikeDaoImpl implements TipLikeDao {

    // 좋아요 등록
    @Override
    public int insertTipLike(TipLikeDto tipLikeDto) {
        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            int result = sqlSession.insert("mapper.community.tipLike.insertTipLike", tipLikeDto);
            sqlSession.commit();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    // 좋아요 여부 조회
    @Override
    public TipLikeDto selectTipLike(TipLikeDto tipLikeDto) {
        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sqlSession.selectOne("mapper.community.tipLike.selectTipLike",tipLikeDto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    // 좋아요 취소
    @Override
    public int deleteTipLike(TipLikeDto tipLikeDto) {
        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            int result = sqlSession.delete("mapper.community.tipLike.deleteTipLike", tipLikeDto);
            sqlSession.commit();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    @Override
    public int selectTipLikeCount(long tipId) {
        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sqlSession.selectOne("mapper.community.tipLike.selectTipLikeCount", tipId);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}