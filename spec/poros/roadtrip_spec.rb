require 'rails_helper'

describe 'Roadtrip Poro' do
  it 'can initialize with proper data' do
    roadtrip = Roadtrip.new(
      'denver,co', 
      'madison,wi', 
      '1hr and 10 minutes', 
      {conditions: 'rain and snow', temperature: 34.7}
    )

    expect(roadtrip.start_city).to eq('denver,co')
    expect(roadtrip.end_city).to eq('madison,wi')
    expect(roadtrip.travel_time).to eq('1hr and 10 minutes')
    expect(roadtrip.weather_at_eta).to eq({ conditions: 'rain and snow', temperature: 34.7})
  end
end