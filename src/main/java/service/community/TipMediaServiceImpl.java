package service.community;

import java.util.List;

import dao.community.TipMediaDao;
import dao.community.TipMediaDaoImpl;
import dto.community.TipMediaDto;

public class TipMediaServiceImpl implements TipMediaService {

    private TipMediaDao tipMediaDao;

    public TipMediaServiceImpl() {
        tipMediaDao = new TipMediaDaoImpl();
    }

    @Override
    public int insertTipMedia(TipMediaDto tipMediaDto) {
        return tipMediaDao.insertTipMedia(tipMediaDto);
    }
    
    @Override
    public List<TipMediaDto> selectTipMediaList(long tipId) {
        return tipMediaDao.selectTipMediaList(tipId);
    }
}