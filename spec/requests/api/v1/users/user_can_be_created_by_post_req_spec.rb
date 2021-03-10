require 'rails_helper'

describe 'User Create Request' do
  it 'can create user through JSON body request' do
    headers = {
      'Content_Type': 'application/json'
    }
    body = {
      'email': 'email@email.com',
      'password': 'password',
      'password_confirmation': 'password'
    }
    post '/api/v1/users', headers: headers, params: body
    user = User.first

    expect(response.status).to eq(201)
    
    json_body = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(json_body[:id]).to eq(user.id.to_s)
    expect(json_body[:type]).to eq('users')
    expect(json_body[:attributes]).to be_a(Hash)
    expect(json_body[:attributes][:email]).to eq(user.email)
    expect(json_body[:attributes][:api_key]).to eq(user.api_key)
  end
end