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
    travel_time_with_traffic = map_data[:route][:realTime]

    destination_city = map_data[:route][:locations].last[:adminArea5] + map_data[:route][:locations].last[:adminArea3]
    #travel_time = "#{travel_time_with_traffic % 3600} hours #{} min"
    travel_time = map_data[:route][:formattedTime].first(2) + ' hours ' + map_data[:route][:formattedTime][3..4] + ' min'
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
      req.params['open_at'] = Time.now.to_i + travel_time_with_traffic
    end
    yelp_data = JSON.parse(yelp_response.body, symbolize_names: true)
    restaurant = {
      name: yelp_data[:businesses].first[:name],
      address: yelp_data[:businesses].first[:location][:address1] + ' ' +
        yelp_data[:businesses].first[:location][:address2] + ' ' +
        yelp_data[:businesses].first[:location][:city] + ' ' +
        yelp_data[:businesses].first[:location][:state] + ' ' +
        yelp_data[:businesses].first[:location][:zip_code]
    }

    data_to_serialize = {
      destination_city: destination_city,
      travel_time: travel_time,
      forecast: forecast,
      restaurant: restaurant
    }

    render json: data_to_serialize
  end
end