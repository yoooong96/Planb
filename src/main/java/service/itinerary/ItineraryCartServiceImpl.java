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
import dto.itinerary.ItineraryCartDto;
import dto.itinerary.ItineraryDayCartDto;
import dto.itinerary.ItineraryDayDto;
import dto.itinerary.ItineraryDto;

public class ItineraryCartServiceImpl implements ItineraryCartService {

    private final ItineraryCartDao cartDao;
    private final ItineraryDayDao dayDao;
    private final ItineraryBlockDao blockDao;
    private final ItineraryBookmarkDao bookmarkDao;

    public ItineraryCartServiceImpl() {
        cartDao = new ItineraryCartDaoImpl();
        dayDao = new ItineraryDayDaoImpl();
        blockDao = new ItineraryBlockDaoImpl();
        bookmarkDao = new ItineraryBookmarkDaoImpl();
    }

    /*
     * 카트 조회는 스냅샷 테이블만 사용한다.
     * 원본 TB_ITINERARY / TB_ITINERARY_DAY / TB_ITINERARY_BLOCK을 다시 읽지 않는다.
     */
    @Override
    public List<ItineraryDto> getCartItineraries(Long userId) throws Exception {
        if (userId == null || userId <= 0) {
            return Collections.emptyList();
        }

        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            List<ItineraryCartDto> cartSnapshots = cartDao.selectCartSnapshots(sqlSession, userId);
            List<ItineraryDto> result = new ArrayList<>();

            for (ItineraryCartDto cart : cartSnapshots) {
                ItineraryDto itinerary = toItineraryDto(cart);

                List<ItineraryDayCartDto> daySnapshots = cartDao.selectDaySnapshots(sqlSession, cart.getCartId());
                List<ItineraryDayDto> days = new ArrayList<>();

                for (ItineraryDayCartDto dayCart : daySnapshots) {
                    ItineraryDayDto day = toDayDto(dayCart, cart.getSourceItineraryId());

                    List<ItineraryBlockCartDto> blockSnapshots =
                            cartDao.selectBlockSnapshots(sqlSession, dayCart.getDayCartId());
                    List<ItineraryBlockDto> blocks = new ArrayList<>();

                    for (ItineraryBlockCartDto blockCart : blockSnapshots) {
                        blocks.add(toBlockDto(blockCart, dayCart.getSourceDayId()));
                    }

                    day.setBlocks(blocks);
                    days.add(day);
                }

                itinerary.setDays(days);
                result.add(itinerary);
            }

            return result;
        }
    }

    private ItineraryDto toItineraryDto(ItineraryCartDto cart) {
        ItineraryDto dto = new ItineraryDto();

        // planner 기존 데이터 구조와 호환하기 위해 원본 ID를 id/sourceId 양쪽에 넣는다.
        dto.setItineraryId(cart.getSourceItineraryId());
        dto.setSourceItineraryId(cart.getSourceItineraryId());
        dto.setTitle(cart.getTitle());
        dto.setCountry(cart.getCountry());
        dto.setCity(cart.getCity());
        dto.setTravelerCount(cart.getTravelerCount() == null || cart.getTravelerCount() < 1
                ? 1
                : cart.getTravelerCount());
        dto.setNickname(cart.getAuthorNickname());

        return dto;
    }

    private ItineraryDayDto toDayDto(ItineraryDayCartDto cart, Long sourceItineraryId) {
        ItineraryDayDto dto = new ItineraryDayDto();

        dto.setDayId(cart.getSourceDayId());
        dto.setSourceDayId(cart.getSourceDayId());
        dto.setItineraryId(sourceItineraryId);
        dto.setDayOrder(cart.getDayOrder());
        dto.setDayDate(cart.getDayDate());
        dto.setTitle(cart.getTitle());

        return dto;
    }

    private ItineraryBlockDto toBlockDto(ItineraryBlockCartDto cart, Long sourceDayId) {
        ItineraryBlockDto dto = new ItineraryBlockDto();

        dto.setBlockId(cart.getSourceBlockId());
        dto.setSourceBlockId(cart.getSourceBlockId());
        dto.setDayId(sourceDayId);
        dto.setGooglePlaceId(cart.getGooglePlaceId());
        dto.setPlaceName(cart.getPlaceName());
        dto.setPlaceAddress(cart.getPlaceAddress());
        dto.setPlaceLat(cart.getPlaceLat() == null ? null : cart.getPlaceLat().doubleValue());
        dto.setPlaceLng(cart.getPlaceLng() == null ? null : cart.getPlaceLng().doubleValue());
        dto.setBlockType(cart.getBlockType());
        dto.setBlockOrder(cart.getBlockOrder());
        dto.setTitle(cart.getTitle());
        dto.setMemo(cart.getMemo());
        dto.setCost(cart.getCost());
        dto.setCostType(cart.getCostType());
        dto.setStartTime(cart.getStartTime());
        dto.setEndTime(cart.getEndTime());

        // 현재 카트 스냅샷 테이블에는 이미지 스냅샷이 없으므로 원본 이미지를 다시 조회하지 않는다.
        dto.setImages(new ArrayList<>());

        return dto;
    }

    @Override
    public void removeItinerary(Long userId, Long itineraryId) throws Exception {
        executeWrite(sqlSession -> cartDao.deleteItinerary(sqlSession, userId, itineraryId));
    }

    @Override
    public void removeDay(Long userId, Long dayId) throws Exception {
        executeWrite(sqlSession -> cartDao.deleteDay(sqlSession, userId, dayId));
    }

    @Override
    public void removeBlock(Long userId, Long blockId) throws Exception {
        executeWrite(sqlSession -> cartDao.deleteBlock(sqlSession, userId, blockId));
    }

    @Override
    public Map<String, Object> addToCart(Long loginUserId, Long itineraryId, String itemType, Long targetId)
            throws Exception {

        if (loginUserId == null || loginUserId <= 0) {
            throw new SecurityException("로그인 후 이용할 수 있습니다.");
        }

        if (itineraryId == null || itineraryId <= 0 || targetId == null || targetId <= 0) {
            throw new IllegalArgumentException("올바른 담기 대상이 아닙니다.");
        }

        if (!"ITINERARY".equals(itemType) && !"DAY".equals(itemType) && !"BLOCK".equals(itemType)) {
            throw new IllegalArgumentException("올바른 담기 유형이 아닙니다.");
        }

        if ("ITINERARY".equals(itemType) && !itineraryId.equals(targetId)) {
            throw new IllegalArgumentException("일정 번호가 일치하지 않습니다.");
        }

        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false)) {
            try {
                // 담는 순간에만 원본을 읽고, 이후 카트 조회에서는 원본을 다시 읽지 않는다.
                ItineraryDto itinerary = bookmarkDao.selectBookmarkTargetForUpdate(sqlSession, itineraryId);

                if (itinerary == null || !"ACTIVE".equals(itinerary.getStatus())) {
                    throw new IllegalArgumentException("일정을 찾을 수 없습니다.");
                }

                boolean owner = loginUserId.equals(itinerary.getUserId());

                if (!owner && !"PUBLIC".equals(itinerary.getVisibility())) {
                    throw new SecurityException("공개된 일정만 담을 수 있습니다.");
                }

                List<ItineraryDayDto> selectedDays = selectTargetDays(sqlSession, itineraryId, itemType, targetId);

                Long cartId = cartDao.selectCartId(sqlSession, loginUserId, itineraryId);
                boolean addedItinerary = cartId == null;

                if (addedItinerary) {
                    cartDao.insertCartSnapshot(sqlSession, loginUserId, itineraryId);
                    cartId = cartDao.selectCartId(sqlSession, loginUserId, itineraryId);

                    if (cartId == null) {
                        throw new IllegalStateException("카트 일정 저장에 실패했습니다.");
                    }
                }

                int addedDays = 0;
                int addedBlocks = 0;

                for (ItineraryDayDto day : selectedDays) {
                    Long dayCartId = cartDao.selectDayCartId(sqlSession, cartId, day.getDayId());

                    if (dayCartId == null) {
                        cartDao.insertDaySnapshot(sqlSession, loginUserId, cartId, day.getDayId());
                        dayCartId = cartDao.selectDayCartId(sqlSession, cartId, day.getDayId());

                        if (dayCartId == null) {
                            throw new IllegalStateException("카트 DAY 저장에 실패했습니다.");
                        }

                        addedDays++;
                    }

                    for (ItineraryBlockDto block : day.getBlocks()) {
                        Long blockCartId = cartDao.selectBlockCartId(sqlSession, dayCartId, block.getBlockId());

                        if (blockCartId != null) {
                            // 이미 스냅샷이 있으면 원본의 현재 값으로 덮어쓰지 않는다.
                            continue;
                        }

                        cartDao.insertBlockSnapshot(sqlSession, loginUserId, dayCartId, block.getBlockId());
                        blockCartId = cartDao.selectBlockCartId(sqlSession, dayCartId, block.getBlockId());

                        if (blockCartId == null) {
                            throw new IllegalStateException("카트 블록 저장에 실패했습니다.");
                        }

                        addedBlocks++;
                    }
                }

                boolean changed = addedItinerary || addedDays > 0 || addedBlocks > 0;

                Map<String, Object> result = new HashMap<>();
                result.put("cartId", cartId);
                result.put("changed", changed);
                result.put("addedDays", addedDays);
                result.put("addedBlocks", addedBlocks);
                result.put("message", changed ? "장바구니에 담았어요." : "이미 장바구니에 담긴 내용입니다.");

                sqlSession.commit();
                return result;

            } catch (Exception e) {
                sqlSession.rollback();
                throw e;
            }
        }
    }

    private List<ItineraryDayDto> selectTargetDays(SqlSession sqlSession, Long itineraryId, String itemType,
            Long targetId) throws Exception {

        List<ItineraryDayDto> days = dayDao.selectItineraryDays(sqlSession, itineraryId);
        List<ItineraryDayDto> selectedDays = new ArrayList<>();

        for (ItineraryDayDto day : days) {
            if ("DAY".equals(itemType) && !targetId.equals(day.getDayId())) {
                continue;
            }

            List<ItineraryBlockDto> blocks = blockDao.selectItineraryBlocks(sqlSession, day.getDayId());

            if ("BLOCK".equals(itemType)) {
                List<ItineraryBlockDto> selectedBlocks = new ArrayList<>();

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

        if (!"ITINERARY".equals(itemType) && selectedDays.isEmpty()) {
            throw new IllegalArgumentException("해당 일정에 속한 담기 대상을 찾을 수 없습니다.");
        }

        return selectedDays;
    }

    @Override
    public int getCartCount(Long loginUserId) throws Exception {
        if (loginUserId == null || loginUserId <= 0) {
            return 0;
        }

        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return cartDao.selectCartCount(sqlSession, loginUserId);
        }
    }

    private void executeWrite(CartWriteAction action) throws Exception {
        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false)) {
            try {
                action.run(sqlSession);
                sqlSession.commit();
            } catch (Exception e) {
                sqlSession.rollback();
                throw e;
            }
        }
    }

    @FunctionalInterface
    private interface CartWriteAction {
        int run(SqlSession sqlSession) throws Exception;
    }
}
