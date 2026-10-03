package dao.community;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.community.TipDto;

public class TipDaoImpl implements TipDao {

	@Override
	public int insertTip(TipDto tipDto) {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = sqlSession.insert("mapper.community.tip.insertTip", tipDto);
			sqlSession.commit();
			return result;
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public TipDto selectTip(Long tipId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateTip(TipDto tipDto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteTip(Long tipId) {
		// TODO Auto-generated method stub
		return 0;
	}

	// 여행꿀팁 전체 조회
	@Override
	public List<TipDto> selectTipList() {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.community.tip.selectTipList");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	// 해시태그 검색
	@Override
	public List<TipDto> searchTipByHashtag(String keyword) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.community.tip.searchTipByHashtag", keyword);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<TipDto> selectTipListByFilter(String country, String keyword, String sort) {
		Map<String, Object> param = new HashMap<>();
		param.put("country", country);
		param.put("keyword", keyword);
		param.put("sort", sort);
		
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.community.tip.selectTipListByFilter", param);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}