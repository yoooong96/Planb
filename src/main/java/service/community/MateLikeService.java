package service.community;

public interface MateLikeService {

	boolean toggleMateLike(Long mateId, Long userId);

	boolean isLiked(Long mateId, Long userId);

	int countMateLike(Long mateId);
}