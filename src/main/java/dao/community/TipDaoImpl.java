package dao.community;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.community.TipDto;

public class TipDaoImpl implements TipDao {

	@Override
	public int insertTip(TipDto tipDto) {
		// TODO Auto-generated method stub
		return 0;
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
}