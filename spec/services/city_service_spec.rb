require 'rails_helper'

describe 'MapQuest Geocode API based requests' do
  describe 'happy path' do
    it 'can return lat/long based on city,state' do
      VCR.use_cassette('san_fran_location') do
        city_state_param = 'san%20francisco,ca'

        json_data = CityService.get_location_data(city_state_param)

        expect(json_data).to have_key(:info)
        expect(json_data[:data]).to be_a(Hash)

        expect(json_data).to have_key(:options)
        expect(json_data[:data]).to be_a(Hash)

        expect(json_data).to have_key(:results)
        expect(json_data[:data]).to be_an(Array)

        results_data = json_data[:results].first

        expect(results_data).to be_a(Hash)
        expect(results_data[:providedLocation]).to be_a(Hash)
        expect(results_data[:providedLocation[:location]]).to be_a(String)
        expect(results_data[:providedLocation[:location]]).to eq('san francisco,ca')

        expect(results_data[:locations]).to have_key(:latLng)
        expect(results_data[:locations][:latLng]).to be_a(Hash)
        expect(results_data[:locations][:latLng][:lat]).to be_a(String)
        expect(results_data[:locations][:latLng][:lat]).to eq('37.78008')
        expect(results_data[:locations][:latLng][:lng]).to be_a('-122.420168')
      end
    end
  end
  describe 'sad path' do

  end
end