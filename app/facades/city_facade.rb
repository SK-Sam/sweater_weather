class CityFacade
  class << self
    def get_lat_long(city_state)
      location_data = CityService.get_location_data(city_state)[:results].first[:locations].first
      { 
        lat: location_data[:latLng][:lat].to_s,
        lon: location_data[:latLng][:lng].to_s
      }
    end
  end
end