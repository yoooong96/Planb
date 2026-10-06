package service.community;

import java.util.List;

import dao.community.TipCommentDao;
import dao.community.TipCommentDaoImpl;
import dto.community.TipCommentDto;

public class TipCommentServiceImpl implements TipCommentService {

    private TipCommentDao tipCommentDao = new TipCommentDaoImpl();

    // 댓글 작성
    @Override
    public int insertTipComment(TipCommentDto tipCommentDto) {
        return tipCommentDao.insertTipComment(tipCommentDto);
    }

    // 댓글 1개 조회
    @Override
    public TipCommentDto selectTipComment(Long commentId) {
        return tipCommentDao.selectTipComment(commentId);
    }

    // 게시글 댓글 목록 조회
    @Override
    public List<TipCommentDto> selectTipCommentList(long tipId) {
        return tipCommentDao.selectTipCommentList(tipId);
    }

    // 본인 댓글 수정
    @Override
    public int updateTipComment(TipCommentDto tipCommentDto) {
        return tipCommentDao.updateTipComment(tipCommentDto);
    }

    // 본인 댓글 삭제
    @Override
    public int deleteTipComment(TipCommentDto tipCommentDto) {
        return tipCommentDao.deleteTipComment(tipCommentDto);
    }
}