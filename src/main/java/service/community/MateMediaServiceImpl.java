package service.community;

import dao.community.MateMediaDao;
import dao.community.MateMediaDaoImpl;
import dto.community.MateMediaDto;

public class MateMediaServiceImpl implements MateMediaService {

	private MateMediaDao mateMediaDao = new MateMediaDaoImpl();

	@Override
	public int insertMateMedia(MateMediaDto mateMediaDto) {
		return mateMediaDao.insertMateMedia(mateMediaDto);
	}
}