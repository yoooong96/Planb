package controller.itinerary;

import java.io.File;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import dto.itinerary.ItineraryBlockDto;
import dto.itinerary.ItineraryBlockImageDto;
import dto.itinerary.ItineraryDayDto;
import dto.itinerary.ItineraryDto;

public final class ItineraryImageUploadUtil {

    private static final String ITINERARY_UPLOAD_DIR =
            "/uploads/itinerary";

    private ItineraryImageUploadUtil() {
    }


    /*
     * planner.jsp가 보내는 multipart 파일을 저장하고
     * 해당 ImageDto.imageUrl을 실제 저장 경로로 채운다.
     *
     * Part 이름 규칙:
     * blockImage_{dayIndex}_{blockIndex}_{imageOrder}
     *
     * 예:
     * blockImage_0_1_2
     * = 첫 번째 DAY / 두 번째 BLOCK / 2번 사진
     */
    public static List<File> bindUploadedImages(
            HttpServletRequest request,
            ItineraryDto itineraryDto
    ) throws Exception {

        List<File> createdFiles =
                new ArrayList<File>();

        if (itineraryDto == null
                || itineraryDto.getDays() == null) {

            return createdFiles;
        }

        ServletContext context =
                request.getServletContext();

        String realUploadPath =
                context.getRealPath(
                        ITINERARY_UPLOAD_DIR
                );

        if (realUploadPath == null) {
            throw new IllegalStateException(
                    "일정 이미지 업로드 경로를 확인할 수 없습니다."
            );
        }

        File uploadDir =
                new File(realUploadPath);

        if (!uploadDir.exists()
                && !uploadDir.mkdirs()) {

            throw new IllegalStateException(
                    "일정 이미지 업로드 폴더를 생성할 수 없습니다."
            );
        }

        List<ItineraryDayDto> days =
                itineraryDto.getDays();

        for (int dayIndex = 0;
                dayIndex < days.size();
                dayIndex++) {

            ItineraryDayDto day =
                    days.get(dayIndex);

            if (day == null
                    || day.getBlocks() == null) {
                continue;
            }

            List<ItineraryBlockDto> blocks =
                    day.getBlocks();

            for (int blockIndex = 0;
                    blockIndex < blocks.size();
                    blockIndex++) {

                ItineraryBlockDto block =
                        blocks.get(blockIndex);

                if (block == null
                        || block.getImages() == null) {
                    continue;
                }

                for (ItineraryBlockImageDto image
                        : block.getImages()) {

                    if (image == null) {
                        continue;
                    }

                    /*
                     * 기존 DB 이미지:
                     * imageUrl이 이미 있으므로 파일 재업로드 안 함.
                     */
                    if (hasText(image.getImageUrl())) {
                        continue;
                    }

                    Integer imageOrder =
                            image.getImageOrder();

                    if (imageOrder == null
                            || imageOrder < 1
                            || imageOrder > 3) {

                        throw new IllegalArgumentException(
                                "이미지 순서는 1~3만 가능합니다."
                        );
                    }

                    String partName =
                            "blockImage_"
                            + dayIndex + "_"
                            + blockIndex + "_"
                            + imageOrder;

                    Part part =
                            request.getPart(partName);

                    if (part == null
                            || part.getSize() == 0) {

                        throw new IllegalArgumentException(
                                "업로드할 이미지 파일을 찾을 수 없습니다: "
                                + partName
                        );
                    }

                    validateImagePart(part);

                    String extension =
                            extensionByContentType(
                                    part.getContentType()
                            );

                    String fileName =
                            UUID.randomUUID().toString()
                            + extension;

                    File targetFile =
                            new File(
                                    uploadDir,
                                    fileName
                            );

                    part.write(
                            targetFile.getAbsolutePath()
                    );

                    createdFiles.add(targetFile);

                    /*
                     * DB에는 웹 애플리케이션 기준 경로를 저장.
                     *
                     * 예:
                     * /uploads/itinerary/uuid.jpg
                     */
                    image.setImageUrl(
                            ITINERARY_UPLOAD_DIR
                            + "/"
                            + fileName
                    );
                }
            }
        }

        return createdFiles;
    }


    public static void deleteCreatedFiles(
            List<File> files) {

        if (files == null) {
            return;
        }

        for (File file : files) {

            if (file != null
                    && file.exists()) {

                try {
                    file.delete();
                } catch (Exception ignore) {
                }
            }
        }
    }


    /*
     * 일정 수정 성공 후,
     * 기존 DB에는 있었지만 현재 DTO에는 없는 이미지 파일을 삭제한다.
     */
    public static void deleteRemovedImages(
            ServletContext context,
            ItineraryDto oldItinerary,
            ItineraryDto newItinerary) {

        if (context == null
                || oldItinerary == null) {
            return;
        }

        Set<String> oldUrls =
                collectImageUrls(oldItinerary);

        Set<String> newUrls =
                collectImageUrls(newItinerary);

        oldUrls.removeAll(newUrls);

        for (String imageUrl : oldUrls) {

            /*
             * 우리 일정 업로드 폴더 안의 파일만 삭제한다.
             */
            if (imageUrl == null
                    || !imageUrl.startsWith(
                            ITINERARY_UPLOAD_DIR + "/"
                    )) {
                continue;
            }

            String realPath =
                    context.getRealPath(imageUrl);

            if (realPath == null) {
                continue;
            }

            File file =
                    new File(realPath);

            if (file.exists()) {
                try {
                    file.delete();
                } catch (Exception ignore) {
                }
            }
        }
    }


    private static Set<String> collectImageUrls(
            ItineraryDto itineraryDto) {

        Set<String> result =
                new HashSet<String>();

        if (itineraryDto == null
                || itineraryDto.getDays() == null) {
            return result;
        }

        for (ItineraryDayDto day
                : itineraryDto.getDays()) {

            if (day == null
                    || day.getBlocks() == null) {
                continue;
            }

            for (ItineraryBlockDto block
                    : day.getBlocks()) {

                if (block == null
                        || block.getImages() == null) {
                    continue;
                }

                for (ItineraryBlockImageDto image
                        : block.getImages()) {

                    if (image != null
                            && hasText(
                                    image.getImageUrl()
                            )) {

                        result.add(
                                image.getImageUrl()
                        );
                    }
                }
            }
        }

        return result;
    }


    private static void validateImagePart(
            Part part) {

        String contentType =
                part.getContentType();

        if (contentType == null
                || !contentType.startsWith(
                        "image/"
                )) {

            throw new IllegalArgumentException(
                    "이미지 파일만 업로드할 수 있습니다."
            );
        }

        /*
         * 브라우저 accept=image/* 외에도
         * 서버에서 허용 형식을 한 번 더 제한.
         */
        if (!"image/jpeg".equals(contentType)
                && !"image/png".equals(contentType)
                && !"image/gif".equals(contentType)
                && !"image/webp".equals(contentType)) {

            throw new IllegalArgumentException(
                    "JPG, PNG, GIF, WEBP 이미지만 업로드할 수 있습니다."
            );
        }
    }


    private static String extensionByContentType(
            String contentType) {

        if ("image/png".equals(contentType)) {
            return ".png";
        }

        if ("image/gif".equals(contentType)) {
            return ".gif";
        }

        if ("image/webp".equals(contentType)) {
            return ".webp";
        }

        return ".jpg";
    }


    private static boolean hasText(
            String value) {

        return value != null
                && !value.trim().isEmpty();
    }
}
