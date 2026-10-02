package service.itinerary;

import java.math.BigDecimal;
import java.util.HashMap;
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
import dao.itinerary.ItineraryDao;
import dao.itinerary.ItineraryDaoImpl;
import dao.itinerary.ItineraryDayDao;
import dao.itinerary.ItineraryDayDaoImpl;
import dto.itinerary.ItineraryBlockDto;
import dto.itinerary.ItineraryBlockImageDto;
import dto.itinerary.ItineraryBookmarkDto;
import dto.itinerary.ItineraryDayDto;
import dto.itinerary.ItineraryDto;

public class ItineraryServiceImpl implements ItineraryService {

    private ItineraryDao itineraryDao;
    private ItineraryDayDao itineraryDayDao;
    private ItineraryBlockDao itineraryBlockDao;
    private ItineraryBlockImageDao itineraryBlockImageDao;
    private ItineraryBookmarkDao itineraryBookmarkDao;

    public ItineraryServiceImpl() {
        itineraryDao = new ItineraryDaoImpl();
        itineraryDayDao = new ItineraryDayDaoImpl();
        itineraryBlockDao = new ItineraryBlockDaoImpl();
        itineraryBlockImageDao = new ItineraryBlockImageDaoImpl();
        itineraryBookmarkDao = new ItineraryBookmarkDaoImpl();
    }

	@Override
	public List<ItineraryDto> getScheduleList(Long loginUserId) throws Exception {
		 Map<String, Object> params = new HashMap<>();
	     params.put("loginUserId", loginUserId);
	     params.put("limit", 12);
	     params.put("offset", 0);
	     return itineraryDao.selectScheduleList(params);
	}
    
