package dao.member;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public interface NotificationSettingDao {
	Map<String, Object> selectNotificationSetting(SqlSession sqlSession, long userId);
	int updateLikeNotification(SqlSession sqlSession, Map<String, Object>params);
	int updateCommentNotification(SqlSession sqlSession, Map<String, Object>params);
	
}
