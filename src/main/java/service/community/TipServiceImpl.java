package service.community;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.community.TipDao;
import dao.community.TipDaoImpl;
import dto.community.TipDto;

public class TipServiceImpl implements TipService {

	private TipDao tipDao;
	
	private static final Map<String, List<String>> COUNTRY_KEYWORDS = new HashMap<>();

	static {
		COUNTRY_KEYWORDS.put("대한민국", Arrays.asList("대한민국", "한국", "코리아"));

		COUNTRY_KEYWORDS.put("미국", Arrays.asList("미국", "USA"));

		COUNTRY_KEYWORDS.put("영국", Arrays.asList("영국", "UK"));

		COUNTRY_KEYWORDS.put("아랍에미리트", Arrays.asList("아랍에미리트", "UAE"));
	}

	public TipServiceImpl() {
		tipDao = new TipDaoImpl();
	}
	
	@Override
	public int insertTip(TipDto tipDto) {
		return tipDao.insertTip(tipDto);
	}

	@Override
	public List<TipDto> getTipList() {
		return tipDao.selectTipList();
	}

	@Override
	public List<TipDto> searchTipByHashtag(String keyword) {
		return tipDao.searchTipByHashtag(keyword);
	}
	
	@Override
	public List<TipDto> selectTipListByFilter(String country, String keyword, String sort, int page, int pageSize) {
		List<String> countryKeywords = null;

		if (country != null && !country.trim().isEmpty()) {
			countryKeywords = COUNTRY_KEYWORDS.getOrDefault(
				country,
				Collections.singletonList(country)
			);
		}
		
		// 페이지가 1보다 작게 들어오는 경우 방지
		if (page < 1) {
			page = 1;
		}

		// 한 번에 가져올 개수 방어
		if (pageSize < 1) {
			pageSize = 8;
		}

		int offset = (page - 1) * pageSize;

		return tipDao.selectTipListByFilter(
			countryKeywords,
			keyword,
			sort,
			pageSize,
			offset
		);
	}
	
	@Override
	public TipDto selectTipDetail(long tipId) {
	    return tipDao.selectTipDetail(tipId);
	}
	
	@Override
	public int countTipListByFilter(String country, String keyword) {
		List<String> countryKeywords = null;
		if (country != null && !country.trim().isEmpty()) {
			countryKeywords = COUNTRY_KEYWORDS.getOrDefault(
				country,
				Collections.singletonList(country)
			);
		}
		return tipDao.countTipListByFilter(countryKeywords, keyword);
	}
	
	@Override
	public List<TipDto> selectMyTipList(long userId) {
		return tipDao.selectMyTipList(userId);
	}
	
	@Override
	public List<TipDto> selectMyTipList(long userId, int offset, int pageSize) {
	    return tipDao.selectMyTipList(userId, offset, pageSize);
	}
	
	@Override
	public int countMyTipList(long userId) {
	    return tipDao.countMyTipList(userId);
	}
	
	@Override
	public int updateTip(TipDto tip) {
	    return tipDao.updateTip(tip);
	}
	
	@Override
	public int deleteTip(long tipId, long userId) {
	    TipDto tipDto = new TipDto();
	    tipDto.setTipId(tipId);
	    tipDto.setUserId(userId);
	    return tipDao.deleteTip(tipDto);
	}
	
	@Override
	public int updateTipThumbnail(TipDto tipDto) {
	    return tipDao.updateTipThumbnail(tipDto);
	}
	
}