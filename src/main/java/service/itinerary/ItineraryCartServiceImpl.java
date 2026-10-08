package service.itinerary;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dao.itinerary.ItineraryBlockDao;
import dao.itinerary.ItineraryBlockDaoImpl;
import dao.itinerary.ItineraryBookmarkDao;
import dao.itinerary.ItineraryBookmarkDaoImpl;
import dao.itinerary.ItineraryCartDao;
import dao.itinerary.ItineraryCartDaoImpl;
import dao.itinerary.ItineraryDayDao;
import dao.itinerary.ItineraryDayDaoImpl;
import dto.itinerary.ItineraryBlockCartDto;
import dto.itinerary.ItineraryBlockDto;
import dto.itinerary.ItineraryBlockImageDto;
import dto.itinerary.ItineraryCartDto;
import dto.itinerary.ItineraryDayCartDto;
import dto.itinerary.ItineraryDayDto;
import dto.itinerary.ItineraryDto;

public class ItineraryCartServiceImpl
        implements ItineraryCartService {

    private ItineraryCartDao cartDao;
    private ItineraryDayDao dayDao;
    private ItineraryBlockDao blockDao;

    public ItineraryCartServiceImpl() {
        cartDao = new ItineraryCartDaoImpl();
        dayDao = new ItineraryDayDaoImpl();
        blockDao = new ItineraryBlockDaoImpl();
    }


    /*
     * 핵심 규칙
     *
     * 1) ITINERARY가 담겨 있으면 전체 일정
     * 2) DAY가 담겨 있으면 해당 DAY 전체
     * 3) BLOCK만 담겨 있으면 담은 BLOCK만
     *
     * 같은 일정/같은 DAY의 BLOCK 여러 개는 하나로 합친다.
     *
     * 예:
     * 일정 A / Day2의 Block1, Block2만 카트에 있으면
     *
     * 일정 A
     *  └ Day2
     *      ├ Block1
     *      └ Block2
     *
     * 원본 Day2의 Block3, Block4는 포함하지 않는다.
     */
    @Override
    public List<ItineraryDto> getCartItineraries(
            Long userId) throws Exception {

        if (userId == null) {
            return Collections.emptyList();
        }

        /*
         * 카트는 이제 원본 ID만 보관하는 참조형 구조가 아니라
         * TB_ITINERARY_CART -> TB_ITINERARY_DAY_CART ->
         * TB_ITINERARY_BLOCK_CART에 담은 시점의 값을 복제해 두는
         * 스냅샷 구조다.
         *
         * 따라서 여기서는 TB_ITINERARY / DAY / BLOCK 원본 테이블을
         * 다시 조회하지 않는다. 원본 일정이 나중에 수정돼도
         * 카트에 들어 있는 내용은 변경되지 않는다.
         */
        try (SqlSession sqlSession = MybatisSqlSessionFactory
                .getSqlSessionFactory()
                .openSession()) {

            List<ItineraryCartDto> cartSnapshots =
                    cartDao.selectCartSnapshots(
                            sqlSession,
                            userId
                    );

            if (cartSnapshots == null || cartSnapshots.isEmpty()) {
                return Collections.emptyList();
            }

            List<ItineraryDto> result = new ArrayList<>();

            for (ItineraryCartDto cart : cartSnapshots) {

                if (cart == null || cart.getCartId() == null) {
                    continue;
                }

                ItineraryDto itinerary = new ItineraryDto();

                // 화면 내부 식별자는 카트 PK, 원본 추적은 source 필드로 분리한다.
                itinerary.setItineraryId(cart.getCartId());
                itinerary.setSourceItineraryId(cart.getSourceItineraryId());
                itinerary.setTitle(cart.getTitle());
                itinerary.setCountry(cart.getCountry());
                itinerary.setNickname(cart.getAuthorNickname());

                List<ItineraryDayCartDto> daySnapshots =
                        cartDao.selectDaySnapshots(
                                sqlSession,
                                cart.getCartId()
                        );

                List<ItineraryDayDto> days = new ArrayList<>();

                if (daySnapshots != null) {
                    for (ItineraryDayCartDto dayCart : daySnapshots) {

                        if (dayCart == null || dayCart.getDayCartId() == null) {
                            continue;
                        }

                        ItineraryDayDto day = new ItineraryDayDto();

                        day.setDayId(dayCart.getDayCartId());
                        day.setItineraryId(cart.getCartId());
                        day.setSourceDayId(dayCart.getSourceDayId());
                        day.setDayOrder(dayCart.getDayOrder());
                        day.setDayDate(dayCart.getDayDate());
                        day.setTitle(dayCart.getTitle());

                        List<ItineraryBlockCartDto> blockSnapshots =
                                cartDao.selectBlockSnapshots(
                                        sqlSession,
                                        dayCart.getDayCartId()
                                );

                        List<ItineraryBlockDto> blocks = new ArrayList<>();

                        if (blockSnapshots != null) {
                            for (ItineraryBlockCartDto blockCart : blockSnapshots) {

                                if (blockCart == null
                                        || blockCart.getBlockCartId() == null) {
                                    continue;
                                }

                                ItineraryBlockDto block = new ItineraryBlockDto();

                                block.setBlockId(blockCart.getBlockCartId());
                                block.setDayId(dayCart.getDayCartId());
                                block.setSourceBlockId(blockCart.getSourceBlockId());
                                block.setGooglePlaceId(blockCart.getGooglePlaceId());
                                block.setPlaceName(blockCart.getPlaceName());
                                block.setPlaceAddress(blockCart.getPlaceAddress());
                                block.setPlaceLat(
                                        blockCart.getPlaceLat() == null
                                                ? null
                                                : blockCart.getPlaceLat().doubleValue()
                                );
                                block.setPlaceLng(
                                        blockCart.getPlaceLng() == null
                                                ? null
                                                : blockCart.getPlaceLng().doubleValue()
                                );
                                block.setBlockType(blockCart.getBlockType());
                                block.setBlockOrder(blockCart.getBlockOrder());
                                block.setTitle(blockCart.getTitle());
                                block.setMemo(blockCart.getMemo());
                                block.setCost(blockCart.getCost());
                                block.setCostType(blockCart.getCostType());
                                block.setStartTime(blockCart.getStartTime());
                                block.setEndTime(blockCart.getEndTime());

                                /*
                                 * 현재 카트 스냅샷 테이블에는 이미지 복제 테이블이 없다.
                                 * 원본 이미지를 다시 읽으면 다시 원본 수정에 종속되므로
                                 * 여기서는 의도적으로 원본 이미지 조회를 하지 않는다.
                                 */
                                block.setImages(Collections.<ItineraryBlockImageDto>emptyList());

                                blocks.add(block);
                            }
                        }

                        day.setBlocks(blocks);
                        days.add(day);
                    }
                }

                itinerary.setDays(days);
                result.add(itinerary);
            }

            return result;
        }
    }


    @Override
    public void addItinerary(
            Long userId,
            Long itineraryId) throws Exception {

        executeWrite(
                new CartWriteAction() {
                    @Override
                    public int run(
                            SqlSession sqlSession)
                            throws Exception {

                        return cartDao.insertItinerary(
                                sqlSession,
                                userId,
                                itineraryId
                        );
                    }
                }
        );
    }


    @Override
    public void addDay(
            Long userId,
            Long dayId) throws Exception {

        executeWrite(
                new CartWriteAction() {
                    @Override
                    public int run(
                            SqlSession sqlSession)
                            throws Exception {

                        return cartDao.insertDay(
                                sqlSession,
                                userId,
                                dayId
                        );
                    }
                }
        );
    }


    @Override
    public void addBlock(
            Long userId,
            Long blockId) throws Exception {

        executeWrite(
                new CartWriteAction() {
                    @Override
                    public int run(
                            SqlSession sqlSession)
                            throws Exception {

                        return cartDao.insertBlock(
                                sqlSession,
                                userId,
                                blockId
                        );
                    }
                }
        );
    }


    @Override
    public void removeItinerary(
            Long userId,
            Long itineraryId) throws Exception {

        executeWrite(
                new CartWriteAction() {
                    @Override
                    public int run(
                            SqlSession sqlSession)
                            throws Exception {

                        return cartDao.deleteItinerary(
                                sqlSession,
                                userId,
                                itineraryId
                        );
                    }
                }
        );
    }


    @Override
    public void removeDay(
            Long userId,
            Long dayId) throws Exception {

        executeWrite(
                new CartWriteAction() {
                    @Override
                    public int run(
                            SqlSession sqlSession)
                            throws Exception {

                        return cartDao.deleteDay(
                                sqlSession,
                                userId,
                                dayId
                        );
                    }
                }
        );
    }


    @Override
    public void removeBlock(
            Long userId,
            Long blockId) throws Exception {

        executeWrite(
                new CartWriteAction() {
                    @Override
                    public int run(
                            SqlSession sqlSession)
                            throws Exception {

                        return cartDao.deleteBlock(
                                sqlSession,
                                userId,
                                blockId
                        );
                    }
                }
        );
    }


    private void executeWrite(
            CartWriteAction action)
            throws Exception {

        SqlSession sqlSession = null;

        try {
            sqlSession = MybatisSqlSessionFactory
                    .getSqlSessionFactory()
                    .openSession(false);

            action.run(sqlSession);

            sqlSession.commit();

        } catch (Exception e) {

            if (sqlSession != null) {
                sqlSession.rollback();
            }

            throw e;

        } finally {

            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }


    private interface CartWriteAction {

        int run(SqlSession sqlSession)
                throws Exception;
    }
    
    //private final ItineraryCartDao cartDao = new ItineraryCartDaoImpl();

    private final ItineraryBookmarkDao bookmarkDao = new ItineraryBookmarkDaoImpl();

    //private final ItineraryDayDao dayDao = new ItineraryDayDaoImpl();

    //private final ItineraryBlockDao blockDao = new ItineraryBlockDaoImpl();

    @Override
    public Map<String, Object> addToCart(
            Long loginUserId,
            Long itineraryId,
            String itemType,
            Long targetId) throws Exception {

        if (loginUserId == null || loginUserId <= 0) {
            throw new SecurityException(
                "로그인 후 이용할 수 있습니다."
            );
        }

        if (itineraryId == null || itineraryId <= 0
                || targetId == null || targetId <= 0) {

            throw new IllegalArgumentException(
                "올바른 담기 대상이 아닙니다."
            );
        }

        if (!"ITINERARY".equals(itemType)
                && !"DAY".equals(itemType)
                && !"BLOCK".equals(itemType)) {

            throw new IllegalArgumentException(
                "올바른 담기 유형이 아닙니다."
            );
        }

        if ("ITINERARY".equals(itemType)
                && !itineraryId.equals(targetId)) {

            throw new IllegalArgumentException(
                "일정 번호가 일치하지 않습니다."
            );
        }

        try (SqlSession sqlSession =
                MybatisSqlSessionFactory
                    .getSqlSessionFactory()
                    .openSession(false)) {

            try {
                // 같은 일정의 담기 요청을 순서대로 처리
                ItineraryDto itinerary =
                    bookmarkDao.selectBookmarkTargetForUpdate(
                        sqlSession,
                        itineraryId
                    );

                if (itinerary == null
                        || !"ACTIVE".equals(itinerary.getStatus())) {

                    throw new IllegalArgumentException(
                        "일정을 찾을 수 없습니다."
                    );
                }

                boolean owner =
                    loginUserId.equals(itinerary.getUserId());

                if (!owner
                        && !"PUBLIC".equals(itinerary.getVisibility())) {

                    throw new SecurityException(
                        "공개된 일정만 담을 수 있습니다."
                    );
                }

                // 선택한 범위만 구성하고 실제 소속 확인
                List<ItineraryDayDto> selectedDays =
                    selectTargetDays(
                        sqlSession,
                        itineraryId,
                        itemType,
                        targetId
                    );

                Long cartId = cartDao.selectCartId(
                    sqlSession,
                    loginUserId,
                    itineraryId
                );

                boolean addedItinerary = cartId == null;

                if (addedItinerary) {
                    cartDao.insertCartSnapshot(
                        sqlSession,
                        loginUserId,
                        itineraryId
                    );

                    cartId = cartDao.selectCartId(
                        sqlSession,
                        loginUserId,
                        itineraryId
                    );

                    if (cartId == null) {
                        throw new IllegalStateException(
                            "카트 일정 저장에 실패했습니다."
                        );
                    }
                }

                int addedDays = 0;
                int addedBlocks = 0;

                for (ItineraryDayDto day : selectedDays) {

                    Long dayCartId = cartDao.selectDayCartId(
                        sqlSession,
                        cartId,
                        day.getDayId()
                    );

                    if (dayCartId == null) {
                        cartDao.insertDaySnapshot(
                            sqlSession,
                            loginUserId,
                            cartId,
                            day.getDayId()
                        );

                        dayCartId = cartDao.selectDayCartId(
                            sqlSession,
                            cartId,
                            day.getDayId()
                        );

                        if (dayCartId == null) {
                            throw new IllegalStateException(
                                "카트 DAY 저장에 실패했습니다."
                            );
                        }

                        addedDays++;
                    }

                    for (ItineraryBlockDto block : day.getBlocks()) {

                        Long blockCartId =
                            cartDao.selectBlockCartId(
                                sqlSession,
                                dayCartId,
                                block.getBlockId()
                            );

                        if (blockCartId != null) {
                            // 기존 복사본은 변경하지 않음
                            continue;
                        }

                        cartDao.insertBlockSnapshot(
                            sqlSession,
                            loginUserId,
                            dayCartId,
                            block.getBlockId()
                        );

                        blockCartId = cartDao.selectBlockCartId(
                            sqlSession,
                            dayCartId,
                            block.getBlockId()
                        );

                        if (blockCartId == null) {
                            throw new IllegalStateException(
                                "카트 블록 저장에 실패했습니다."
                            );
                        }

                        addedBlocks++;
                    }
                }

                boolean changed =
                    addedItinerary || addedDays > 0 || addedBlocks > 0;

                Map<String, Object> result = new HashMap<>();

                result.put("cartId", cartId);
                result.put("changed", changed);
                result.put("addedDays", addedDays);
                result.put("addedBlocks", addedBlocks);

                result.put(
                    "message",
                    changed
                        ? "장바구니에 담았어요."
                        : "이미 장바구니에 담긴 내용입니다."
                );

                sqlSession.commit();

                return result;

            } catch (Exception e) {
                sqlSession.rollback();
                throw e;
            }
        }
    }

    private List<ItineraryDayDto> selectTargetDays(
            SqlSession sqlSession,
            Long itineraryId,
            String itemType,
            Long targetId) throws Exception {

        List<ItineraryDayDto> days =
            dayDao.selectItineraryDays(
                sqlSession,
                itineraryId
            );

        List<ItineraryDayDto> selectedDays =
            new ArrayList<>();

        for (ItineraryDayDto day : days) {

            if ("DAY".equals(itemType)
                    && !targetId.equals(day.getDayId())) {
                continue;
            }

            List<ItineraryBlockDto> blocks =
                blockDao.selectItineraryBlocks(
                    sqlSession,
                    day.getDayId()
                );

            if ("BLOCK".equals(itemType)) {

                List<ItineraryBlockDto> selectedBlocks =
                    new ArrayList<>();

                for (ItineraryBlockDto block : blocks) {
                    if (targetId.equals(block.getBlockId())) {
                        selectedBlocks.add(block);
                        break;
                    }
                }

                if (selectedBlocks.isEmpty()) {
                    continue;
                }

                day.setBlocks(selectedBlocks);
                selectedDays.add(day);

                break;

            } else {
                day.setBlocks(blocks);
                selectedDays.add(day);
            }
        }

        if (!"ITINERARY".equals(itemType)
                && selectedDays.isEmpty()) {

            throw new IllegalArgumentException(
                "해당 일정에 속한 담기 대상을 찾을 수 없습니다."
            );
        }

        return selectedDays;
    }


	@Override
	public int getCartCount(Long loginUserId) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
}
