require 'rails_helper'

describe 'Image Poro for background image' do
  it 'can initialize with proper attributes based on data passing in' do
    data = 

    image_poro = Image.new(data)

    expect(image_poro.image).to be_a(Hash)
    expect(image_poro.image[:location]).to be_a(String)
    expect(image_poro.image[:image_url]).to be_a(String)

    expect(image_poro.credit).to be_a(Hash)
    expect(image_poro.credit[:source]).to be_a(String)
    expect(image_poro.credit[:author]).to be_a(String)
  end
end