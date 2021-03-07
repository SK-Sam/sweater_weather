require 'rails_helper'

describe 'OpenWeather One Call API based requests' do
  describe 'happy path' do
    it 'can return current weather data based on lat/long' do
      VCR.use_cassette('san_fran_forecast') do
        sf_lat_param = '37.78008'
        sf_long_param = '-122.420168'

        json_data = LocationWeatherService.get_weather_data(sf_lat_param, sf_long_param)

        expect(json_data).to have_key(:current)
        expect(json_data[:current]).to be_a(Hash)

        current_data = json_data[:current]

        expect(current_data).to have_key(:dt)
        expect(current_data[:dt]).to be_a(Numeric)

        expect(current_data).to have_key(:sunrise)
        expect(current_data[:sunrise]).to be_a(Numeric)

        expect(current_data).to have_key(:sunset)
        expect(current_data[:sunset]).to be_a(Numeric)

        expect(current_data).to have_key(:temp)
        expect(current_data[:temp]).to be_a(Numeric)

        expect(current_data).to have_key(:feels_like)
        expect(current_data[:feels_like]).to be_a(Numeric)

        expect(current_data).to have_key(:humidity)
        expect(current_data[:humidity]).to be_a(Numeric)

        expect(current_data).to have_key(:uvi)
        expect(current_data[:uvi]).to be_a(Numeric)

        expect(current_data).to have_key(:visibility)
        expect(current_data[:visibility]).to be_a(Numeric)

        expect(current_data).to have_key(:weather)
        expect(current_data[:weather]).to be_an(Array)

        current_weather_data = current_data[:weather].first

        expect(current_weather_data).to have_key(:description)
        expect(current_weather_data[:description]).to be_a(String)

        expect(current_weather_data).to have_key(:icon)
        expect(current_weather_data[:icon]).to be_a(String)
      end
    end
    it 'can return hourly weather data and next 8 hrs of data based on lat/long' do
      VCR.use_cassette('san_fran_forecast') do
        sf_lat_param = '37.78008'
        sf_long_param = '-122.420168'

        json_data = LocationWeatherService.get_weather_data(sf_lat_param, sf_long_param)

        hourly_data = json_data[:hourly]
        
        expect(hourly_data).to be_an(Array)
        hourly_data.count.should be >= 8

        first_hourly_data = hourly_data.first

        expect(first_hourly_data).to be_a(Hash)

        expect(first_hourly_data).to have_key(:dt)
        expect(first_hourly_data[:dt]).to be_a(Numeric)

        expect(first_hourly_data).to have_key(:temp)
        expect(first_hourly_data[:temp]).to be_a(Numeric)

        expect(first_hourly_data).to have_key(:weather)
        expect(first_hourly_data[:weather]).to be_an(Array)

        hourly_weather_data = first_hourly_data[:weather].first

        expect(hourly_weather_data).to have_key(:description)
        expect(hourly_weather_data[:description]).to be_a(String)

        expect(hourly_weather_data).to have_key(:icon)
        expect(hourly_weather_data[:icon]).to be_a(String)
      end
    end
    it 'can return daily weather data and at least next 5 days of data based on lat/long' do
      VCR.use_cassette('san_fran_forecast') do
        sf_lat_param = '37.78008'
        sf_long_param = '-122.420168'

        json_data = LocationWeatherService.get_weather_data(sf_lat_param, sf_long_param)

        daily_data = json_data[:daily]
        
        expect(daily_data).to be_an(Array)
        daily_data.count.should be >= 5

        first_daily_data = daily_data.first

        expect(first_daily_data).to be_a(Hash)

        expect(first_daily_data).to have_key(:dt)
        expect(first_daily_data[:dt]).to be_a(Numeric)

        expect(first_daily_data).to have_key(:sunrise)
        expect(first_daily_data[:sunrise]).to be_a(Numeric)

        expect(first_daily_data).to have_key(:sunset)
        expect(first_daily_data[:sunset]).to be_a(Numeric)

        expect(first_daily_data).to have_key(:temp)
        expect(first_daily_data[:temp]).to be_a(Hash)

        expect(first_daily_data[:temp]).to have_key(:min)
        expect(first_daily_data[:temp][:min]).to be_a(Numeric)

        expect(first_daily_data[:temp]).to have_key(:max)
        expect(first_daily_data[:temp][:max]).to be_a(Numeric)

        expect(first_daily_data).to have_key(:weather)
        expect(first_daily_data[:weather]).to be_an(Array)

        daily_weather_data = first_daily_data[:weather].first

        expect(daily_weather_data).to have_key(:description)
        expect(daily_weather_data[:description]).to be_a(String)

        expect(daily_weather_data).to have_key(:icon)
        expect(daily_weather_data[:icon]).to be_a(String)
      end
    end
  end
  describe 'sad path' do

  end
end