class Api::V1::MunchiesController < ApplicationController
  def recommender
    # params[:start], [:destination], [:food]
    # Map portion
    # map_data = CityService.get_directions_data(params[:start], params[:destination])
    # travel_time_with_traffic = map_data[:route][:realTime]

    # destination_city = map_data[:route][:locations].last[:adminArea5] +
    # ', ' + map_data[:route][:locations].last[:adminArea3]
    # travel_time = map_data[:route][:formattedTime].first(2) + ' hours ' + map_data[:route][:formattedTime][3..4] + ' min'
    # lat = map_data[:route][:locations].last[:displayLatLng][:lat]
    # lng = map_data[:route][:locations].last[:displayLatLng][:lng]


    # Forecast portion
    
    #filtered_forecast_data = LocationWeatherFacade.filter_forecast_data(lat, lng)

    #Yelp portion
    # yelp_response = Faraday.get("https://api.yelp.com/v3/businesses/search") do |req|
    #   req.headers['Content-Type'] = 'application/json'
    #   req.headers['Authorization'] = "Bearer #{ENV['yelp_api_key']}"
    #   req.params['latitude'] = lat
    #   req.params['longitude'] = lng
    #   req.params['categories'] = params[:food]
    #   req.params['open_at'] = Time.now.to_i + travel_time_with_traffic
    # end
    # time_arrival_unix = Time.now.to_i + travel_time_with_traffic
    # yelp_data = YelpService.get_restaurant_data(lat, lng, params[:food], time_arrival_unix)
    # restaurant = {
    #   name: yelp_data[:businesses].first[:name],
    #   address: yelp_data[:businesses].first[:location][:address1] + ' ' +
    #     yelp_data[:businesses].first[:location][:address2] + ', ' +
    #     yelp_data[:businesses].first[:location][:city] + ' ' +
    #     yelp_data[:businesses].first[:location][:state] + ' ' +
    #     yelp_data[:businesses].first[:location][:zip_code]
    # }
    # restaurant_data = YelpFacade.filter_restaurant_data(lat, lng, params[:food], time_arrival_unix)
    # data_to_serialize = {
    #   destination_city: destination_city,
    #   travel_time: travel_time,
    #   forecast: forecast,
    #   restaurant: restaurant
    # }


    render json: MunchieSerializer.new(
      MunchieFacade.get_all_datas_into_munchie_poro(params[:start], params[:destination], params[:food])
    )
  end
end