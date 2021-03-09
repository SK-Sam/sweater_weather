class BackgroundService
  class << self
    def get_image(city_state)
      response = conn.get('search/photos') do |req|
        req.headers['Authorization'] = "Client-ID #{ENV['picture_api_key']}"
        req.params['query'] = city_state
        req.params['page'] = 1
        req.params['per_page'] = 1
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def conn
      @conn ||= Faraday.new(
        url: 'https://api.unsplash.com',
        headers: { 'Content-Type': 'application/json' }
      )
    end
  end
end