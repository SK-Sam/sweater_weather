class RoadTripFacade
  class << self

    def create_roadtrip_based_on_time(start, fin)
      filtered_directions_data = CityFacade.filter_direction_data(start, fin)
      trip_length = filtered_directions_data[:travel_time_with_traffic] if filtered_directions_data.is_a? Hash
      if filtered_directions_data == "Impossible"
        roadtrip = RoadTripFacade.create_impossible_roadtrip(start, fin)
      elsif trip_length == 10000000
        roadtrip = RoadTripFacade.create_roadtrip_roadblocks(start, fin, trip_length)
      elsif TimeHelper.within_8_hours(trip_length)
        roadtrip = RoadTripFacade.create_roadtrip_within_8_hours(start, fin, filtered_directions_data)
      elsif TimeHelper.within_5_days(trip_length)
        roadtrip = RoadTripFacade.create_roadtrip_within_5_days(start, fin, filtered_directions_data)
      else
        roadtrip = RoadTripFacade.create_roadtrip_past_5_days(start, fin, trip_time)
      end
    end

    def create_impossible_roadtrip(start, fin)
      Roadtrip.new(start, fin, "Impossible", "")
    end

    def create_roadtrip_roadblocks(start, fin, trip_length)
      Roadtrip.new(start, fin, trip_length, "Major roads blocked")
    end

    def create_roadtrip_within_8_hours(start, fin, directions_data)
      Roadtrip.new(
        start, 
        fin,
        directions_data[:travel_time_as_string],
        LocationWeatherFacade.filter_forecast_data_hourly(
          directions_data[:lat], 
          directions_data[:lng],
          TimeHelper.convert_trip_time_to_hours(directions_data[:travel_time_with_traffic])
        )
      )
    end
    
    def create_roadtrip_within_5_days(start, fin, directions_data)
      Roadtrip.new(
        start, 
        fin,
        directions_data[:travel_time_as_string],
        LocationWeatherFacade.filter_forecast_data_daily(
          directions_data[:lat], 
          directions_data[:lng],
          TimeHelper.convert_trip_time_to_days(directions_data[:travel_time_with_traffic])
        )
      )
    end

    def create_roadtrip_past_5_days(start, fin, trip_time)
      Roadtrip.new(
        start, 
        fin, 
        trip_time, 
        "Can't get data after 5 days."
      )
    end
  end
end