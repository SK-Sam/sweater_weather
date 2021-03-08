class LocationWeatherFacade
  class << self
    def filter_forecast_data(lat, lng)
      weather_data = Forecast.new(LocationWeatherService.get_weather_data(lat, lng))
      forecast = {
        summary: weather_data.current_weather[:conditions],
        temperature: weather_data.current_weather[:temperature].round(1)
      }
    end
  end
end