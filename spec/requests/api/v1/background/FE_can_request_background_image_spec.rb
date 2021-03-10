require 'rails_helper'

describe 'City Image' do
  it 'can request for a background image' do
    VCR.use_cassette('background-image') do
      get '/api/v1/backgrounds?location=denver,co'

      expect(response.status).to eq(200)

      json_body = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(json_body).to have_key(:type)
      expect(json_body[:type]).to be_a(String)
      expect(json_body).to have_key(:id)
      expect(json_body).to have_key(:attributes)
      expect(json_body[:attributes]).to be_a(Hash)

      json_attributes = json_body[:attributes]
      
      expect(json_attributes).to have_key(:image)
      expect(json_attributes).to have_key(:credit)

      expect(json_attributes[:image][:location]).to be_a(String)
      expect(json_attributes[:image][:image_url]).to be_a(String)

      expect(json_attributes[:credit][:source]).to be_a(String)
      expect(json_attributes[:credit][:author_username]).to be_a(String)
      expect(json_attributes[:credit][:author_name]).to be_a(String)
      expect(json_attributes[:credit][:author_profile]).to be_a(String)
    end
  end
end