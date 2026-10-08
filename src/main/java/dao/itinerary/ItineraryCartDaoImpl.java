package dao.itinerary;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.itinerary.ItineraryBlockCartDto;
import dto.itinerary.ItineraryBlockDto;
import dto.itinerary.ItineraryCartDto;
import dto.itinerary.ItineraryDayCartDto;
import dto.itinerary.ItineraryDayDto;
import dto.itinerary.ItineraryDto;

public class ItineraryCartDaoImpl implements ItineraryCartDao {

	private static final String NAMESPACE = "mapper.itinerary.itineraryCart.";

	@Override
	public List<ItineraryCartDto> selectCartSnapshots(SqlSession sqlSession, Long userId) throws Exception {
		return sqlSession.selectList(NAMESPACE + "selectCartSnapshots", userId);
	}

	@Override
	public List<ItineraryDayCartDto> selectDaySnapshots(SqlSession sqlSession, Long cartId) throws Exception {
		return sqlSession.selectList(NAMESPACE + "selectDaySnapshots", cartId);
	}

	@Override
	public List<ItineraryBlockCartDto> selectBlockSnapshots(SqlSession sqlSession, Long dayCartId) throws Exception {
		return sqlSession.selectList(NAMESPACE + "selectBlockSnapshots", dayCartId);
	}

	@Override
	public List<Map<String, Object>> selectCartItems(SqlSession sqlSession, Long userId) throws Exception {

		return sqlSession.selectList(NAMESPACE + "selectCartItems", userId);
	}

	@Override
	public ItineraryDto selectSourceItinerary(SqlSession sqlSession, Long itineraryId) throws Exception {

		return sqlSession.selectOne(NAMESPACE + "selectSourceItinerary", itineraryId);
	}

	@Override
	public ItineraryDayDto selectSourceDay(SqlSession sqlSession, Long dayId) throws Exception {

		return sqlSession.selectOne(NAMESPACE + "selectSourceDay", dayId);
	}

	@Override
	public ItineraryBlockDto selectSourceBlock(SqlSession sqlSession, Long blockId) throws Exception {

		return sqlSession.selectOne(NAMESPACE + "selectSourceBlock", blockId);
	}

	@Override
	public Long selectItineraryIdByDayId(SqlSession sqlSession, Long dayId) throws Exception {

		return sqlSession.selectOne(NAMESPACE + "selectItineraryIdByDayId", dayId);
	}

	@Override
	public Long selectItineraryIdByBlockId(SqlSession sqlSession, Long blockId) throws Exception {

		return sqlSession.selectOne(NAMESPACE + "selectItineraryIdByBlockId", blockId);
	}

	@Override
	public int insertItinerary(SqlSession sqlSession, Long userId, Long itineraryId) throws Exception {

		return sqlSession.insert(NAMESPACE + "insertItinerary", param(userId, "itineraryId", itineraryId));
	}

	@Override
	public int insertDay(SqlSession sqlSession, Long userId, Long dayId) throws Exception {

		return sqlSession.insert(NAMESPACE + "insertDay", param(userId, "dayId", dayId));
	}

	@Override
	public int insertBlock(SqlSession sqlSession, Long userId, Long blockId) throws Exception {

		return sqlSession.insert(NAMESPACE + "insertBlock", param(userId, "blockId", blockId));
	}

	@Override
	public int deleteItinerary(SqlSession sqlSession, Long userId, Long itineraryId) throws Exception {

		return sqlSession.delete(NAMESPACE + "deleteItinerary", param(userId, "itineraryId", itineraryId));
	}

	@Override
	public int deleteDay(SqlSession sqlSession, Long userId, Long dayId) throws Exception {

		return sqlSession.delete(NAMESPACE + "deleteDay", param(userId, "dayId", dayId));
	}

	@Override
	public int deleteBlock(SqlSession sqlSession, Long userId, Long blockId) throws Exception {

		return sqlSession.delete(NAMESPACE + "deleteBlock", param(userId, "blockId", blockId));
	}

	private Map<String, Object> param(Long userId, String key, Long value) {

		Map<String, Object> map = new HashMap<>();

		map.put("userId", userId);
		map.put(key, value);

		return map;
	}

	// 변경된 카트 daoimpl
	///////////////////////////////////////////////////////////////////////////////////////////////////////

	@Override
	public Long selectCartId(SqlSession sqlSession, Long userId, Long itineraryId) throws Exception {

		Map<String, Object> params = new HashMap<>();

		params.put("userId", userId);
		params.put("itineraryId", itineraryId);

		return sqlSession.selectOne("mapper.itinerary.itineraryCart.selectCartId", params);
	}

	@Override
	public int insertCartSnapshot(SqlSession sqlSession, Long userId, Long itineraryId) throws Exception {

		Map<String, Object> params = new HashMap<>();

		params.put("userId", userId);
		params.put("itineraryId", itineraryId);

		return sqlSession.insert("mapper.itinerary.itineraryCart.insertCartSnapshot", params);
	}

	@Override
	public Long selectDayCartId(SqlSession sqlSession, Long cartId, Long dayId) throws Exception {

		Map<String, Object> params = new HashMap<>();

		params.put("cartId", cartId);
		params.put("dayId", dayId);

		return sqlSession.selectOne("mapper.itinerary.itineraryCart.selectDayCartId", params);
	}

	@Override
	public int insertDaySnapshot(SqlSession sqlSession, Long userId, Long cartId, Long dayId) throws Exception {

		Map<String, Object> params = new HashMap<>();

		params.put("userId", userId);
		params.put("cartId", cartId);
		params.put("dayId", dayId);

		return sqlSession.insert("mapper.itinerary.itineraryCart.insertDaySnapshot", params);
	}

	@Override
	public Long selectBlockCartId(SqlSession sqlSession, Long dayCartId, Long blockId) throws Exception {

		Map<String, Object> params = new HashMap<>();

		params.put("dayCartId", dayCartId);
		params.put("blockId", blockId);

		return sqlSession.selectOne("mapper.itinerary.itineraryCart.selectBlockCartId", params);
	}

	@Override
	public int insertBlockSnapshot(SqlSession sqlSession, Long userId, Long dayCartId, Long blockId) throws Exception {

		Map<String, Object> params = new HashMap<>();

		params.put("userId", userId);
		params.put("dayCartId", dayCartId);
		params.put("blockId", blockId);

		return sqlSession.insert("mapper.itinerary.itineraryCart.insertBlockSnapshot", params);
	}

	@Override
	public int selectCartCount(SqlSession sqlSession, Long userId) {
		return sqlSession.selectOne("mapper.itinerary.itineraryCart.selectCartCount", userId);
	}
}
