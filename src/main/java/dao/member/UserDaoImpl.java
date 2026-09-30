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
	public UserDto selectUser(String id) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.member.user.selectUser", id);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

	@Override
	public void updateUser(UserDto userDto) throws Exception {
		// TODO Auto-generated method stub

	}

}
