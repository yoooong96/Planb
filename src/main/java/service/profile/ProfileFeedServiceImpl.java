package service.profile;

import java.util.List;

import dao.profile.ProfileFeedDao;
import dao.profile.ProfileFeedDaoImpl;
import dto.profile.ProfileFeedDto;

public class ProfileFeedServiceImpl
        implements ProfileFeedService {

    ProfileFeedDao profileFeedDao;


    public ProfileFeedServiceImpl() {

        profileFeedDao =
                new ProfileFeedDaoImpl();
    }


    @Override
    public List<ProfileFeedDto> getMyItineraries(
            long userId) throws Exception {

        return profileFeedDao
                .selectMyItineraries(userId);
    }


    @Override
    public List<ProfileFeedDto> getBookmarkedItineraries(
            long userId) throws Exception {

        return profileFeedDao
                .selectBookmarkedItineraries(userId);
    }


    @Override
    public List<ProfileFeedDto> getLikedItineraries(
            long userId) throws Exception {

        return profileFeedDao
                .selectLikedItineraries(userId);
    }


    @Override
    public List<ProfileFeedDto> getPublicItineraries(
            long userId) throws Exception {

        return profileFeedDao
                .selectPublicItineraries(userId);
    }


    @Override
    public List<ProfileFeedDto> getPublicLikedItineraries(
            long userId) throws Exception {

        return profileFeedDao
                .selectPublicLikedItineraries(userId);
    }


    @Override
    public List<ProfileFeedDto> getPublicBookmarkedItineraries(
            long userId) throws Exception {

        return profileFeedDao
                .selectPublicBookmarkedItineraries(userId);
    }


    /* =========================================
       받은 좋아요
    ========================================= */

    @Override
    public int getReceivedLikeCount(
            long userId) throws Exception {

        return profileFeedDao
                .selectReceivedLikeCount(userId);
    }


    /* =========================================
       받은 북마크
    ========================================= */

    @Override
    public int getReceivedBookmarkCount(
            long userId) throws Exception {

        return profileFeedDao
                .selectReceivedBookmarkCount(userId);
    }


	@Override
	public void deleteItinerary(long itineraryId, long userId) throws Exception {
		profileFeedDao.deleteItinerary(itineraryId, userId);
		
	}

}