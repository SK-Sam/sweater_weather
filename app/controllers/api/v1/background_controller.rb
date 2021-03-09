class Api::V1::BackgroundController < ApplicationController
  def city_image
    location_data = BackgroundService.get_image(params[:location])
    filtered_image_data = Image.new(location_data, params[:location])
    render json: ImageSerializer.new(filtered_image_data)
  end
end