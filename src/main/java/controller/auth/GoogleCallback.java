package controller.auth;

import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import dto.member.UserDto;
import service.member.UserService;
import service.member.UserServiceImpl;

/**
 * Servlet implementation class GoogleCallback
 */
@WebServlet("/auth/google/callback")
public class GoogleCallback extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private UserService userService = new UserServiceImpl();
	
    public GoogleCallback() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        request.setCharacterEncoding("UTF-8");


        HttpSession session =
                request.getSession();


        /* =====================================================
           환경변수
           ===================================================== */

        String clientId =
                System.getenv(
                        "GOOGLE_CLIENT_ID"
                );


        String clientSecret =
                System.getenv(
                        "GOOGLE_CLIENT_SECRET"
                );


        String redirectUri =
                System.getenv(
                        "GOOGLE_REDIRECT_URI"
                );


        if (
            clientId == null
            || clientSecret == null
            || redirectUri == null
        ) {

            throw new ServletException(
                    "Google OAuth 환경변수가 설정되지 않았습니다."
            );
        }



        /* =====================================================
           Google 오류 확인
           ===================================================== */

        String googleError =
                request.getParameter(
                        "error"
                );


        if (googleError != null) {

            session.setAttribute(
                    "googleLoginError",
                    "Google 로그인이 취소되었거나 실패했습니다."
            );


            response.sendRedirect(
                    request.getContextPath()
                    + "/view/auth/login.jsp"
            );


            return;
        }



        /* =====================================================
           state 검증
           ===================================================== */

        String state =
                request.getParameter(
                        "state"
                );


        String savedState =
                (String) session.getAttribute(
                        "googleOAuthState"
                );


        if (
            state == null
            || savedState == null
            || !state.equals(savedState)
        ) {

            throw new ServletException(
                    "Google OAuth state 값이 일치하지 않습니다."
            );
        }


        /*
         * state는 한 번 사용했으므로 제거
         */
        session.removeAttribute(
                "googleOAuthState"
        );



        /* =====================================================
           authorization code
           ===================================================== */

        String code =
                request.getParameter(
                        "code"
                );


        if (
            code == null
            || code.trim().isEmpty()
        ) {

            throw new ServletException(
                    "Google 인증 코드를 받지 못했습니다."
            );
        }



        try {


            /* =================================================
               1. authorization code → access token
               ================================================= */

            String tokenBody =

                    "code="
                    + encode(code)

                    + "&client_id="
                    + encode(clientId)

                    + "&client_secret="
                    + encode(clientSecret)

                    + "&redirect_uri="
                    + encode(redirectUri)

                    + "&grant_type=authorization_code";


            HttpRequest tokenRequest =
                    HttpRequest
                        .newBuilder()
                        .uri(
                            URI.create(
                                "https://oauth2.googleapis.com/token"
                            )
                        )
                        .header(
                            "Content-Type",
                            "application/x-www-form-urlencoded"
                        )
                        .POST(
                            HttpRequest.BodyPublishers
                                .ofString(
                                    tokenBody
                                )
                        )
                        .build();


            HttpClient httpClient =
                    HttpClient.newHttpClient();


            HttpResponse<String> tokenResponse =
                    httpClient.send(
                            tokenRequest,
                            HttpResponse.BodyHandlers
                                .ofString()
                    );


            if (
                tokenResponse.statusCode()
                != 200
            ) {

                System.out.println(
                        tokenResponse.body()
                );


                throw new Exception(
                        "Google 토큰 발급에 실패했습니다."
                );
            }



            JsonObject tokenJson =
                    JsonParser
                        .parseString(
                            tokenResponse.body()
                        )
                        .getAsJsonObject();


            String accessToken =
                    tokenJson
                        .get(
                            "access_token"
                        )
                        .getAsString();



            /* =================================================
               2. Google 사용자 정보 조회
               ================================================= */

            HttpRequest userInfoRequest =
                    HttpRequest
                        .newBuilder()
                        .uri(
                            URI.create(
                                "https://openidconnect.googleapis.com/v1/userinfo"
                            )
                        )
                        .header(
                            "Authorization",
                            "Bearer "
                            + accessToken
                        )
                        .GET()
                        .build();


            HttpResponse<String> userInfoResponse =
                    httpClient.send(
                            userInfoRequest,
                            HttpResponse.BodyHandlers
                                .ofString()
                    );


            if (
                userInfoResponse.statusCode()
                != 200
            ) {

                System.out.println(
                        userInfoResponse.body()
                );


                throw new Exception(
                        "Google 사용자 정보를 가져오지 못했습니다."
                );
            }



            JsonObject googleUser =
                    JsonParser
                        .parseString(
                            userInfoResponse.body()
                        )
                        .getAsJsonObject();



            /* =================================================
               3. Google 정보 추출
               ================================================= */

            String googleSub =
                    getString(
                        googleUser,
                        "sub"
                    );


            String email =
                    getString(
                        googleUser,
                        "email"
                    );


            String name =
                    getString(
                        googleUser,
                        "name"
                    );


            String picture =
                    getString(
                        googleUser,
                        "picture"
                    );


            boolean emailVerified =
                    googleUser.has(
                            "email_verified"
                    )
                    && googleUser
                        .get(
                            "email_verified"
                        )
                        .getAsBoolean();



            if (
                googleSub == null
                || email == null
            ) {

                throw new Exception(
                        "Google 계정 정보를 확인할 수 없습니다."
                );
            }



            if (!emailVerified) {

                throw new Exception(
                        "Google에서 인증되지 않은 이메일입니다."
                );
            }



            /* =================================================
               4. 이미 가입된 Google 회원인지 확인
               ================================================= */

            UserDto existingUser =
                    userService
                        .findSocialUser(
                            "GOOGLE",
                            googleSub
                        );



            /* =================================================
               기존 회원 → 바로 로그인
               ================================================= */

            if (
                existingUser != null
            ) {


                session.setAttribute(
                        "user",
                        existingUser
                );


                response.sendRedirect(
                        request.getContextPath()
                        + "/home"
                );


                return;
            }



            /* =================================================
               5. 신규 Google 회원

               아직 DB INSERT 하지 않음.

               Google에서 받을 수 없는
               닉네임/전화번호/주소를
               추가정보 페이지에서 받음.
               ================================================= */


            /*
             * 같은 이메일로 LOCAL 회원이 존재하는지
             * 다음 단계에서 검사하도록 할 수도 있음.
             */


            session.setAttribute(
                    "googleSignupSub",
                    googleSub
            );


            session.setAttribute(
                    "googleSignupEmail",
                    email
            );


            session.setAttribute(
                    "googleSignupName",
                    name
            );


            session.setAttribute(
                    "googleSignupPicture",
                    picture
            );


            /*
             * Google 인증을 정상적으로 완료했다는 표시
             */
            session.setAttribute(
                    "googleSignupVerified",
                    true
            );



            /* =================================================
               추가정보 입력 페이지 이동
               ================================================= */

            response.sendRedirect(
                    request.getContextPath()
                    + "/auth/googleAdditionalInfo"
            );


        } catch (Exception e) {


            e.printStackTrace();


            session.setAttribute(
                    "googleLoginError",
                    e.getMessage()
            );


            response.sendRedirect(
                    request.getContextPath()
                    + "/auth/login"
            );

        }

    }



    /* ============================================================
       URL Encode
       ============================================================ */

    private String encode(
            String value) {

        return URLEncoder.encode(
                value,
                StandardCharsets.UTF_8
        );

    }



    /* ============================================================
       JSON String 안전하게 가져오기
       ============================================================ */

    private String getString(
            JsonObject object,
            String key) {


        if (
            object == null
            || !object.has(key)
            || object.get(key).isJsonNull()
        ) {

            return null;

        }


        return object
                .get(key)
                .getAsString();

    }

}


