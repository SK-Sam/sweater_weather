require 'rails_helper'

describe 'Image Poro for background image' do
  it 'can initialize with proper attributes based on data passing in' do
    VCR.use_cassette('get_san_fran_unsplash_image') do
      location_param = 'san francisco,ca'
      data = BackgroundService.get_image(location_param)

      image_poro = Image.new(data, 'san francisco,ca')

      expect(image_poro.image).to be_a(Hash)
      expect(image_poro.image[:location]).to be_a(String)
      expect(image_poro.image[:image_url]).to be_a(String)

      expect(image_poro.credit).to be_a(Hash)
      expect(image_poro.credit[:source]).to be_a(String)
      expect(image_poro.credit[:author_username]).to be_a(String)
      expect(image_poro.credit[:author_name]).to be_a(String)
      expect(image_poro.credit[:author_profile]).to be_a(String)
    end
  end
end