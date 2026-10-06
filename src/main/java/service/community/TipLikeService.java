package service.community;

import dto.community.TipLikeDto;

public interface TipLikeService {

    // 좋아요 등록
    int insertTipLike(TipLikeDto tipLikeDto);

    // 좋아요 여부 조회
    TipLikeDto selectTipLike(TipLikeDto tipLikeDto);

    // 좋아요 취소
    int deleteTipLike(TipLikeDto tipLikeDto);
    
    int selectTipLikeCount(long tipId);
}