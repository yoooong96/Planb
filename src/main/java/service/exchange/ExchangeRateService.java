package service.exchange;

import java.util.Map;

public interface ExchangeRateService {

    Map<String, Double> getExchangeRates() throws Exception;
}
