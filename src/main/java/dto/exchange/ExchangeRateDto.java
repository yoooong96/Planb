package dto.exchange;

import java.sql.Timestamp;

public class ExchangeRateDto {

    private String currencyCode;
    private Double rate;
    private Timestamp updatedAt;

    public ExchangeRateDto() {
    }

    public ExchangeRateDto(
            String currencyCode,
            Double rate,
            Timestamp updatedAt) {
        this.currencyCode = currencyCode;
        this.rate = rate;
        this.updatedAt = updatedAt;
    }

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    public Double getRate() {
        return rate;
    }

    public void setRate(Double rate) {
        this.rate = rate;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
