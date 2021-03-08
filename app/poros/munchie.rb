class Munchie
  attr_reader :destination_city,
              :travel_time,
              :filtered_forecast_data,
              :restaurant_data
              
  def initialize(destination_city, travel_time, filtered_forecast_data, restaurant_data)
    destination_city: destination_city,
    travel_time: travel_time
    filtered_forecast_data: filtered_forecast_data,
    restaurant_data: restaurant_data
  end
end