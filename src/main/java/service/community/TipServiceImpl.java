package service.community;

import java.util.List;

import dao.community.TipDao;
import dao.community.TipDaoImpl;
import dto.community.TipDto;

public class TipServiceImpl implements TipService {

	private TipDao tipDao;

	public TipServiceImpl() {
		tipDao = new TipDaoImpl();
	}

	@Override
	public List<TipDto> getTipList() {
		return tipDao.selectTipList();
	}

	@Override
	public List<TipDto> searchTipByHashtag(String keyword) {
		return tipDao.searchTipByHashtag(keyword);
	}
}