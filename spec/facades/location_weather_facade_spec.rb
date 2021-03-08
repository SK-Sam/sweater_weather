require 'rails_helper'

describe 'LocationWeatherFacade' do
  it '#filter_forecast_data' do
    VCR.use_cassette('final_forecast_fixture') do
      weather_data = LocationWeatherFacade.filter_forecast_data('38.265427', '-104.605087')
      
      expect(weather_data[:summary]).to be_a(String)
      expect(weather_data[:temperature]).to be_a(Float)
    end
  end
end