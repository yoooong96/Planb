package dao.community;

import dto.community.TipMediaDto;

public interface TipMediaDao {

	int insertTipMedia(TipMediaDto tipMediaDto);

	TipMediaDto selectTipMedia(Long mediaId);

	int updateTipMedia(TipMediaDto tipMediaDto);

	int deleteTipMedia(Long mediaId);
}