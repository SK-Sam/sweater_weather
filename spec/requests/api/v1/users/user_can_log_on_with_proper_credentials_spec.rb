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
describe 'Sad path' do
  it 'can send a 400 level error if bad credentials' do
    user = User.create(email: 'email@hotmail.com', password: 'password')
    headers = {
      'Content_Type': 'application/json'
    }
    body = {
      'email': 'email@email.com',
      'password': 'password'
    }
    post '/api/v1/sessions', headers: headers, params: body

    expect(response.status).to eq(401)
    json_data = JSON.parse(response.body, symbolize_names: true)

    expect(json_data[:errors]).to eq("Email or password combination did not work. Please try again.") 
  end
end