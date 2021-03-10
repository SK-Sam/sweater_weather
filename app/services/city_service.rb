class CityService
  class << self
  
    def get_location_data(city_state)
      response = conn.get('geocoding/v1/address') do |req|
        req.params[:location] = city_state
        req.params[:key] = ENV['map_api_key']
      end

      JSON.parse(response.body, symbolize_names: true)
    end

    def get_directions_data(start, fin)
      response = conn.get('directions/v2/route') do |req|
        req.params['key'] = ENV['map_api_key']
        req.params['from'] = start
        req.params['to'] = fin
      end
      JSON.parse(response.body, symbolize_names: true) 
    end

    private

    def conn
      @conn ||= Faraday.new(
        url: 'http://www.mapquestapi.com',
        headers: { 'Content-Type': 'application/json' }
      )
    end
  end
end
