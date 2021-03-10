require 'rails_helper'

describe 'RoadTripFacade' do
  it '#create_impossible_roadtrip' do
    roadtrip = RoadTripFacade.create_impossible_roadtrip('start', 'fin')

    expect(roadtrip.start_city).to eq('start')
    expect(roadtrip.end_city).to eq('fin')
    expect(roadtrip.travel_time).to eq('Impossible')
    expect(roadtrip.weather_at_eta).to eq('')
  end
end