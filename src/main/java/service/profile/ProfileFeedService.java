package service.profile;

import java.util.List;

import dto.profile.ProfileFeedDto;

public interface ProfileFeedService {
	List<ProfileFeedDto> getMyItineraries(long userId) throws Exception;
	List<ProfileFeedDto> getBookmarkedItineraries(long userId) throws Exception;
	List<ProfileFeedDto> getLikedItineraries(long userId) throws Exception;
	List<ProfileFeedDto> getPublicItineraries(long userId) throws Exception;
	List<ProfileFeedDto> getPublicLikedItineraries(long userId)throws Exception;
	List<ProfileFeedDto> getPublicBookmarkedItineraries(long userId) throws Exception;
	int getReceivedLikeCount(long userId) throws Exception;
	int getReceivedBookmarkCount(long userId) throws Exception;
	void deleteItinerary(long itineraryId, long userId) throws Exception;
}
