require 'rails_helper'

describe 'city_weather' do
  describe 'happy path' do
    it 'can receive a get req and return JSON payload of current, daily, and hourly weather based on city' do
      VCR.use_cassette('san_fran_location') do
        VCR.use_cassette('san_fran_forecast') do
          get '/api/v1/forecast?location=san%20francisco,ca'

          expect(response.status).to eq(200)

          json_data = JSON.parse(response.body, symbolize_names: true)

          expect(json_data).to have_key(:data)
          expect(json_data[:data]).to be_a(Hash)

          data_body = json_data[:data]

          expect(data_body).to have_key(:id)
          expect(data_body[:id]).to eq(nil)
          expect(data_body).to have_key(:type)
          expect(data_body[:type]).to eq('forecast')
          expect(data_body).to have_key(:attributes)
          expect(data_body[:attributes]).to be_a(Hash)
        end
      end
    end
  end
  describe 'sad path' do

  end
end