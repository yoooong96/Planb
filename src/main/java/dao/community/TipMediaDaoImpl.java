package dao.community;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.community.TipMediaDto;


public class TipMediaDaoImpl implements TipMediaDao {

	@Override
	public int insertTipMedia(TipMediaDto tipMediaDto) {
	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        int result = sqlSession.insert("mapper.community.tipMedia.insertTipMedia", tipMediaDto);
	        sqlSession.commit();
	        return result;
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	}

	@Override
	public TipMediaDto selectTipMedia(Long mediaId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateTipMedia(TipMediaDto tipMediaDto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteTipMedia(Long mediaId) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<TipMediaDto> selectTipMediaList(long tipId) {
	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        return sqlSession.selectList("mapper.community.tipMedia.selectTipMediaList",  tipId);
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	}

}
