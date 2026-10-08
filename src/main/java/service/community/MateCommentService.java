package service.community;

import java.util.List;

import dto.community.MateCommentDto;

public interface MateCommentService {

	int insertMateComment(MateCommentDto mateCommentDto);

	MateCommentDto selectMateComment(Long commentId);

	List<MateCommentDto> selectMateCommentList(Long mateId);

	int countMateComment(Long mateId);

	int updateMateComment(MateCommentDto mateCommentDto);

	int deleteMateComment(MateCommentDto mateCommentDto);
}