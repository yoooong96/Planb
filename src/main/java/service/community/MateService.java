package service.community;

import java.util.List;

import dto.community.MateDto;

public interface MateService {

	int insertMate(MateDto mateDto);
	MateDto selectMate(Long mateId);
	int updateMate(MateDto mateDto);
	int deleteMate(Long mateId);

	List<MateDto> selectMateList();
	List<MateDto> selectMateListByFilter(List<String> countryKeywords, String keyword, String sort, int pageSize, int offset);
	int countMateListByFilter(List<String> countryKeywords, String keyword);
}