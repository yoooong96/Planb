package dao.community;

import java.util.List;

import dto.community.TipDto;

public interface TipDao {

	// 여행꿀팁 작성
	int insertTip(TipDto tipDto);

	// 여행꿀팁 상세조회
	TipDto selectTip(Long tipId);

	// 여행꿀팁 수정
	int updateTip(TipDto tipDto);

	// 여행꿀팁 삭제
	int deleteTip(Long tipId);

	// 여행꿀팁 전체조회
	List<TipDto> selectTipList();

	// 해시태그 검색
	List<TipDto> searchTipByHashtag(String keyword);
	
	List<TipDto> selectTipListByFilter(String country, String keyword, String sort);
}