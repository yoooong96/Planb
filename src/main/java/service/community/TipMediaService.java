package service.community;

import java.util.List;

import dto.community.TipMediaDto;

public interface TipMediaService {

    // 여행꿀팁 이미지 등록
    int insertTipMedia(TipMediaDto tipMediaDto);
    
    List<TipMediaDto> selectTipMediaList(long tipId);
}