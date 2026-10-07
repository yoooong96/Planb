package service.advertisement;

import dto.advertisement.AdvertisementDto;

public interface AdvertisementService {
	long submitAdvertisement(AdvertisementDto advertisement) throws Exception;
}
