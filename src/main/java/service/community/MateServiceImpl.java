package service.community;

import java.util.List;

import dao.community.MateDao;
import dao.community.MateDaoImpl;
import dto.community.MateDto;

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
		return mateDao.selectMate(mateId);
	}

	@Override
	public int updateMate(MateDto mateDto) {
		return mateDao.updateMate(mateDto);
	}
	
	@Override
	public int updateMateImage(MateDto mateDto) {
		return mateDao.updateMateImage(mateDto);
	}

	@Override
	public int deleteMate(long mateId, long userId) {
		MateDto mateDto = new MateDto();

		mateDto.setMateId(mateId);
		mateDto.setUserId(userId);

		return mateDao.deleteMate(mateDto);
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
	
	@Override
	public List<MateDto> selectMateWriteList(Long userId, int pageSize, int offset) {
		return mateDao.selectMateWriteList(userId, pageSize, offset);
	}

	@Override
	public int countMateWriteList(Long userId) {
		return mateDao.countMateWriteList(userId);
	}
	
	@Override
	public int updateMateViewCount(Long mateId) {
		return mateDao.updateMateViewCount(mateId);
	}
	
	@Override
	public int updateRecruitStatus(long mateId, long userId, String recruitStatus) {

		MateDto mateDto = new MateDto();

		mateDto.setMateId(mateId);
		mateDto.setUserId(userId);
		mateDto.setRecruitStatus(recruitStatus);

		return mateDao.updateRecruitStatus(mateDto);
	}

}
