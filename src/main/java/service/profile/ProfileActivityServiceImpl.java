package service.profile;

import java.util.List;

import dao.profile.ProfileActivityDao;
import dao.profile.ProfileActivityDaoImpl;
import dto.profile.ProfileActivityDto;

public class ProfileActivityServiceImpl implements ProfileActivityService {
	private ProfileActivityDao activityDao;

	public ProfileActivityServiceImpl() {

		activityDao = new ProfileActivityDaoImpl();
	}

	@Override
	public List<ProfileActivityDto> getProfileActivities(long userId) throws Exception {
		return activityDao.selectProfileActivities(userId);
	}

}
