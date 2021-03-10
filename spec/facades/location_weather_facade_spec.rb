require 'rails_helper'

describe 'LocationWeatherFacade' do
  it 'can filter forecast data hourly' do
    VCR.use_cassette('weather-service') do
      lat = 37.7801
      lon = -122.4202
      hour = 1
      filtered_hourly_data = LocationWeatherFacade.filter_forecast_data_hourly(lat, lon, hour)

      expect(filtered_hourly_data[:conditions]).to be_a(String)
      expect(filtered_hourly_data[:temperature]).to be_a(Float)
    end
  end
end