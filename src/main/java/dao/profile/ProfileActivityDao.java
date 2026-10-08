package dao.profile;

import java.util.List;

import dto.profile.ProfileActivityDto;

public interface ProfileActivityDao {
	List<ProfileActivityDto> selectProfileActivities(long userId) throws Exception;
}
