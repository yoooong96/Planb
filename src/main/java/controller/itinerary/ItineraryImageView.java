package controller.itinerary;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * DB에는 /uploads/itinerary/{파일명} 형태만 저장하고,
 * 실제 파일은 공유폴더에서 읽어서 브라우저에 전달한다.
 */
@WebServlet("/uploads/itinerary/*")
public class ItineraryImageView
        extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo =
                request.getPathInfo();

        if (pathInfo == null
                || pathInfo.length() <= 1) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );
            return;
        }

        String fileName =
                pathInfo.substring(1);

        Path imagePath;

        try {
            imagePath =
                    ItineraryImageStorage
                        .resolveFileName(fileName);
        } catch (IllegalArgumentException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST
            );
            return;
        }

        if (!Files.exists(imagePath)
                || !Files.isRegularFile(imagePath)) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );
            return;
        }

        String contentType =
                getServletContext()
                    .getMimeType(
                            imagePath
                                .getFileName()
                                .toString()
                    );

        if (contentType == null) {
            contentType =
                    Files.probeContentType(
                            imagePath
                    );
        }

        if (contentType == null
                || !contentType.startsWith("image/")) {

            response.sendError(
                    HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE
            );
            return;
        }

        response.setContentType(contentType);
        response.setContentLengthLong(
                Files.size(imagePath)
        );

        /*
         * UUID 파일명은 내용이 바뀌지 않으므로 브라우저 캐시를 허용.
         * 이것은 사용자가 직접 업로드한 이미지용 캐시다.
         */
        response.setHeader(
                "Cache-Control",
                "public, max-age=604800"
        );

        try (OutputStream output =
                response.getOutputStream()) {

            Files.copy(
                    imagePath,
                    output
            );
        }
    }
}
