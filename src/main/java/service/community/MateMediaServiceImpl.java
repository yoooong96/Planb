package service.community;

import java.util.List;

import dao.community.MateMediaDao;
import dao.community.MateMediaDaoImpl;
import dto.community.MateMediaDto;

public class MateMediaServiceImpl implements MateMediaService {

	private MateMediaDao mateMediaDao = new MateMediaDaoImpl();

	@Override
	public int insertMateMedia(MateMediaDto mateMediaDto) {
		return mateMediaDao.insertMateMedia(mateMediaDto);
	}
	
	@Override
	public List<MateMediaDto> selectMateMediaList(Long mateId) {
		return mateMediaDao.selectMateMediaList(mateId);
	}
}