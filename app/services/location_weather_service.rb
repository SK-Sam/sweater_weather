class LocationWeatherService
  class << self

    def get_weather_data(lat, lon)
      response = conn.get('data/2.5/onecall') do |req|
        req.params[:lat] = lat
        req.params[:lon] = lon
        req.params[:exclude] = 'minutely'
        req.params[:appid] = ENV['weather_api_key']
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def conn
      @conn ||= Faraday.new(
        url: 'https://api.openweathermap.org',
        headers: { 'Content-Type': 'application/json' }
      )
    end
  end
end