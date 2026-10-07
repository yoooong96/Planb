package dao.community;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.community.MateCommentDto;

public class MateCommentDaoImpl implements MateCommentDao {

	@Override
	public int insertMateComment(MateCommentDto mateCommentDto) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

		try {
			int result = sqlSession.insert("mapper.community.mateComment.insertMateComment", mateCommentDto);

			if (result > 0) {
				sqlSession.commit();
			}

			return result;

		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<MateCommentDto> selectMateCommentList(Long mateId) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

		try {
			return sqlSession.selectList("mapper.community.mateComment.selectMateCommentList", mateId);

		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int countMateComment(Long mateId) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

		try {
			return sqlSession.selectOne("mapper.community.mateComment.countMateComment", mateId);

		} finally {
			sqlSession.close();
		}
	}
}