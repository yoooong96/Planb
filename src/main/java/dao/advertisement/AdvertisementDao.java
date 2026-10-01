package dao.advertisement;

import dto.advertisement.AdvertisementDto;

public interface AdvertisementDao {

	int insertAdvertisement(AdvertisementDto advertisementDto);

	AdvertisementDto selectAdvertisement(long adId);

	int updateAdvertisement(AdvertisementDto advertisementDto);

	int deleteAdvertisement(long adId);
}