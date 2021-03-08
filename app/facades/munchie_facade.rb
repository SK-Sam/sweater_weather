class MunchieFacade
  class << self
    def get_all_datas_into_munchie_poro(start, fin, food)
      map_data = CityService.get_directions_data(start, fin)
      travel_time_with_traffic = map_data[:route][:realTime]

      destination_city = map_data[:route][:locations].last[:adminArea5] +
      ', ' + map_data[:route][:locations].last[:adminArea3]
      travel_time = map_data[:route][:formattedTime].first(2) + ' hours ' + map_data[:route][:formattedTime][3..4] + ' min'
      lat = map_data[:route][:locations].last[:displayLatLng][:lat]
      lng = map_data[:route][:locations].last[:displayLatLng][:lng]

      filtered_forecast_data = LocationWeatherFacade.filter_forecast_data(lat, lng)

      time_arrival_unix = Time.now.to_i + travel_time_with_traffic

      restaurant_data = YelpFacade.filter_restaurant_data(lat, lng, food, time_arrival_unix)

      munchie = Munchie.new(destination_city, travel_time, filtered_forecast_data, restaurant_data)
    end
  end
end