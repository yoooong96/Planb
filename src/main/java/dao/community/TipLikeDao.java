package dao.community;

import dto.community.TipLikeDto;

public interface TipLikeDao {

	int insertTipLike(TipLikeDto tipLikeDto);

	TipLikeDto selectTipLike(TipLikeDto tipLikeDto);

	int deleteTipLike(TipLikeDto tipLikeDto);
	
	int selectTipLikeCount(long tipId);
}