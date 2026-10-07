package dao.member;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public class NotificationSettingDaoImpl implements NotificationSettingDao {

	/* 조회 */

	public Map<String, Object> selectNotificationSetting(SqlSession sqlSession, long userId) {

		return sqlSession.selectOne("mapper.member.notification.selectNotificationSetting", userId);

	}

	/* 좋아요 */

	public int updateLikeNotification(SqlSession sqlSession, Map<String, Object> params) {

		return sqlSession.update("mapper.member.notification.updateLikeNotification", params);

	}

	/* 댓글 */

	public int updateCommentNotification(SqlSession sqlSession, Map<String, Object> params) {

		return sqlSession.update("mapper.member.notification.updateCommentNotification", params);

	}

}
