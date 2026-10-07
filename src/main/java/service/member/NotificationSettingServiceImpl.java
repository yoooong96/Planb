package service.member;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dao.member.NotificationSettingDao;
import dao.member.NotificationSettingDaoImpl;

public class NotificationSettingServiceImpl implements NotificationSettingService {

	private final NotificationSettingDao dao = new NotificationSettingDaoImpl();

	/*
	 * ========================================================= 조회
	 * =========================================================
	 */

	@Override
	public Map<String, Object> getNotificationSetting(long userId) throws Exception {

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {

			Map<String, Object> result = dao.selectNotificationSetting(sqlSession, userId);

			if (result == null) {

				throw new IllegalStateException("알림 설정을 찾을 수 없습니다.");

			}

			return result;

		}

	}

	/*
	 * ========================================================= 좋아요
	 * =========================================================
	 */

	@Override
	public void updateLikeNotification(long userId, boolean enabled) throws Exception {

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false)) {

			try {

				Map<String, Object> params = new HashMap<>();

				params.put("userId", userId);

				params.put("enabled", enabled ? 1 : 0);

				int result = dao.updateLikeNotification(sqlSession, params);

				if (result != 1) {

					throw new IllegalStateException("좋아요 알림 설정 저장 실패");

				}

				sqlSession.commit();

			} catch (Exception e) {

				sqlSession.rollback();

				throw e;

			}

		}

	}

	/*
	 * ========================================================= 댓글
	 * =========================================================
	 */

	@Override
	public void updateCommentNotification(long userId, boolean enabled) throws Exception {

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false)) {

			try {

				Map<String, Object> params = new HashMap<>();

				params.put("userId", userId);

				params.put("enabled", enabled ? 1 : 0);

				int result = dao.updateCommentNotification(sqlSession, params);

				if (result != 1) {

					throw new IllegalStateException("댓글 알림 설정 저장 실패");

				}

				sqlSession.commit();

			} catch (Exception e) {

				sqlSession.rollback();

				throw e;

			}

		}

	}

}