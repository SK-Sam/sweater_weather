class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @current_weather = {
      datetime: Time.at(data[:current][:dt]),
      sunrise: Time.at(data[:current][:sunrise]),
      sunset: Time.at(data[:current][:sunset]),
      temperature: ((data[:current][:temp] - 273.15) * 9 / 5) + 32,
      feels_like: ((data[:current][:feels_like] - 273.15) * 9 / 5) + 32,
      humidity: data[:current][:humidity],
      uvi: data[:current][:uvi],
      visibility: data[:current][:visibility],
      conditions: data[:current][:weather].first[:description],
      icon: data[:current][:weather].first[:icon]
    }

    @daily_weather = data[:daily].first(5).map do |weather_data|
      {
        date: Time.at(weather_data[:dt]).strftime("%F"),
        sunrise: Time.at(weather_data[:sunrise]),
        sunset: Time.at(weather_data[:sunset]),
        max_temp: ((weather_data[:temp][:max] - 273.15) * 9 / 5) + 32,
        min_temp: ((weather_data[:temp][:min] - 273.15) * 9 / 5) + 32,
        conditions: weather_data[:weather].first[:description],
        icon: weather_data[:weather].first[:icon]
    }
    end

    @hourly_weather = data[:hourly].first(8).map do |weather_data|
      {
        time: Time.at(weather_data[:dt]).strftime("%T"),
        temperature: ((weather_data[:temp] - 273.15) * 9 / 5) + 32,
        conditions: weather_data[:weather].first[:description],
        icon: weather_data[:weather].first[:icon]
      }
    end
  end
end