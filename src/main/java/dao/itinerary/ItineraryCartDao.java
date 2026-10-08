package dao.itinerary;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.itinerary.ItineraryBlockCartDto;
import dto.itinerary.ItineraryBlockDto;
import dto.itinerary.ItineraryCartDto;
import dto.itinerary.ItineraryDayCartDto;
import dto.itinerary.ItineraryDayDto;
import dto.itinerary.ItineraryDto;

public interface ItineraryCartDao {

	/*
	 * 카트 스냅샷 조회.
	 * 원본 TB_ITINERARY / DAY / BLOCK을 다시 읽지 않고
	 * 카트에 담을 당시 복제된 값만 읽는다.
	 */
	List<ItineraryCartDto> selectCartSnapshots(SqlSession sqlSession, Long userId) throws Exception;

	List<ItineraryDayCartDto> selectDaySnapshots(SqlSession sqlSession, Long cartId) throws Exception;

	List<ItineraryBlockCartDto> selectBlockSnapshots(SqlSession sqlSession, Long dayCartId) throws Exception;

	/*
	 * TB_ITINERARY_CART의 원본 참조 목록 조회. 별도 Cart DTO를 만들지 않고 Map으로 내부 처리한다.
	 */
	List<Map<String, Object>> selectCartItems(SqlSession sqlSession, Long userId) throws Exception;

	/*
	 * 원본 일정의 기본정보만 조회.
	 */
	ItineraryDto selectSourceItinerary(SqlSession sqlSession, Long itineraryId) throws Exception;

	/*
	 * DAY 하나의 기본정보 조회.
	 */
	ItineraryDayDto selectSourceDay(SqlSession sqlSession, Long dayId) throws Exception;

	/*
	 * BLOCK 하나의 기본정보 조회.
	 */
	ItineraryBlockDto selectSourceBlock(SqlSession sqlSession, Long blockId) throws Exception;

	/*
	 * source DAY/BLOCK이 어느 일정에 속하는지 찾을 때 사용.
	 */
	Long selectItineraryIdByDayId(SqlSession sqlSession, Long dayId) throws Exception;

	Long selectItineraryIdByBlockId(SqlSession sqlSession, Long blockId) throws Exception;

	/*
	 * 카트 담기
	 */
	int insertItinerary(SqlSession sqlSession, Long userId, Long itineraryId) throws Exception;

	int insertDay(SqlSession sqlSession, Long userId, Long dayId) throws Exception;

	int insertBlock(SqlSession sqlSession, Long userId, Long blockId) throws Exception;

	/*
	 * 카트에서 삭제
	 */
	int deleteItinerary(SqlSession sqlSession, Long userId, Long itineraryId) throws Exception;

	int deleteDay(SqlSession sqlSession, Long userId, Long dayId) throws Exception;

	int deleteBlock(SqlSession sqlSession, Long userId, Long blockId) throws Exception;
	
	// 변경된 카트담기.
	////////////////////////////////////////////////////////////////////////
	Long selectCartId(SqlSession sqlSession, Long userId, Long itineraryId) throws Exception;

	int insertCartSnapshot(SqlSession sqlSession, Long userId, Long itineraryId) throws Exception;

	Long selectDayCartId(SqlSession sqlSession, Long cartId, Long dayId) throws Exception;

	int insertDaySnapshot(SqlSession sqlSession, Long userId, Long cartId, Long dayId) throws Exception;

	Long selectBlockCartId(SqlSession sqlSession, Long dayCartId, Long blockId) throws Exception;

	int insertBlockSnapshot(SqlSession sqlSession, Long userId, Long dayCartId, Long blockId) throws Exception;
}
