package service.exchange;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.Timestamp;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.ibatis.session.SqlSession;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import config.MybatisSqlSessionFactory;
import dao.exchange.ExchangeRateDao;
import dao.exchange.ExchangeRateDaoImpl;
import dto.exchange.ExchangeRateDto;

public class ExchangeRateServiceImpl
        implements ExchangeRateService {

    private static final String API_URL =
            "https://open.er-api.com/v6/latest/KRW";

    private static final long REFRESH_INTERVAL_MILLIS =
            60L * 60L * 1000L;

    private ExchangeRateDao exchangeRateDao;

    public ExchangeRateServiceImpl() {
        exchangeRateDao = new ExchangeRateDaoImpl();
    }

    @Override
    public synchronized Map<String, Double> getExchangeRates()
            throws Exception {

        SqlSession sqlSession = null;

        try {
            sqlSession = MybatisSqlSessionFactory
                    .getSqlSessionFactory()
                    .openSession();

            Timestamp latestUpdatedAt =
                    exchangeRateDao.selectLatestUpdatedAt(
                            sqlSession
                    );

            boolean refreshNeeded =
                    latestUpdatedAt == null
                    || System.currentTimeMillis()
                       - latestUpdatedAt.getTime()
                       >= REFRESH_INTERVAL_MILLIS;

            if (refreshNeeded) {
                try {
                    Map<String, Double> apiRates =
                            fetchRatesFromApi();

                    Timestamp now =
                            new Timestamp(
                                    System.currentTimeMillis()
                            );

                    for (Entry<String, Double> entry
                            : apiRates.entrySet()) {

                        exchangeRateDao.upsert(
                                sqlSession,
                                new ExchangeRateDto(
                                        entry.getKey(),
                                        entry.getValue(),
                                        now
                                )
                        );
                    }

                    sqlSession.commit();

                } catch (Exception apiException) {
                    /*
                     * API가 잠시 실패해도 기존 DB 환율이 있으면
                     * 일정 작성 페이지는 계속 사용할 수 있게 한다.
                     */
                    sqlSession.rollback();

                    List<ExchangeRateDto> existing =
                            exchangeRateDao.selectAll(
                                    sqlSession
                            );

                    if (existing == null
                            || existing.isEmpty()) {
                        throw apiException;
                    }
                }
            }

            return toMap(
                    exchangeRateDao.selectAll(
                            sqlSession
                    )
            );

        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }

    private Map<String, Double> fetchRatesFromApi()
            throws Exception {

        HttpURLConnection connection = null;

        try {
            connection = (HttpURLConnection)
                    new URL(API_URL).openConnection();

            connection.setRequestMethod("GET");
            connection.setConnectTimeout(5000);
            connection.setReadTimeout(5000);
            connection.setRequestProperty(
                    "Accept",
                    "application/json"
            );

            int status = connection.getResponseCode();

            if (status < 200 || status >= 300) {
                throw new IllegalStateException(
                        "환율 API 응답 오류: HTTP " + status
                );
            }

            StringBuilder body = new StringBuilder();

            try (BufferedReader reader =
                    new BufferedReader(
                            new InputStreamReader(
                                    connection.getInputStream(),
                                    StandardCharsets.UTF_8
                            )
                    )) {

                String line;
                while ((line = reader.readLine()) != null) {
                    body.append(line);
                }
            }

            JsonObject root =
                    JsonParser.parseString(
                            body.toString()
                    ).getAsJsonObject();

            if (!"success".equals(
                    root.get("result").getAsString())) {
                throw new IllegalStateException(
                        "환율 API 결과가 success가 아닙니다."
                );
            }

            JsonObject ratesObject =
                    root.getAsJsonObject("rates");

            Map<String, Double> rates =
                    new LinkedHashMap<>();

            for (Entry<String, JsonElement> entry
                    : ratesObject.entrySet()) {

                if (entry.getValue() != null
                        && entry.getValue().isJsonPrimitive()) {

                    rates.put(
                            entry.getKey(),
                            entry.getValue().getAsDouble()
                    );
                }
            }

            return rates;

        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
    }

    private Map<String, Double> toMap(
            List<ExchangeRateDto> rows) {

        Map<String, Double> result =
                new LinkedHashMap<>();

        if (rows == null) {
            return result;
        }

        for (ExchangeRateDto row : rows) {
            if (row.getCurrencyCode() != null
                    && row.getRate() != null) {

                result.put(
                        row.getCurrencyCode(),
                        row.getRate()
                );
            }
        }

        return result;
    }
}
