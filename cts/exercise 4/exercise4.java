package digitalnurture.FinancialForecast;

public class FinancialForecast {

    // Recursive method to calculate future value
    public static double forecastValue(double principal, double rate, int years) {
        // Base case: after 0 years, value is just the principal
        if (years == 0) {
            return principal;
        }
        // Recursive case: value grows by rate each year
        return forecastValue(principal, rate, years - 1) * (1 + rate);
    }

    public static void main(String[] args) {
        double principal = 10000.0;      // Starting amount
        double annualRate = 0.10;        // 10% annual growth
        int years = 5;                   // Forecast for 5 years

        double futureValue = forecastValue(principal, annualRate, years);

        System.out.printf("Future value after %d years: Rs. %.2f\n", years, futureValue);
    }
}
