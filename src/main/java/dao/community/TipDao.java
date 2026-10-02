package dao.community;

import dto.community.TipDto;

public interface TipDao {

	int insertTip(TipDto tipDto);

	TipDto selectTip(Long tipId);

	int updateTip(TipDto tipDto);

	int deleteTip(Long tipId);
}