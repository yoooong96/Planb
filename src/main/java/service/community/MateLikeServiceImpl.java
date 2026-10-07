package service.community;

import dao.community.MateLikeDao;
import dao.community.MateLikeDaoImpl;
import dto.community.MateLikeDto;

public class MateLikeServiceImpl implements MateLikeService {

	private MateLikeDao mateLikeDao = new MateLikeDaoImpl();

	@Override
	public boolean toggleMateLike(Long mateId, Long userId) {
		MateLikeDto mateLike = mateLikeDao.selectMateLike(mateId, userId);

		if (mateLike == null) {
			MateLikeDto mateLikeDto = new MateLikeDto();
			mateLikeDto.setMateId(mateId);
			mateLikeDto.setUserId(userId);

			mateLikeDao.insertMateLike(mateLikeDto);

			return true;
		}

		mateLikeDao.deleteMateLike(mateId, userId);

		return false;
	}

	@Override
	public boolean isLiked(Long mateId, Long userId) {
		return mateLikeDao.selectMateLike(mateId, userId) != null;
	}

	@Override
	public int countMateLike(Long mateId) {
		return mateLikeDao.countMateLike(mateId);
	}
}