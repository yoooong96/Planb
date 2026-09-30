package dao.member;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.member.UserDto;

public class UserDaoImpl implements UserDao {

	@Override
	public void insertUser(UserDto userDto) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.member.user.insertUser", userDto);
			sqlSession.commit();
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}

	}

	@Override
	public void selectUser(UserDto userDto) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void updateUser(UserDto userDto) throws Exception {
		// TODO Auto-generated method stub

	}

}
