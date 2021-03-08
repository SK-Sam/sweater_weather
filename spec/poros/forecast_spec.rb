require 'rails_helper'

describe 'Forecast Poro' do
  it 'can take in JSON data and allocate info to specific attributes' do
    fixture_json = File.read('spec/fixtures/san_fran_forecast.json')
    data = JSON.parse(fixture_json, symbolize_names: true)
    current_datas = data[:current]
    daily_datas = data[:daily].first(5)
    hourly_datas = data[:hourly]
    require 'pry'; binding.pry
    forecast_poro = Forecast.new(data)

    current_weather_expectation = {
      datetime: Time.at(current_datas[:dt]),
      sunrise: Time.at(current_datas[:sunrise]),
      sunset: Time.at(current_datas[:sunset]),
      temperature: ((current_datas[:temp] - 273.15) * 9 / 5) + 32,
      feels_like: ((current_datas[:feels_like] - 273.15) * 9 / 5) + 32,
      humidity: current_datas[:humidity],
      uvi: current_datas[:uvi],
      visibility: current_datas[:visibility],
      conditions: current_datas[:weather].first[:description],
      icon: current_datas[:weather].first[:icon]
    }

    daily_weather_expectation = {
      date: Time.at(daily_datas[:dt]).strftime("%F"),
      sunrise: Time.at(daily_datas[:sunrise]),
      sunset: Time.at(daily_datas[:sunset]),
      max_temp: ((daily_datas[:temp][:max] - 273.15) * 9 / 5) + 32,
      mmin_temp: ((daily_datas[:temp][:min] - 273.15) * 9 / 5) + 32,
      conditions: daily_datas[:weather].first[:description],
      icon: daily_datas[:weather].first[:icon]
    }

    hourly_weather_expectation = {
      time: Time.at(hourly_datas[:dt]).strftime("%T"),
      temperature: ((hourly_datas[:temp] - 273.15) * 9 / 5) + 32,
      conditions: hourly_datas[:weather].first[:description],
      icon: hourly_datas[:weather].first[:icon]
    }

    expect(forecast_poro.current_weather).to eq(current_weather_expectation)
    expect(forecast_poro.daily_weather.count).to eq(5)
    expect(forecast_poro.daily_weather.first).to eq(daily_weather_expectation)
    expect(forecast_poro.hourly_weather.count).to eq(8)
    expect(forecast_poro.hourly_weather.first).to eq(hourly_weather_expectation)
  end
end