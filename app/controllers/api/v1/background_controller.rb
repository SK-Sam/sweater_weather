class Api::V1::BackgroundController < ApplicationController
  def city_image
    if params[:location]
      location_data = BackgroundService.get_image(params[:location])
      filtered_image_data = Image.new(location_data, params[:location])
      render json: ImageSerializer.new(filtered_image_data)
    else
      render json: { errors: "Location invalid. Please put in a valid location." }, status: 400
    end
  end
end