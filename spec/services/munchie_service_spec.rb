require 'rails_helper'

describe 'Munchie Service' do
  it '#get_directions_data' do
    VCR.use_cassette('get_map_data') do
      direction_data = MunchieService.get_directions_data

      expect(direction_data).to be_a(Hash)
      expect(direction_data[:route][:realtime]).to be_a(Numeric)
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