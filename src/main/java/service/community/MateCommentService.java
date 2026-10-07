package service.community;

import java.util.List;

import dto.community.MateCommentDto;

public interface MateCommentService {

	int insertMateComment(MateCommentDto mateCommentDto);

	List<MateCommentDto> selectMateCommentList(Long mateId);

	int countMateComment(Long mateId);
}