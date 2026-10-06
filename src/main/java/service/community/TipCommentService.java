package service.community;

import java.util.List;

import dto.community.TipCommentDto;

public interface TipCommentService {

    // 댓글 작성
    int insertTipComment(TipCommentDto tipCommentDto);

    // 댓글 1개 조회
    TipCommentDto selectTipComment(Long commentId);

    // 게시글 댓글 목록 조회
    List<TipCommentDto> selectTipCommentList(long tipId);

    // 본인 댓글 수정
    int updateTipComment(TipCommentDto tipCommentDto);

    // 본인 댓글 삭제
    int deleteTipComment(TipCommentDto tipCommentDto);
}