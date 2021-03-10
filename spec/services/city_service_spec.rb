require 'rails_helper'

describe 'MapQuest Geocode API based requests' do
  describe 'happy path' do
    it 'can return lat/long based on city,state' do
      VCR.use_cassette('san_fran_location') do
        city_state_param = 'san%20francisco,ca'

        json_data = CityService.get_location_data(city_state_param)

        expect(json_data).to have_key(:info)
        expect(json_data[:info]).to be_a(Hash)

        expect(json_data).to have_key(:options)
        expect(json_data[:options]).to be_a(Hash)

        expect(json_data).to have_key(:results)
        expect(json_data[:results]).to be_an(Array)

        results_data = json_data[:results].first

        expect(results_data).to be_a(Hash)
        expect(results_data[:providedLocation]).to be_a(Hash)
        expect(results_data[:providedLocation][:location]).to be_a(String)
        expect(results_data[:providedLocation][:location]).to eq('san%20francisco,ca')

        expect(results_data[:locations].first).to have_key(:latLng)
        expect(results_data[:locations].first[:latLng]).to be_a(Hash)
        expect(results_data[:locations].first[:latLng][:lat]).to be_a(Numeric)
        expect(results_data[:locations].first[:latLng][:lat]).to eq(37.78008)
        expect(results_data[:locations].first[:latLng][:lng]).to be_a(Numeric)
        expect(results_data[:locations].first[:latLng][:lng]).to eq(-122.420168)
      end
    end
    it '#get_directions_data' do
      VCR.use_cassette('get_map_data') do
        direction_data = CityService.get_directions_data('denver,co', 'pueblo,co')
  
        expect(direction_data).to be_a(Hash)
        expect(direction_data[:route][:realTime]).to be_a(Numeric)
        expect(direction_data[:route][:locations]).to be_an(Array)
        expect(direction_data[:route][:locations].last).to have_key(:adminArea3)
        expect(direction_data[:route][:locations].last).to have_key(:adminArea5)
        expect(direction_data[:route]).to have_key(:formattedTime)
        expect(direction_data[:route][:locations].last).to have_key(:displayLatLng)
        expect(direction_data[:route][:locations].last[:displayLatLng]).to have_key(:lat)
        expect(direction_data[:route][:locations].last[:displayLatLng]).to have_key(:lng)
      end
    end
  end
  describe 'sad path' do

  end
end