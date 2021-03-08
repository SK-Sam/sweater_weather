class Api::V1::MunchiesController < ApplicationController
  def recommender
    # params[:start], [:destination], [:food]
    # Map portion
    map_response = Faraday.get("http://www.mapquestapi.com/directions/v2/route") do |req|
      req.params['key'] = ENV['map_api_key']
      req.params['from'] = params[:start]
      req.params['to'] = params[:destination]
    end
    map_data = JSON.parse(map_response.body, symbolize_names: true)
    destination_city = map_data[:route][:locations].last[:adminArea5] + map_data[:route][:locations].last[:adminArea3]
    travel_time = map_data[:route][:realTime]
    lat = map_data[:route][:locations].last[:displayLatLng][:lat]
    lng = map_data[:route][:locations].last[:displayLatLng][:lng]

    # Forecast portion
    weather_data = Forecast.new(LocationWeatherService.get_weather_data(lat, lng))
    forecast = {
      summary: weather_data.current_weather[:conditions],
      temperature: weather_data.current_weather[:temperature]
    }

    #Yelp portion
    yelp_response = Faraday.get("https://api.yelp.com/v3/businesses/search") do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{yelp_api_key}"
      req.params['latitude'] = lat
      req.params['longitude'] = lng
      req.params['categories'] = params[:food]
    end

  end
end