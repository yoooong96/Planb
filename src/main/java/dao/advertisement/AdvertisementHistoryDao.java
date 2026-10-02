package dao.advertisement;

import dto.advertisement.AdvertisementHistoryDto;

public interface AdvertisementHistoryDao {

	int insertAdvertisementHistory(AdvertisementHistoryDto advertisementHistoryDto);

	AdvertisementHistoryDto selectAdvertisementHistory(long historyId);

	int deleteAdvertisementHistory(long historyId);
}