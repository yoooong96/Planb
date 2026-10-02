package dao.community;

import dto.community.MateLikeDto;

public interface MateLikeDao {

	int insertMateLike(MateLikeDto mateLikeDto);

	MateLikeDto selectMateLike(MateLikeDto mateLikeDto);

	int deleteMateLike(MateLikeDto mateLikeDto);
}