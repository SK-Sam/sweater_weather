require 'rails_helper'

describe 'YelpFacade' do
  it '#filter_restaurant_data' do
    VCR.use_cassette('final_yelp_fixture') do
      restaurant_data = YelpFacade.filter_restaurant_data('38.265427', '-104.605087', 'hamburger', 1615231953)
      
      expect(restaurant_data[:name]).to be_a(String)
      expect(restaurant_data[:address]).to be_a(String)
    end
  end
end