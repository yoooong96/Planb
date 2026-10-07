package dao.support;

import org.apache.ibatis.session.SqlSession;

import dto.support.SupportInquiryDto;

public class SupportInquiryDaoImpl implements SupportInquiryDao {

	@Override
	public int insertInquiry(SqlSession sqlSession, SupportInquiryDto inquiry) throws Exception {
		return sqlSession.insert("mapper.support.inquiry.insertInquiry", inquiry);
	}

}
