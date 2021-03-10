require 'rails_helper'

describe 'Create action' do
  it 'can send start and end city and receive roadtrip info' do
    VCR.use_cassette('location') do
      VCR.use_cassette('weather') do
        user = User.create(email: 'email@email.com', password: 'password')
        headers = {
          'Content_Type': 'application/json'
        }
        body = {
          "origin": "madison,wi",
          "destination": "denver,co",
          "api_key": "#{user.api_key}"
      }
        post '/api/v1/road_trip', headers: headers, params: body

        expect(response.status).to eq(200)

        json_data = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(json_data[:attributes][:start_city]).to eq('madison,wi')
        expect(json_data[:attributes][:end_city]).to eq('denver,co')
        expect(json_data[:attributes][:travel_time]).to be_a(String)
        expect(json_data[:attributes][:weather_at_eta][:conditions]).to be_a(String)
        expect(json_data[:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      end
    end
  end
  it 'can invalidate someone who has an incorrect API key' do
    user = User.create(email: 'email@email.com', password: 'password')
        headers = {
          'Content_Type': 'application/json'
        }
        body = {
          "origin": "madison,wi",
          "destination": "denver,co",
          "api_key": "f"
      }
        post '/api/v1/road_trip', headers: headers, params: body

        expect(response.status).to eq(401)

        json_data = JSON.parse(response.body, symbolize_names: true)

        expect(json_data[:errors]).to be_a(String)
  end
end