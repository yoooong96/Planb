package dao.community;

import java.util.List;

import dto.community.MateMediaDto;

public interface MateMediaDao {

	int insertMateMedia(MateMediaDto mateMediaDto);

	MateMediaDto selectMateMedia(Long mediaId);

	int updateMateMedia(MateMediaDto mateMediaDto);

	int deleteMateMedia(Long mediaId);
	
	List<MateMediaDto> selectMateMediaList(Long mateId);
}