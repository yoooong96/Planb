package dao.notification;

import dto.notification.NotificationDto;

public interface NotificationDao {
	void insertNotification(NotificationDto notificationDto) throws Exception;
	void selectNotification(NotificationDto notificationDto) throws Exception;
	void updateNotification(NotificationDto notificationDto) throws Exception;
	void deleteNotification(NotificationDto notificationDto) throws Exception;
}
