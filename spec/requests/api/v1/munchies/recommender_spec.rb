require 'rails_helper'

describe 'Recommend based on start/end address and food type' do
  it 'can create JSON data of directions, recommendation, and forecast' do
    VCR.use_cassette('final_map_quest') do
      VCR.use_cassette('final_open_weather') do
        VCR.use_cassette('final_yelp_fusion') do
          get '/api/v1/munchies?start=denver,co&destination=pueblo,co&food=hamburger'

          expect(response.status).to eq(200)

          json_response = JSON.parse(response.body, symbolize_names: true)

          expect(json_response).to have_key(:data)

          json_data = json_response[:data]

          expect(json_data).to have_key(:id)
          expect(json_data).to have_key(:type)
          expect(json_data).to have_key(:attributes)

          expect(json_data[:id]).to eq(nil)
          expect(json_data[:type]).to eq("munchie")
          expect(json_data[:attributes]).to be_a(Hash)

          json_attributes = json_data[:attributes]

          expect(json_attributes).to have_key(:destination_city)
          expect(json_attributes).to have_key(:travel_time)
          expect(json_attributes).to have_key(:forecast)
          expect(json_attributes).to have_key(:restaurant)

          json_forecast = json_attributes[:forecast]

          expect(json_forecast).to have_key(:summary)
          expect(json_forecast).to have_key(:temperature)

          json_restaurant = json_attributes[:restaurant]

          expect(json_restaurant).to have_key(:name)
          expect(json_restaurant).to have_key(:address)
        end
      end
    end
  end
end