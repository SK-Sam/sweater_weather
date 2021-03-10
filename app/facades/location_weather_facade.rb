class LocationWeatherFacade
  class << self
    def filter_forecast_data_hourly(lat, lng, hour)
      weather_data = Forecast.new(LocationWeatherService.get_weather_data(lat, lng))
      forecast = {
        conditions: weather_data.hourly_weather[hour][:conditions],
        temperature: weather_data.hourly_weather[hour][:temperature].round(1)
      }
    end
    def filter_forecast_data_daily(lat, lng, day)
      weather_data = Forecast.new(LocationWeatherService.get_weather_data(lat, lng))
      forecast = {
        conditions: weather_data.daily_weather[day][:conditions],
        temperature: weather_data.daily_weather[day][:min_temp].round(1)
      }
    end
  end
end