package dao.community;

import dto.community.MateLikeDto;

public interface MateLikeDao {

	int insertMateLike(MateLikeDto mateLikeDto);

	MateLikeDto selectMateLike(Long mateId, Long userId);

	int deleteMateLike(Long mateId, Long userId);

	int countMateLike(Long mateId);
}