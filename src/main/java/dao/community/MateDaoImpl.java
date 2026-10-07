package dao.community;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.community.MateDto;

public class MateDaoImpl implements MateDao {

	@Override
	public int insertMate(MateDto mateDto) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = sqlSession.insert("mapper.community.mate.insertMate", mateDto);
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
	public MateDto selectMate(Long mateId) {
		// TODO 상세페이지 구현할 때 연결
		return null;
	}

	@Override
	public int updateMate(MateDto mateDto) {
		// TODO 수정 구현할 때 연결
		return 0;
	}

	@Override
	public int deleteMate(Long mateId) {
		// TODO 삭제 구현할 때 연결
		return 0;
	}

	// 여행메이트 전체 조회
	@Override
	public List<MateDto> selectMateList() {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.community.mate.selectMateList");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	// 국가 + 검색 + 정렬 + 페이지 처리
	@Override
	public List<MateDto> selectMateListByFilter(List<String> countryKeywords, String keyword, String sort, int pageSize, int offset) {
		Map<String, Object> param = new HashMap<>();

		param.put("countryKeywords", countryKeywords);
		param.put("keyword", keyword);
		param.put("sort", sort);

		// 페이지 처리
		param.put("pageSize", pageSize);
		param.put("offset", offset);

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.community.mate.selectMateListByFilter",param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	// 검색 + 국가 조건에 맞는 전체 게시글 수
	@Override
	public int countMateListByFilter(List<String> countryKeywords, String keyword) {
		Map<String, Object> param = new HashMap<>();

		param.put("countryKeywords", countryKeywords);
		param.put("keyword", keyword);

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.community.mate.countMateListByFilter", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}