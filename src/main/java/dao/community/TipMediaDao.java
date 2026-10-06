package dao.community;

import java.util.List;

import dto.community.TipMediaDto;

public interface TipMediaDao {

	int insertTipMedia(TipMediaDto tipMediaDto);

	TipMediaDto selectTipMedia(Long mediaId);

	int updateTipMedia(TipMediaDto tipMediaDto);

	int deleteTipMedia(Long mediaId);
	
	List<TipMediaDto> selectTipMediaList(long tipId);
}