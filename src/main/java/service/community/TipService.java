package service.community;

import java.util.List;

import dto.community.TipDto;

public interface TipService {
	
	int insertTip(TipDto tipDto);

	// 여행꿀팁 전체 조회
	List<TipDto> getTipList();

	// 해시태그 검색
	List<TipDto> searchTipByHashtag(String keyword);
	
	List<TipDto> selectTipListByFilter(String country, String keyword, String sort, int page, int pageSize);
	
	// 여행꿀팁 게시글 1건 조회
	TipDto selectTipDetail(long tipId);
	
	int countTipListByFilter(String country, String keyword);
	
	List<TipDto> selectMyTipList(long userId);
	
	// 내가 작성한 글 페이지 조회
	List<TipDto> selectMyTipList(long userId, int offset, int pageSize);
	
	int countMyTipList(long userId);
	
	// 여행꿀팁 수정
	int updateTip(TipDto tip);
	
	int deleteTip(long tipId, long userId);
	
	int updateTipThumbnail(TipDto tipDto);
	
	int updateTipViewCount(Long tipId);
}