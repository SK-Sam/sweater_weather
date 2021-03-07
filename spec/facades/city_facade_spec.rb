require 'rails_helper'

describe 'city facade' do
  it '#get_lat_long' do
    VCR.use_cassette('san_fran_location') do
      city_state_param = 'san%20francisco,ca'
      expected_lat_long = { lat: '37.78008', lon: '-122.420168'}

      expect(CityFacade.get_lat_long(city_state_param)).to eq(expected_lat_long)
    end
  end
end