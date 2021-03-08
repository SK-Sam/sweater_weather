require 'rails_helper'

describe 'MunchieFacade' do
  it '#get_all_datas_into_munchie_poro' do
    munchie = MunchieFacade.get_all_datas_into_munchie_poro

    expect(munchie.destination_city).to be_a(String)
    expect(munchie.travel_time).to be_a(String)
    expect(munchie.forecast).to be_a(Hash)
    expect(munchie.forecast[:summary]).to be_a(String)
    expect(munchie.forecast[:temperature]).to be_a(Float)
    expect(munchie.restaurant).to be_a(Hash)
    expect(munchie.restaurant[:name]).to be_a(String)
    expect(munchie.restaurant[:address]).to be_a(String)
  end
end