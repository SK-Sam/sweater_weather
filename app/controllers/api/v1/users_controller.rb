class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user.save
      session[:user_id] = user.id
      render json: UsersSerializer.new(user), status: :created
    else
      render json: { errors: "Please try again. Issue with creating your account." }, status: 400
    end
  end

end