package dao.community;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.community.MateMediaDto;

public class MateMediaDaoImpl implements MateMediaDao {

	@Override
	public int insertMateMedia(MateMediaDto mateMediaDto) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = sqlSession.insert("mapper.community.mateMedia.insertMateMedia", mateMediaDto);
			if (result > 0) {
				sqlSession.commit();
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public MateMediaDto selectMateMedia(Long mediaId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateMateMedia(MateMediaDto mateMediaDto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteMateMedia(Long mediaId) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public List<MateMediaDto> selectMateMediaList(Long mateId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.community.mateMedia.selectMateMediaList", mateId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
