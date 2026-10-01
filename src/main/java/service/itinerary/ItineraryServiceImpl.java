package service.itinerary;

import java.math.BigDecimal;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dao.itinerary.ItineraryBlockDao;
import dao.itinerary.ItineraryBlockDaoImpl;
import dao.itinerary.ItineraryBlockImageDao;
import dao.itinerary.ItineraryBlockImageDaoImpl;
import dao.itinerary.ItineraryDao;
import dao.itinerary.ItineraryDaoImpl;
import dao.itinerary.ItineraryDayDao;
import dao.itinerary.ItineraryDayDaoImpl;
import dto.itinerary.ItineraryBlockDto;
import dto.itinerary.ItineraryBlockImageDto;
import dto.itinerary.ItineraryDayDto;
import dto.itinerary.ItineraryDto;

public class ItineraryServiceImpl implements ItineraryService {

    private ItineraryDao itineraryDao;
    private ItineraryDayDao itineraryDayDao;
    private ItineraryBlockDao itineraryBlockDao;
    private ItineraryBlockImageDao itineraryBlockImageDao;

    public ItineraryServiceImpl() {
        itineraryDao = new ItineraryDaoImpl();
        itineraryDayDao = new ItineraryDayDaoImpl();
        itineraryBlockDao = new ItineraryBlockDaoImpl();
        itineraryBlockImageDao = new ItineraryBlockImageDaoImpl();
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
     * 처음 발견되는 imageOrder=1 이미지
     */
    private void prepareCalculatedFields(
            ItineraryDto itineraryDto
    ) {

        BigDecimal totalBudget = BigDecimal.ZERO;
        String thumbnailImg = null;

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

                    List<ItineraryBlockImageDto> images =
                            block.getImages();

                    if (images == null
                            || thumbnailImg != null) {
                        continue;
                    }

                    for (ItineraryBlockImageDto image : images) {

                        if (image.getImageOrder() != null
                                && image.getImageOrder() == 1
                                && image.getImageUrl() != null
                                && !image.getImageUrl().trim().isEmpty()) {

                            thumbnailImg =
                                    image.getImageUrl();

                            break;
                        }
                    }
                }
            }
        }

        itineraryDto.setTotalBudget(totalBudget);
        itineraryDto.setThumbnailImg(thumbnailImg);

        if (itineraryDto.getTravelerCount() == null
                || itineraryDto.getTravelerCount() < 1) {

            itineraryDto.setTravelerCount(1);
        }

        if (itineraryDto.getVisibility() == null
                || itineraryDto.getVisibility().trim().isEmpty()) {

            itineraryDto.setVisibility("PRIVATE");
        }
    }
}
