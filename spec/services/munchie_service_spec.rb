require 'rails_helper'

describe 'Munchie Service' do
  it '#get_directions_data' do
    VCR.use_cassette('get_map_data') do
      expect(MunchieService.get_directions_data)
    end
  end
end