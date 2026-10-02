package dao.community;

import dto.community.TipCommentDto;

public interface TipCommentDao {

	int insertTipComment(TipCommentDto tipCommentDto);

	TipCommentDto selectTipComment(Long commentId);

	int updateTipComment(TipCommentDto tipCommentDto);

	int deleteTipComment(Long commentId);
}