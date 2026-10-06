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

    private static final String SYSTEM_PROPERTY =
            "planb.itinerary.image.root";

    private static final String ENVIRONMENT_VARIABLE =
            "PLANB_ITINERARY_IMAGE_ROOT";

    private static final String WINDOWS_DEFAULT_ROOT =
            "\\\\DESKTOP-SK3JQT0\\planb-data\\uploads\\itinerary";

    private static final String MAC_DEFAULT_ROOT =
            "/Volumes/planb-data/uploads/itinerary";

    private static final String LINUX_DEFAULT_ROOT =
            "/mnt/planb-data/uploads/itinerary";

    private ItineraryImageStorage() {
    }

    public static Path getRootPath() {

        /*
         * 1순위: Tomcat/JVM 실행 옵션
         * -Dplanb.itinerary.image.root=...
         */
        String configured =
                System.getProperty(SYSTEM_PROPERTY);

        /*
         * 2순위: 운영체제 환경변수
         * PLANB_ITINERARY_IMAGE_ROOT
         */
        if (!hasText(configured)) {
            configured =
                    System.getenv(
                            ENVIRONMENT_VARIABLE
                    );
        }

     
        if (!hasText(configured)) {
            configured = getDefaultRootByOs();
        }

        return Paths.get(configured)
                .toAbsolutePath()
                .normalize();
    }

    private static String getDefaultRootByOs() {

        String osName =
                System.getProperty(
                        "os.name",
                        ""
                ).toLowerCase();

        if (osName.contains("win")) {
            return WINDOWS_DEFAULT_ROOT;
        }

        if (osName.contains("mac")) {
            return MAC_DEFAULT_ROOT;
        }

        return LINUX_DEFAULT_ROOT;
    }

    public static Path ensureRootDirectory()
            throws IOException {

        Path root = getRootPath();

        /*
         * Windows UNC 공유폴더 또는 macOS /Volumes 공유폴더가
         * 연결되지 않은 상태라면 명확한 오류를 발생시킨다.
         *
         * 부모 경로가 없는데 Files.createDirectories()를 호출하면
         * 네트워크 문제인지 폴더 문제인지 구분하기 어렵기 때문이다.
         */
        Path parent = root.getParent();

        if (parent == null || !Files.exists(parent)) {
            throw new IOException(
                    "Planb 이미지 공유폴더에 연결되어 있지 않습니다: "
                    + root
            );
        }

        Files.createDirectories(root);

        if (!Files.isDirectory(root)) {
            throw new IOException(
                    "Planb 이미지 저장 경로가 폴더가 아닙니다: "
                    + root
            );
        }

        if (!Files.isWritable(root)) {
            throw new IOException(
                    "Planb 이미지 공유폴더에 쓰기 권한이 없습니다: "
                    + root
            );
        }

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
