package service.member;

import java.util.Map;

public interface NotificationSettingService {
	Map<String, Object> getNotificationSetting(long userId) throws Exception;
	void updateLikeNotification(long userId, boolean enabled) throws Exception;
	void updateCommentNotification(long userId, boolean enabled) throws Exception;
}
