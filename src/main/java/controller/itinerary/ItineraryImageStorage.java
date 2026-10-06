package controller.itinerary;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * 일정 이미지 저장 위치 관리.
 *
 * 실제 파일:
 * UNC 경로: //DESKTOP-SK3JQT0/planb-data/uploads/itinerary
 *
 * DB에 저장되는 URL:
 * /uploads/itinerary/{uuid}.jpg
 *
 * 필요하면 실행 옵션 또는 환경변수로 경로를 덮어쓸 수 있다.
 * - JVM: -Dplanb.itinerary.image.root=...
 * - ENV: PLANB_ITINERARY_IMAGE_ROOT
 */
public final class ItineraryImageStorage {

    public static final String WEB_URL_PREFIX =
            "/uploads/itinerary";

    private static final String DEFAULT_ROOT =
            "\\\\DESKTOP-SK3JQT0\\planb-data\\uploads\\itinerary";

    private static final String SYSTEM_PROPERTY =
            "planb.itinerary.image.root";

    private static final String ENVIRONMENT_VARIABLE =
            "PLANB_ITINERARY_IMAGE_ROOT";

    private ItineraryImageStorage() {
    }

    public static Path getRootPath() {

        String configured =
                System.getProperty(SYSTEM_PROPERTY);

        if (!hasText(configured)) {
            configured =
                    System.getenv(
                            ENVIRONMENT_VARIABLE
                    );
        }

        if (!hasText(configured)) {
            configured = DEFAULT_ROOT;
        }

        return Paths.get(configured)
                .toAbsolutePath()
                .normalize();
    }

    public static Path ensureRootDirectory()
            throws IOException {

        Path root = getRootPath();

        Files.createDirectories(root);

        return root;
    }

    public static Path resolveFileName(
            String fileName) {

        if (!hasText(fileName)) {
            throw new IllegalArgumentException(
                    "이미지 파일명이 없습니다."
            );
        }

        /*
         * 브라우저 요청으로 들어온 파일명에
         * ../ 등의 경로 조작이 들어오는 것을 막는다.
         */
        if (fileName.contains("/")
                || fileName.contains("\\")
                || fileName.contains("..")) {

            throw new IllegalArgumentException(
                    "잘못된 이미지 파일명입니다."
            );
        }

        Path root = getRootPath();

        Path target =
                root.resolve(fileName)
                    .normalize();

        if (!target.startsWith(root)) {
            throw new IllegalArgumentException(
                    "잘못된 이미지 경로입니다."
            );
        }

        return target;
    }

    public static Path resolveWebUrl(
            String imageUrl) {

        if (!hasText(imageUrl)
                || !imageUrl.startsWith(
                        WEB_URL_PREFIX + "/"
                )) {

            return null;
        }

        String fileName =
                imageUrl.substring(
                        (WEB_URL_PREFIX + "/").length()
                );

        return resolveFileName(fileName);
    }

    public static String toWebUrl(
            String fileName) {

        return WEB_URL_PREFIX
                + "/"
                + fileName;
    }

    private static boolean hasText(
            String value) {

        return value != null
                && !value.trim().isEmpty();
    }
}
