package service.community;

import java.util.List;

import dao.community.MateCommentDao;
import dao.community.MateCommentDaoImpl;
import dto.community.MateCommentDto;

public class MateCommentServiceImpl implements MateCommentService {

	private MateCommentDao mateCommentDao = new MateCommentDaoImpl();

	@Override
	public int insertMateComment(MateCommentDto mateCommentDto) {
		return mateCommentDao.insertMateComment(mateCommentDto);
	}

	@Override
	public List<MateCommentDto> selectMateCommentList(Long mateId) {
		return mateCommentDao.selectMateCommentList(mateId);
	}

	@Override
	public int countMateComment(Long mateId) {
		return mateCommentDao.countMateComment(mateId);
	}
}