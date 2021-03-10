require 'rails_helper'

describe 'city facade' do
  it '#get_lat_long' do
    VCR.use_cassette('san_fran_location') do
      city_state_param = 'san%20francisco,ca'
      expected_lat_long = { lat: '37.78008', lon: '-122.420168'}

      expect(CityFacade.get_lat_long(city_state_param)).to eq(expected_lat_long)
    end
  end
  it '#filter_direction_data' do
    VCR.use_cassette('directions') do
      start = 'denver,co'
      fin = 'pueblo,co'

      expect(CityFacade.filter_direction_data(start, fin)).to have_key(:travel_time_with_traffic)
      expect(CityFacade.filter_direction_data(start, fin)).to have_key(:travel_time_as_string)
      expect(CityFacade.filter_direction_data(start, fin)).to have_key(:lat)
      expect(CityFacade.filter_direction_data(start, fin)[:lat]).to be_a(Numeric)
      expect(CityFacade.filter_direction_data(start, fin)).to have_key(:lng)
      expect(CityFacade.filter_direction_data(start, fin)[:lng]).to be_a(Numeric)
    end
  end
end