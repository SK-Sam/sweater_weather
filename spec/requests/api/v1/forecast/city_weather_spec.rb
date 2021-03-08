require 'rails_helper'

describe 'city_weather' do
  describe 'happy path' do
    it 'can receive a get req and return JSON payload of current, daily, and hourly weather based on city' do
      VCR.use_cassette('san_fran_location') do
        VCR.use_cassette('san_fran_forecast') do
          expected_payload = JSON.parse(File.read('spec/fixtures/processed_san_fran_forecast.json'), symbolize_names: true)[:data][:attributes]
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
          
          expect(data_body[:attributes][:current_weather]).to be_a(Hash)
          expect(data_body[:attributes][:daily_weather]).to be_an(Array)
          expect(data_body[:attributes][:daily_weather].count).to eq(5)
          expect(data_body[:attributes][:hourly_weather]).to be_an(Array)
          expect(data_body[:attributes][:hourly_weather].count).to eq(8)


          current_weather = data_body[:attributes][:current_weather]
          daily_weather = data_body[:attributes][:daily_weather].first
          hourly_weather = data_body[:attributes][:hourly_weather].first

          expect(current_weather).to have_key(:datetime)
          expect(current_weather).to have_key(:sunrise)
          expect(current_weather).to have_key(:sunset)
          expect(current_weather).to have_key(:temperature)
          expect(current_weather).to have_key(:feels_like)
          expect(current_weather).to have_key(:humidity)
          expect(current_weather).to have_key(:uvi)
          expect(current_weather).to have_key(:visibility)
          expect(current_weather).to have_key(:conditions)
          expect(current_weather).to have_key(:icon)

          expect(current_weather).not_to have_key(:pressure)
          expect(current_weather).not_to have_key(:dew_point)
          expect(current_weather).not_to have_key(:clouds)
          expect(current_weather).not_to have_key(:wind_speed)
          expect(current_weather).not_to have_key(:wind_deg)

          expect(current_weather[:datetime]).to eq(expected_payload[:current_weather][:datetime])
          expect(current_weather[:sunrise]).to eq(expected_payload[:current_weather][:sunrise])
          expect(current_weather[:sunset]).to eq(expected_payload[:current_weather][:sunset])
          expect(current_weather[:temperature]).to eq(expected_payload[:current_weather][:temperature])
          expect(current_weather[:feels_like]).to eq(expected_payload[:current_weather][:feels_like])
          expect(current_weather[:humidity]).to eq(expected_payload[:current_weather][:humidity])
          expect(current_weather[:uvi]).to eq(expected_payload[:current_weather][:uvi])
          expect(current_weather[:visibility]).to eq(expected_payload[:current_weather][:visibility])
          expect(current_weather[:conditions]).to eq(expected_payload[:current_weather][:conditions])
          expect(current_weather[:icon]).to eq(expected_payload[:current_weather][:icon])

          expect(daily_weather).to have_key(:date)
          expect(daily_weather).to have_key(:sunrise)
          expect(daily_weather).to have_key(:sunset)
          expect(daily_weather).to have_key(:max_temp)
          expect(daily_weather).to have_key(:min_temp)
          expect(daily_weather).to have_key(:conditions)
          expect(daily_weather).to have_key(:icon)

          expect(daily_weather).not_to have_key(:pressure)
          expect(daily_weather).not_to have_key(:dew_point)
          expect(daily_weather).not_to have_key(:clouds)
          expect(daily_weather).not_to have_key(:wind_speed)
          expect(daily_weather).not_to have_key(:wind_deg)

          expect(hourly_weather).to have_key(:time)
          expect(hourly_weather).to have_key(:temperature)
          expect(hourly_weather).to have_key(:conditions)
          expect(hourly_weather).to have_key(:icon)

          expect(hourly_weather).not_to have_key(:pressure)
          expect(hourly_weather).not_to have_key(:dew_point)
          expect(hourly_weather).not_to have_key(:clouds)
          expect(hourly_weather).not_to have_key(:wind_speed)
          expect(hourly_weather).not_to have_key(:wind_deg)
        end
      end
    end
  end
  describe 'sad path' do

  end
end