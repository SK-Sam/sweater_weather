class Munchie
  attr_reader :destination_city,
              :travel_time,
              :forecast,
              :restaurant

  def initialize(destination_city, travel_time, filtered_forecast_data, restaurant_data)
    @destination_city= destination_city,
    @travel_time= travel_time,
    @forecast= filtered_forecast_data,
    @restaurant= restaurant_data
  end

end