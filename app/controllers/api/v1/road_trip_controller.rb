class Api::V1::RoadTripController < ApplicationController
  def create
    if User.exists?(api_key: params[:api_key])
      roadtrip = RoadTripFacade.create_roadtrip_based_on_time(params[:origin], params[:destination])
      render json: RoadtripSerializer.new(roadtrip)
    else
      render json: { errors: "Missing or incorrect API key." }, status: 401
    end
  end
end