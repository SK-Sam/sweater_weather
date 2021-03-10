class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user
      session[:user_id] = user.id
      render json: UsersSerializer.new(user), status: :created
    else
      render json: { status: 400 }
    end
  end

end