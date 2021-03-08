class YelpFacade
  class << self
    def filter_restaurant_data(lat, lng, food_category, time_arrival_unix)
      yelp_data = YelpService.get_restaurant_data(lat, lng, food_category, time_arrival_unix)
      restaurant = {
        name: yelp_data[:businesses].first[:name],
        address: yelp_data[:businesses].first[:location][:address1] + ' ' +
          yelp_data[:businesses].first[:location][:address2] + ', ' +
          yelp_data[:businesses].first[:location][:city] + ' ' +
          yelp_data[:businesses].first[:location][:state] + ' ' +
          yelp_data[:businesses].first[:location][:zip_code]
      }
    end
  end
end