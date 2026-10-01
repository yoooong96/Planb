package dao.community;

import dto.community.MateDto;

public interface MateDao {

	int insertMate(MateDto mateDto);

	MateDto selectMate(Long mateId);

	int updateMate(MateDto mateDto);

	int deleteMate(Long mateId);
}