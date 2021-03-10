module TimeHelper
  @@one_hour = 3600
  @@one_day = 86400
  @@eight_hours = 28800
  @@five_days = 432000

  class << self
    def within_8_hours(trip_time)
      trip_time < @@eight_hours
    end

    def within_5_days(trip_time)
      trip_time < @@five_days
    end

    def convert_trip_time_to_hours(trip_time)
      trip_time / @@one_hour
    end

    def convert_trip_time_to_days(trip_time)
      trip_time / @@one_day
    end
  end
end