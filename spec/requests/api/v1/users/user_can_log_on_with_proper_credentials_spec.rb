require 'rails_helper'

describe 'User Log In' do
  it 'can log in and authenticate with proper credentials' do
    user = User.create(email: 'email@email.com', password: 'password')
    headers = {
      'Content_Type': 'application/json'
    }
    body = {
      'email': 'email@email.com',
      'password': 'password'
    }
    post '/api/v1/sessions', headers: headers, params: body
    #require 'pry'; binding.pry
    user = User.first
    expect(response.status).to eq(200)
    
    json_data = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(json_data[:id]).to eq(user.id.to_s)
    expect(json_data[:type]).to eq('users')
    expect(json_data[:attributes]).to be_a(Hash)
    expect(json_data[:attributes][:email]).to eq(user.email)
    expect(json_data[:attributes][:api_key]).to eq(user.api_key)
  end
end