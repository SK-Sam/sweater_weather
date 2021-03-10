require 'rails_helper'

describe 'Time Helper Module' do
  it '#within_8_hrs' do
    expect(TimeHelper.within_8_hours(20)).to eq(true)
    expect(TimeHelper.within_8_hours(28801)).to eq(false)
  end
  it '#within_5_days' do
    expect(TimeHelper.within_5_days(20)).to eq(true)
    expect(TimeHelper.within_5_days(432001)).to eq(false)
  end
  it '#convert_trip_time_to_hours' do
    expect(TimeHelper.convert_trip_time_to_hours(3600)).to eq(1)
    expect(TimeHelper.convert_trip_time_to_hours(7200)).to eq(2)
  end
  it '#convert_trip_time_to_days' do
    expect(TimeHelper.convert_trip_time_to_days(1)).to eq(0)
    expect(TimeHelper.convert_trip_time_to_days(86400)).to eq(1)
    expect(TimeHelper.convert_trip_time_to_days(172800)).to eq(2)
  end
end