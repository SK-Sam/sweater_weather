class Api::V1::ForecastController < ApplicationController
  def city_weather
    location = CityFacade.get_lat_long(params[:location])
    weather_data = LocationWeatherService.get_weather_data(location[:lat], location[:lon])
    filtered_forecast = Forecast.new(weather_data)
    render json: ForecastSerializer.new(filtered_forecast)
  end
end