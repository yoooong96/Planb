package service.community;

import java.util.List;

import dto.community.MateDto;
import dao.community.MateDao;
import dao.community.MateDaoImpl;

public class MateServiceImpl implements MateService {
	private MateDao mateDao = new MateDaoImpl();
	
	public MateServiceImpl() {
		mateDao = new MateDaoImpl();
	}
	
	@Override
	public int insertMate(MateDto mateDto) {
		return mateDao.insertMate(mateDto);
	}

	@Override
	public MateDto selectMate(Long mateId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateMate(MateDto mateDto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteMate(Long mateId) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<MateDto> selectMateList() {
		return mateDao.selectMateList();
	}

	@Override
	public List<MateDto> selectMateListByFilter(List<String> countryKeywords, String keyword, String sort, int pageSize, int offset) {
		return mateDao.selectMateListByFilter(countryKeywords, keyword, sort, pageSize, offset);
	}

	@Override
	public int countMateListByFilter(List<String> countryKeywords, String keyword) {
		return mateDao.countMateListByFilter(countryKeywords, keyword);
	}

}