    /*
     * 신규 일정 저장
     *
     * TB_ITINERARY
     *      ↓ itineraryId
     * TB_ITINERARY_DAY
     *      ↓ dayId
     * TB_ITINERARY_BLOCK
     *      ↓ blockId
     * TB_ITINERARY_BLOCK_IMAGE
     *
     * 전체 과정을 하나의 SqlSession으로 처리한다.
     */
    @Override
    public Long writeItinerary(ItineraryDto itineraryDto) throws Exception {

        SqlSession sqlSession = null;

        try {
            sqlSession = MybatisSqlSessionFactory
                    .getSqlSessionFactory()
                    .openSession(false);

            prepareCalculatedFields(itineraryDto);

            itineraryDao.insertItinerary(
                    sqlSession,
                    itineraryDto
            );

            insertChildren(
                    sqlSession,
                    itineraryDto
            );

            sqlSession.commit();

            return itineraryDto.getItineraryId();

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


    /*
     * 일정 수정
     *
     * 1. 일정 기본정보 UPDATE
     * 2. 기존 DAY 삭제
     *    - DB의 ON DELETE CASCADE에 의해
     *      BLOCK / IMAGE도 함께 삭제된다.
     * 3. 현재 화면에 있는 DAY/BLOCK/IMAGE를 다시 INSERT
     *
     * 하나라도 실패하면 전체 rollback.
     */
    @Override
    public void modifyItinerary(ItineraryDto itineraryDto) throws Exception {

        SqlSession sqlSession = null;

        try {
            sqlSession = MybatisSqlSessionFactory
                    .getSqlSessionFactory()
                    .openSession(false);

            if (itineraryDto.getItineraryId() == null) {
                throw new IllegalArgumentException(
                        "수정할 itineraryId가 없습니다."
                );
            }

            prepareCalculatedFields(itineraryDto);

            int updateCount = itineraryDao.updateItinerary(
                    sqlSession,
                    itineraryDto
            );

            if (updateCount == 0) {
                throw new Exception(
                        "수정할 일정을 찾을 수 없거나 수정 권한이 없습니다."
                );
            }

            /*
             * DAY 삭제 시 BLOCK, IMAGE는 FK CASCADE로 같이 삭제된다.
             */
            itineraryDayDao.deleteItineraryDaysByItineraryId(
                    sqlSession,
                    itineraryDto.getItineraryId()
            );

            insertChildren(
                    sqlSession,
                    itineraryDto
            );

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


    /*
     * 일정 수정 화면용 전체 계층 조회
     *
     * ItineraryDto
     *  └─ DayDto
     *      └─ BlockDto
     *          └─ BlockImageDto
     */
    @Override
    public ItineraryDto getItinerary(Long itineraryId) throws Exception {

        SqlSession sqlSession = null;

        try {
            sqlSession = MybatisSqlSessionFactory
                    .getSqlSessionFactory()
                    .openSession();

            ItineraryDto itinerary =
                    itineraryDao.selectItinerary(
                            sqlSession,
                            itineraryId
                    );

            if (itinerary == null) {
                return null;
            }

            List<ItineraryDayDto> days =
                    itineraryDayDao.selectItineraryDays(
                            sqlSession,
                            itineraryId
                    );

            for (ItineraryDayDto day : days) {

                List<ItineraryBlockDto> blocks =
                        itineraryBlockDao.selectItineraryBlocks(
                                sqlSession,
                                day.getDayId()
                        );

                for (ItineraryBlockDto block : blocks) {

                    List<ItineraryBlockImageDto> images =
                            itineraryBlockImageDao
                                    .selectItineraryBlockImages(
                                            sqlSession,
                                            block.getBlockId()
                                    );

                    block.setImages(images);
                }

                day.setBlocks(blocks);
            }

            itinerary.setDays(days);

            return itinerary;

        } finally {

            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }


    /*
     * 일정 소프트 삭제
     */
    @Override
    public void deleteItinerary(
            Long itineraryId,
            Long userId
    ) throws Exception {

        SqlSession sqlSession = null;

        try {
            sqlSession = MybatisSqlSessionFactory
                    .getSqlSessionFactory()
                    .openSession(false);

            int deleteCount =
                    itineraryDao.deleteItinerary(
                            sqlSession,
                            itineraryId,
                            userId
                    );

            if (deleteCount == 0) {
                throw new Exception(
                        "삭제할 일정을 찾을 수 없거나 삭제 권한이 없습니다."
                );
            }

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


    /*
     * DAY → BLOCK → IMAGE 저장
     *
     * INSERT 후 MyBatis useGeneratedKeys에 의해
     * dayId / blockId / imageId가 DTO에 자동으로 들어온다.
     */
    private void insertChildren(
            SqlSession sqlSession,
            ItineraryDto itineraryDto
    ) throws Exception {

        List<ItineraryDayDto> days =
                itineraryDto.getDays();

        if (days == null) {
            return;
        }

        for (ItineraryDayDto day : days) {

            day.setItineraryId(
                    itineraryDto.getItineraryId()
            );

            /*
             * 수정 시 기존 ID가 프론트에서 들어올 수 있지만,
             * 하위 데이터는 삭제 후 재INSERT하므로 신규 PK를 받는다.
             */
            day.setDayId(null);

            itineraryDayDao.insertItineraryDay(
                    sqlSession,
                    day
            );

            List<ItineraryBlockDto> blocks =
                    day.getBlocks();

            if (blocks == null) {
                continue;
            }

            for (ItineraryBlockDto block : blocks) {

                block.setDayId(
                        day.getDayId()
                );

                block.setBlockId(null);

                itineraryBlockDao.insertItineraryBlock(
                        sqlSession,
                        block
                );

                List<ItineraryBlockImageDto> images =
                        block.getImages();

                if (images == null) {
                    continue;
                }

                for (ItineraryBlockImageDto image : images) {

                    image.setBlockId(
                            block.getBlockId()
                    );

                    image.setImageId(null);

                    itineraryBlockImageDao
                            .insertItineraryBlockImage(
                                    sqlSession,
                                    image
                            );
                }
            }
        }
    }


    /*
     * 클라이언트 값을 그대로 신뢰하지 않고
     * 서버에서 계산할 값 정리.
     *
     * totalBudget:
     * 모든 Block.cost의 합
     *
     * thumbnailImg:
     * 저장 전 미리보기 모달에서 사용자가 고른 값을 유지한다.
     */
    private void prepareCalculatedFields(
            ItineraryDto itineraryDto
    ) {

        BigDecimal totalBudget = BigDecimal.ZERO;

        List<ItineraryDayDto> days =
                itineraryDto.getDays();

        if (days != null) {

            for (ItineraryDayDto day : days) {

                List<ItineraryBlockDto> blocks =
                        day.getBlocks();

                if (blocks == null) {
                    continue;
                }

                for (ItineraryBlockDto block : blocks) {

                    if (block.getCost() != null) {
                        totalBudget =
                                totalBudget.add(
                                        block.getCost()
                                );
                    }
                }
            }
        }

        itineraryDto.setTotalBudget(totalBudget);

        if (itineraryDto.getTravelerCount() == null
                || itineraryDto.getTravelerCount() < 1) {

            itineraryDto.setTravelerCount(1);
        }

        if (itineraryDto.getVisibility() == null
                || itineraryDto.getVisibility().trim().isEmpty()) {

            itineraryDto.setVisibility("PRIVATE");
        }
    }

	@Override
	public boolean toggleBookmark(Long itineraryId, Long loginUserId) throws Exception {
		 // 로그인 여부는 Servlet에서도 확인할 예정
	    if (loginUserId == null || loginUserId <= 0) {
	    	throw new SecurityException("로그인 후 이용할 수 있습니다.");
	    }

	    if (itineraryId == null || itineraryId <= 0) {
	        throw new IllegalArgumentException("올바른 일정 번호가 아닙니다.");
	    }

	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false)) {
	        try {
	            // 일정 조회 및 잠금
	            ItineraryDto itinerary = itineraryBookmarkDao.selectBookmarkTargetForUpdate(sqlSession,itineraryId);
	            if (itinerary == null || !"ACTIVE".equals(itinerary.getStatus())) {
	                throw new IllegalArgumentException("일정을 찾을 수 없습니다.");
	            }
	            // 본인 일정 북마크 차단
	            if (loginUserId.equals(itinerary.getUserId())) {
	            	throw new SecurityException("본인이 작성한 일정은 북마크할 수 없습니다.");
	            }

	            if (!"PUBLIC".equals(itinerary.getVisibility())) {
	                throw new SecurityException("공개된 일정만 북마크할 수 있습니다.");
	            }

	            ItineraryBookmarkDto bookmark = new ItineraryBookmarkDto();

	            bookmark.setItineraryId(itineraryId);
	            bookmark.setUserId(loginUserId);

	            // 현재 북마크 상태 확인
	            boolean alreadyBookmarked = itineraryBookmarkDao.selectItineraryBookmark(sqlSession,bookmark);

	            if (alreadyBookmarked) {
	                itineraryBookmarkDao.deleteItineraryBookmark(sqlSession,bookmark);
	            } else {
	                itineraryBookmarkDao.insertItineraryBookmark(sqlSession,bookmark);
	            }

	            sqlSession.commit();

	            // 처리 후 상태 반환
	            return !alreadyBookmarked;

	        } catch (Exception e) {
	            sqlSession.rollback();
	            throw e;
	        }
	    }
	}
}
