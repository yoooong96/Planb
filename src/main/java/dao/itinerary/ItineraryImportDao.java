package dao.itinerary;

import dto.itinerary.ItineraryImportDto;

public interface ItineraryImportDao {
	void insertItineraryImport(ItineraryImportDto itineraryImportDto) throws Exception;
	void selectItineraryImport(ItineraryImportDto itineraryImportDto) throws Exception;
	void updateItineraryImport(ItineraryImportDto itineraryImportDto) throws Exception;
	void deleteItineraryImport(ItineraryImportDto itineraryImportDto) throws Exception;
}
