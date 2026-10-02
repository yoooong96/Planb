package dao.community;

import dto.community.MateCommentDto;

public interface MateCommentDao {

	int insertMateComment(MateCommentDto mateCommentDto);

	MateCommentDto selectMateComment(Long commentId);

	int updateMateComment(MateCommentDto mateCommentDto);

	int deleteMateComment(Long commentId);
}