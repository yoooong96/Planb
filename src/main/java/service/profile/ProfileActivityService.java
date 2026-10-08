package service.profile;

import java.util.List;

import dto.profile.ProfileActivityDto;

public interface ProfileActivityService {
	List<ProfileActivityDto> getProfileActivities(long userId) throws Exception;
}
