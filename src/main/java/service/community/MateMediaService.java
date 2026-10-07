package service.community;

import java.util.List;

import dto.community.MateMediaDto;

public interface MateMediaService {

	int insertMateMedia(MateMediaDto mateMediaDto);
	
	List<MateMediaDto> selectMateMediaList(Long mateId);
}