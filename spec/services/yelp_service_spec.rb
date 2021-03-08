it '#get_directions_data' do
  VCR.use_cassette('get_yelp_data') do
    yelp_data = YelpService.get_restaurant_data(lat, lng, food_category)

    expect(yelp_data[:businesses].first[:name]).to be_a(String)
    expect(yelp_data[:businesses].first[:location][:address1]).to be_a(String)
    expect(yelp_data[:businesses].first[:location][:address2]).to be_a(String)
    expect(yelp_data[:businesses].first[:location][:city]).to be_a(String)
    expect(yelp_data[:businesses].first[:location][:state]).to be_a(String)
    expect(yelp_data[:businesses].first[:location][:zip_code]).to be_a(String)
  end
end