class CityFacade
  class << self
    def get_lat_long(city_state)
      location_data = CityService.get_location_data(city_state)[:results].first[:locations].first
      { 
        lat: location_data[:latLng][:lat].to_s,
        lon: location_data[:latLng][:lng].to_s
      }
    end
    
    def filter_direction_data(start, fin)
      map_data = CityService.get_directions_data(start, fin)
      travel_time_with_traffic = map_data[:route][:realTime]
  
      destination_city = map_data[:route][:locations].last[:adminArea5] +
      ', ' + map_data[:route][:locations].last[:adminArea3]
      travel_time = map_data[:route][:formattedTime].first(2) + ' hours ' + map_data[:route][:formattedTime][3..4] + ' min'
      lat = map_data[:route][:locations].last[:displayLatLng][:lat]
      lng = map_data[:route][:locations].last[:displayLatLng][:lng]
    end
  end
end