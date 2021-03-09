require 'rails_helper'

describe 'Unsplash Image API based requests' do
  describe 'happy path' do
    it 'can return image based on lat/long' do
      VCR.use_cassette('get_san_fran_unsplash_image') do
        city_state_param = 'san francisco,ca'
        json_data = BackgroundService.get_image(city_state_param)

        expect(json_data).to have_key(:results)
        expect(json_data[:results]).to be_an(Array)

        first_result = json_data[:results].first

        expect(first_result).to be_a(Hash)
        expect(first_result).to have_key(:urls)
        expect(first_result[:urls]).to have_key(:full)
        expect(first_result[:urls]).to have_key(:raw)
        expect(first_result[:urls][:full]).to be_a(String)
        expect(first_result[:urls][:raw]).to be_a(String)
        expect(first_result).to have_key(:links)
        expect(first_result[:links]).to have_key(:html)
        expect(first_result).to have_key(:user)
        expect(first_result[:user]).to have_key(:name)
        expect(first_result[:user]).to have_key(:username)
        expect(first_result[:user]).to have_key(:links)
        expect(first_result[:user][:links]).to have_key(:html)
      end
    end
  end
end