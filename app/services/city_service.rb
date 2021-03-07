class CityService
  class << self
  
    def get_location_data(city_state)
      response = conn.get('address') do |req|
        req.params[:location] = city_state
        req.params[:key] = ENV['map_api_key']
      end

      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def conn
      @conn ||= Faraday.new(
        url: 'http://www.mapquestapi.com/geocoding/v1',
        headers: { 'Content-Type': 'application/json' }
      )
    end
  end
end
