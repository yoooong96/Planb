package dao.support;

import org.apache.ibatis.session.SqlSession;

import dto.support.SupportInquiryDto;

public interface SupportInquiryDao {
	int insertInquiry(SqlSession sqlSession, SupportInquiryDto inquiry) throws Exception;
}
