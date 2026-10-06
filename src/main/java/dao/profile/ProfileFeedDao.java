package dao.profile;

import java.util.List;

import dto.profile.ProfileFeedDto;

public interface ProfileFeedDao {
	List<ProfileFeedDto> selectMyItineraries(long userId) throws Exception;
	List<ProfileFeedDto> selectBookmarkedItineraries(long userId) throws Exception;
	List<ProfileFeedDto> selectLikedItineraries(long userId) throws Exception;
}
