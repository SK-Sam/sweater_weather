require 'rails_helper'

describe 'User Create Request' do
  it 'can create user through JSON body request' do
    post '/api/v1/users'
    user = User.first

    expect(response.status).to eq(201)
    
    json_body = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(json_body[:id]).to eq(user.id)
    expect(json_body[:type]).to eq('users')
    expect(json_body[:attributes]).to be_a(Hash)
    expect(json_body[:attributes[:email]]).to eq(user.email)
    expect(json_body[:attributes][:api_key]).to eq(user.api_key)
  end
end