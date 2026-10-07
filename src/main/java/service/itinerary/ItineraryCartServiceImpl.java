package service.itinerary;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dao.itinerary.ItineraryBlockDao;
import dao.itinerary.ItineraryBlockDaoImpl;
import dao.itinerary.ItineraryBlockImageDao;
import dao.itinerary.ItineraryBlockImageDaoImpl;
import dao.itinerary.ItineraryBookmarkDao;
import dao.itinerary.ItineraryBookmarkDaoImpl;
import dao.itinerary.ItineraryCartDao;
import dao.itinerary.ItineraryCartDaoImpl;
import dao.itinerary.ItineraryDayDao;
import dao.itinerary.ItineraryDayDaoImpl;
import dto.itinerary.ItineraryBlockDto;
import dto.itinerary.ItineraryBlockImageDto;
import dto.itinerary.ItineraryDayDto;
import dto.itinerary.ItineraryDto;

public class ItineraryCartServiceImpl
        implements ItineraryCartService {

    private ItineraryCartDao cartDao;
    private ItineraryDayDao dayDao;
    private ItineraryBlockDao blockDao;
    private ItineraryBlockImageDao imageDao;

    public ItineraryCartServiceImpl() {
        cartDao = new ItineraryCartDaoImpl();
        dayDao = new ItineraryDayDaoImpl();
        blockDao = new ItineraryBlockDaoImpl();
        imageDao = new ItineraryBlockImageDaoImpl();
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

        SqlSession sqlSession = null;

        try {
            sqlSession = MybatisSqlSessionFactory
                    .getSqlSessionFactory()
                    .openSession();

            List<Map<String, Object>> cartItems =
                    cartDao.selectCartItems(
                            sqlSession,
                            userId
                    );

            /*
             * added_at DESC 순으로 조회하므로
             * 최초 등장 일정의 순서를 유지한다.
             */
            LinkedHashMap<Long, ItineraryDto> itineraryMap =
                    new LinkedHashMap<>();

            /*
             * 어떤 범위가 이미 전체로 담겼는지 기록.
             * ITINERARY가 있으면 하위 DAY/BLOCK을 추가하지 않는다.
             * DAY가 있으면 그 DAY의 개별 BLOCK을 추가하지 않는다.
             */
            Map<Long, Boolean> fullItinerary =
                    new LinkedHashMap<>();

            Map<Long, Boolean> fullDay =
                    new LinkedHashMap<>();

            for (Map<String, Object> row : cartItems) {

                String itemType =
                        String.valueOf(row.get("itemType"));

                if ("ITINERARY".equals(itemType)) {

                    Long itineraryId =
                            toLong(row.get("sourceItineraryId"));

                    if (itineraryId == null) {
                        continue;
                    }

                    ItineraryDto itinerary =
                            getOrCreateItinerary(
                                    sqlSession,
                                    itineraryMap,
                                    itineraryId
                            );

                    if (itinerary == null) {
                        continue;
                    }

                    /*
                     * 이미 하위 일부가 먼저 조립돼 있더라도
                     * 전체 일정이 담겨 있으면 전체로 교체.
                     */
                    List<ItineraryDayDto> days =
                            dayDao.selectItineraryDays(
                                    sqlSession,
                                    itineraryId
                            );

                    for (ItineraryDayDto day : days) {

                        List<ItineraryBlockDto> blocks =
                                blockDao.selectItineraryBlocks(
                                        sqlSession,
                                        day.getDayId()
                                );

                        attachImages(
                                sqlSession,
                                blocks
                        );

                        day.setBlocks(blocks);

                        fullDay.put(
                                day.getDayId(),
                                true
                        );
                    }

                    itinerary.setDays(days);

                    fullItinerary.put(
                            itineraryId,
                            true
                    );

                    continue;
                }


                if ("DAY".equals(itemType)) {

                    Long dayId =
                            toLong(row.get("sourceDayId"));

                    if (dayId == null
                            || Boolean.TRUE.equals(
                                    fullDay.get(dayId))) {
                        continue;
                    }

                    Long itineraryId =
                            cartDao.selectItineraryIdByDayId(
                                    sqlSession,
                                    dayId
                            );

                    if (itineraryId == null
                            || Boolean.TRUE.equals(
                                    fullItinerary.get(
                                            itineraryId))) {
                        continue;
                    }

                    ItineraryDto itinerary =
                            getOrCreateItinerary(
                                    sqlSession,
                                    itineraryMap,
                                    itineraryId
                            );

                    if (itinerary == null) {
                        continue;
                    }

                    ItineraryDayDto day =
                            cartDao.selectSourceDay(
                                    sqlSession,
                                    dayId
                            );

                    if (day == null) {
                        continue;
                    }

                    List<ItineraryBlockDto> blocks =
                            blockDao.selectItineraryBlocks(
                                    sqlSession,
                                    dayId
                            );

                    attachImages(
                            sqlSession,
                            blocks
                    );

                    day.setBlocks(blocks);

                    replaceOrAddDay(
                            itinerary,
                            day
                    );

                    fullDay.put(
                            dayId,
                            true
                    );

                    continue;
                }


                if ("BLOCK".equals(itemType)) {

                    Long blockId =
                            toLong(row.get("sourceBlockId"));

                    if (blockId == null) {
                        continue;
                    }

                    ItineraryBlockDto block =
                            cartDao.selectSourceBlock(
                                    sqlSession,
                                    blockId
                            );

                    if (block == null) {
                        continue;
                    }

                    Long dayId =
                            block.getDayId();

                    Long itineraryId =
                            cartDao.selectItineraryIdByBlockId(
                                    sqlSession,
                                    blockId
                            );

                    if (itineraryId == null
                            || Boolean.TRUE.equals(
                                    fullItinerary.get(
                                            itineraryId))
                            || Boolean.TRUE.equals(
                                    fullDay.get(dayId))) {
                        continue;
                    }

                    ItineraryDto itinerary =
                            getOrCreateItinerary(
                                    sqlSession,
                                    itineraryMap,
                                    itineraryId
                            );

                    if (itinerary == null) {
                        continue;
                    }

                    ItineraryDayDto day =
                            findDay(
                                    itinerary,
                                    dayId
                            );

                    if (day == null) {

                        day = cartDao.selectSourceDay(
                                sqlSession,
                                dayId
                        );

                        if (day == null) {
                            continue;
                        }

                        day.setBlocks(
                                new ArrayList<ItineraryBlockDto>()
                        );

                        ensureDays(itinerary)
                                .add(day);
                    }

                    /*
                     * 같은 BLOCK이 중복으로 들어오는 상황을 방지.
                     */
                    if (!containsBlock(
                            day,
                            blockId)) {

                        List<ItineraryBlockImageDto> images =
                                imageDao.selectItineraryBlockImages(
                                        sqlSession,
                                        blockId
                                );

                        block.setImages(images);

                        ensureBlocks(day)
                                .add(block);
                    }
                }
            }


            /*
             * 부분 BLOCK 조회의 경우에도 원본 순서를 유지.
             */
            for (ItineraryDto itinerary
                    : itineraryMap.values()) {

                if (itinerary.getDays() == null) {
                    continue;
                }

                Collections.sort(
                        itinerary.getDays(),
                        Comparator.comparing(
                                ItineraryDayDto::getDayOrder,
                                Comparator.nullsLast(
                                        Integer::compareTo
                                )
                        )
                );

                for (ItineraryDayDto day
                        : itinerary.getDays()) {

                    if (day.getBlocks() == null) {
                        continue;
                    }

                    Collections.sort(
                            day.getBlocks(),
                            Comparator.comparing(
                                    ItineraryBlockDto::getBlockOrder,
                                    Comparator.nullsLast(
                                            Integer::compareTo
                                    )
                            )
                    );
                }
            }


            return new ArrayList<>(
                    itineraryMap.values()
            );

        } finally {

            if (sqlSession != null) {
                sqlSession.close();
            }
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


    private ItineraryDto getOrCreateItinerary(
            SqlSession sqlSession,
            LinkedHashMap<Long, ItineraryDto> map,
            Long itineraryId) throws Exception {

        ItineraryDto itinerary =
                map.get(itineraryId);

        if (itinerary != null) {
            return itinerary;
        }

        itinerary =
                cartDao.selectSourceItinerary(
                        sqlSession,
                        itineraryId
                );

        if (itinerary != null) {
            itinerary.setDays(
                    new ArrayList<ItineraryDayDto>()
            );

            map.put(
                    itineraryId,
                    itinerary
            );
        }

        return itinerary;
    }


    private void replaceOrAddDay(
            ItineraryDto itinerary,
            ItineraryDayDto newDay) {

        List<ItineraryDayDto> days =
                ensureDays(itinerary);

        for (int i = 0; i < days.size(); i++) {

            ItineraryDayDto old =
                    days.get(i);

            if (old.getDayId() != null
                    && old.getDayId()
                            .equals(newDay.getDayId())) {

                days.set(
                        i,
                        newDay
                );

                return;
            }
        }

        days.add(newDay);
    }


    private ItineraryDayDto findDay(
            ItineraryDto itinerary,
            Long dayId) {

        if (itinerary.getDays() == null) {
            return null;
        }

        for (ItineraryDayDto day
                : itinerary.getDays()) {

            if (day.getDayId() != null
                    && day.getDayId().equals(dayId)) {
                return day;
            }
        }

        return null;
    }


    private boolean containsBlock(
            ItineraryDayDto day,
            Long blockId) {

        if (day.getBlocks() == null) {
            return false;
        }

        for (ItineraryBlockDto block
                : day.getBlocks()) {

            if (block.getBlockId() != null
                    && block.getBlockId()
                            .equals(blockId)) {
                return true;
            }
        }

        return false;
    }


    private List<ItineraryDayDto> ensureDays(
            ItineraryDto itinerary) {

        if (itinerary.getDays() == null) {
            itinerary.setDays(
                    new ArrayList<ItineraryDayDto>()
            );
        }

        return itinerary.getDays();
    }


    private List<ItineraryBlockDto> ensureBlocks(
            ItineraryDayDto day) {

        if (day.getBlocks() == null) {
            day.setBlocks(
                    new ArrayList<ItineraryBlockDto>()
            );
        }

        return day.getBlocks();
    }


    private void attachImages(
            SqlSession sqlSession,
            List<ItineraryBlockDto> blocks)
            throws Exception {

        if (blocks == null) {
            return;
        }

        for (ItineraryBlockDto block : blocks) {

            List<ItineraryBlockImageDto> images =
                    imageDao.selectItineraryBlockImages(
                            sqlSession,
                            block.getBlockId()
                    );

            block.setImages(images);
        }
    }


    private Long toLong(Object value) {

        if (value == null) {
            return null;
        }

        if (value instanceof Number) {
            return ((Number) value).longValue();
        }

        return Long.valueOf(
                String.valueOf(value)
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
}
