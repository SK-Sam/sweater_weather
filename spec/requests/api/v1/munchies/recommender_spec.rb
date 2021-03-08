require 'rails_helper'

describe 'Recommend based on start/end address and food type' do
  it 'can create JSON data of directions, recommendation, and forecast' do
    VCR.use_cassette('final_map_quest') do
      VCR.use_cassette('final_yelp_fusion') do
        VCR.use_cassette('final_open_weather') do
          get '/api/v1/munchies?start=denver,co&destination=pueblo,co&food=hamburger'
        end
      end
    end
  end
end