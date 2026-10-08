package service.community;

import java.util.List;

import dto.community.MateDto;

public interface MateService {

	int insertMate(MateDto mateDto);
	MateDto selectMate(Long mateId);
	int updateMate(MateDto mateDto);
	int updateMateImage(MateDto mateDto);
	int deleteMate(long mateId, long userId);

	List<MateDto> selectMateList();
	List<MateDto> selectMateListByFilter(List<String> countryKeywords, String keyword, String sort, int pageSize, int offset);
	int countMateListByFilter(List<String> countryKeywords, String keyword);
	
	List<MateDto> selectMateWriteList(Long userId, int pageSize, int offset);
	int countMateWriteList(Long userId);
	
	int updateMateViewCount(Long mateId);
	
	int updateRecruitStatus(long mateId, long userId, String recruitStatus);
	
}