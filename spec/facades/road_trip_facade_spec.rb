require 'rails_helper'

describe 'RoadTripFacade' do
  it '#create_impossible_roadtrip' do
    roadtrip = RoadTripFacade.create_impossible_roadtrip('start', 'fin')

    expect(roadtrip.start_city).to eq('start')
    expect(roadtrip.end_city).to eq('fin')
    expect(roadtrip.travel_time).to eq('Impossible')
    expect(roadtrip.weather_at_eta).to eq('')
  end
  it '#create_roadtrip_roadblocks' do
    roadtrip = RoadTripFacade.create_roadtrip_roadblocks('start', 'fin', '4 hours 10 minutes')

    expect(roadtrip.start_city).to eq('start')
    expect(roadtrip.end_city).to eq('fin')
    expect(roadtrip.travel_time).to eq('4 hours 10 minutes')
    expect(roadtrip.weather_at_eta).to eq('Major roads blocked')
  end
  it '#create_roadtrip_within_8_hours' do
    VCR.use_cassette('8_hr_trip') do
      directions_data = {
        travel_time_with_traffic: 500, 
        travel_time_as_string: "4 hours 10 minutes", 
        lat: 39.738453, 
        lng: -104.984856
      }
      roadtrip = RoadTripFacade.create_roadtrip_within_8_hours('start', 'fin', directions_data)

      expect(roadtrip.start_city).to eq('start')
      expect(roadtrip.end_city).to eq('fin')
      expect(roadtrip.travel_time).to eq('4 hours 10 minutes')
      expect(roadtrip.weather_at_eta[:conditions]).to be_a(String)
      expect(roadtrip.weather_at_eta[:temperature]).to be_a(Float)
    end
  end
  it '#create_roadtrip_within_5_days' do
    VCR.use_cassette('5_day_trip') do
      directions_data = {
        travel_time_with_traffic: 200000, 
        travel_time_as_string: "25 hours 20 mins", 
        lat: 39.738453, 
        lng: -104.984856
      }
      roadtrip = RoadTripFacade.create_roadtrip_within_5_days('start', 'fin', directions_data)

      expect(roadtrip.start_city).to eq('start')
      expect(roadtrip.end_city).to eq('fin')
      expect(roadtrip.travel_time).to eq('25 hours 20 mins')
      expect(roadtrip.weather_at_eta[:conditions]).to be_a(String)
      expect(roadtrip.weather_at_eta[:temperature]).to be_a(Float)
    end
  end
  it '#create_roadtrip_past_5_days' do
    roadtrip = RoadTripFacade.create_roadtrip_past_5_days('start', 'fin', '80 hours 30 mins')

    expect(roadtrip.start_city).to eq('start')
    expect(roadtrip.end_city).to eq('fin')
    expect(roadtrip.travel_time).to eq('80 hours 30 mins')
    expect(roadtrip.weather_at_eta).to eq("Can't get data after 5 days.")
  end
  it '#create_roadtrip_based_on_time' do
    VCR.use_cassette('la-to-sd') do
      expect(RoadTripFacade.create_roadtrip_based_on_time('los angeles,ca', 'san diego,ca')).to be_a(Roadtrip)
    end
    VCR.use_cassette('impossible') do
      expect(RoadTripFacade.create_roadtrip_based_on_time('los angeles,ca', 'london,uk')).to be_a(Roadtrip)
    end
    VCR.use_cassette('roadblock') do
      expect(RoadTripFacade.create_roadtrip_based_on_time('los angeles,ca', 'new york,ny')).to be_a(Roadtrip)
    end
    VCR.use_cassette('within-5') do
      expect(RoadTripFacade.create_roadtrip_based_on_time('lmadison,wi', 'denver,co')).to be_a(Roadtrip)
    end
  end
end