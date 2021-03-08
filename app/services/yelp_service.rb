class YelpService
  class << self

    def get_restaurant_data(lat, lng, food_category, arrival_time_unix)
      response = conn.get('v3/businesses/search') do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = "Bearer #{ENV['yelp_api_key']}"
        req.params['latitude'] = lat
        req.params['longitude'] = lng
        req.params['categories'] = food_category
        req.params['open_at'] = arrival_time_unix
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def conn
      @conn ||= Faraday.new(
        url: 'https://api.yelp.com',
        headers: { 'Content-Type': 'application/json' }
      )
    end
  end
end