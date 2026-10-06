package service.community;

import dao.community.TipLikeDao;
import dao.community.TipLikeDaoImpl;
import dto.community.TipLikeDto;

public class TipLikeServiceImpl implements TipLikeService {

    private TipLikeDao tipLikeDao = new TipLikeDaoImpl();

    // 좋아요 등록
    @Override
    public int insertTipLike(TipLikeDto tipLikeDto) {
        return tipLikeDao.insertTipLike(tipLikeDto);
    }

    // 좋아요 여부 조회
    @Override
    public TipLikeDto selectTipLike(TipLikeDto tipLikeDto) {
        return tipLikeDao.selectTipLike(tipLikeDto);
    }

    // 좋아요 취소
    @Override
    public int deleteTipLike(TipLikeDto tipLikeDto) {
        return tipLikeDao.deleteTipLike(tipLikeDto);
    }
    
    @Override
    public int selectTipLikeCount(long tipId) {
        return tipLikeDao.selectTipLikeCount(tipId);
    }
}