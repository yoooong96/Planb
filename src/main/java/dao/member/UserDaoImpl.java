package dao.member;

import java.util.HashMap;
import java.util.Map;

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

	@Override
	public int withdrawUser(long userId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			int result = sqlSession.update("mapper.member.user.withdrawUser", userId);
			if(result > 0) {
				sqlSession.commit();
			}
			return result;
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		 
	}

	@Override
	public String selectPasswordByUserId(long userId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.member.user.selectPasswordByUserId", userId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Long findPasswordUser(String loginId, String name, String email, String phone) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {

			Map<String, Object> param = new HashMap<>();
			param.put("loginId", loginId);
			param.put("name", name);
			param.put("email", email);
			param.put("phone", phone);
			
			return sqlSession.selectOne("mapper.member.user.findPasswordUser", param);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int resetPassword(Long userId, String password)throws Exception {
		
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			Map<String, Object> param = new HashMap<>();
			param.put("userId", userId);
			param.put("password", password);
			int result = sqlSession.update("mapper.member.user.resetPassword", param);
			if (result > 0) {
				sqlSession.commit();
			} else {
				sqlSession.rollback();
			}
			return result;
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int countLoginId(String loginId) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		return sqlSession.selectOne("mapper.member.user.countLoginId", loginId);
	}

	@Override
	public int countNickname(String nickname) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		return sqlSession.selectOne("mapper.member.user.countNickname", nickname);
	}

	@Override
	public int countEmail(String email) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		return sqlSession.selectOne("mapper.member.user.countEmail", email);
	}

}
