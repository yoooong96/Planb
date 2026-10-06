package dao.profile;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.profile.ProfileFeedDto;

public class ProfileFeedDaoImpl implements ProfileFeedDao {

	@Override
	public List<ProfileFeedDto> selectMyItineraries(long userId) throws Exception{
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {

			return sqlSession.selectList("mapper.profile.profileFeed.selectMyItineraries", userId);

		} catch (Exception e) {

			e.printStackTrace();

			throw e;

		}
	}

	@Override
	public List<ProfileFeedDto> selectBookmarkedItineraries(long userId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {

			return sqlSession.selectList("mapper.profile.profileFeed.selectBookmarkedItineraries", userId);

		} catch (Exception e) {

			e.printStackTrace();

			throw e;

		}
	}

	@Override
	public List<ProfileFeedDto> selectLikedItineraries(long userId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {

			return sqlSession.selectList("mapper.profile.profileFeed.selectLikedItineraries", userId);

		} catch (Exception e) {

			e.printStackTrace();

			throw e;

		}
	}

	@Override
	public List<ProfileFeedDto> selectPublicItineraries(long userId) throws Exception {
		try (SqlSession sqlSession =
	            MybatisSqlSessionFactory
	                .getSqlSessionFactory()
	                .openSession()) {

	        return sqlSession.selectList(
	                "mapper.profile.profileFeed.selectPublicItineraries",
	                userId
	        );

	    } catch (Exception e) {

	        e.printStackTrace();

	        throw e;
	    }
	}
	
	@Override
	public List<ProfileFeedDto> selectPublicLikedItineraries(
	        long userId) throws Exception {

	    try (SqlSession sqlSession =
	            MybatisSqlSessionFactory
	                .getSqlSessionFactory()
	                .openSession()) {

	        return sqlSession.selectList(
	            "mapper.profile.profileFeed.selectPublicLikedItineraries",
	            userId
	        );
	    }
	}


	@Override
	public List<ProfileFeedDto> selectPublicBookmarkedItineraries(
	        long userId) throws Exception {

	    try (SqlSession sqlSession =
	            MybatisSqlSessionFactory
	                .getSqlSessionFactory()
	                .openSession()) {

	        return sqlSession.selectList(
	            "mapper.profile.profileFeed.selectPublicBookmarkedItineraries",
	            userId
	        );
	    }
	}

}
