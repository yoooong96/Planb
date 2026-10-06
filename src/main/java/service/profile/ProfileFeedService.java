package service.profile;

import java.util.List;

import dto.profile.ProfileFeedDto;

public interface ProfileFeedService {
	List<ProfileFeedDto> getMyItineraries(long userId) throws Exception;
	List<ProfileFeedDto> getBookmarkedItineraries(long userId) throws Exception;
	List<ProfileFeedDto> getLikedItineraries(long userId) throws Exception;
}
