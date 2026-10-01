package service.itinerary;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.itinerary.ItineraryDao;
import dao.itinerary.ItineraryDaoImpl;
import dto.itinerary.ItineraryDto;

public class ItineraryServiceImpl implements ItineraryService {
	private ItineraryDao itineraryDao;
	
	public ItineraryServiceImpl() {
		itineraryDao = new ItineraryDaoImpl();
	}

	@Override
	public List<ItineraryDto> getScheduleList(Long loginUserId) throws Exception {
		 Map<String, Object> params = new HashMap<>();
	     params.put("loginUserId", loginUserId);
	     params.put("limit", 12);
	     params.put("offset", 0);
	     return itineraryDao.selectScheduleList(params);
	}

}
