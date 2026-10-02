package service.community;

import java.util.List;

import dto.community.TipDto;

public interface TipService {

	// 여행꿀팁 전체 조회
	List<TipDto> getTipList();

	// 해시태그 검색
	List<TipDto> searchTipByHashtag(String keyword);
}