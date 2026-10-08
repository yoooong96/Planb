package dao.profile;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.profile.ProfileActivityDto;

public class ProfileActivityDaoImpl implements ProfileActivityDao {

	@Override
	public List<ProfileActivityDto> selectProfileActivities(long userId) throws Exception {
		SqlSession session= null;
		
		try {
			session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
			return session.selectList("mapper.profile.profileFeed.selectProfileActivities", userId);
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

}
