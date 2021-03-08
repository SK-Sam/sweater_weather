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
    lng = map_data[:route][:locations].last[:displayLatLng][:lng]
    lat = map_data[:route][:locations].last[:displayLatLng][:lat]

    # Forecast portion
  end
end