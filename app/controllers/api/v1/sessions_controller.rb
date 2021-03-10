class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if user
      session[:user_id] = user.id
      render json: UsersSerializer.new(user)
    else
      render json: {
        errors: 'Email or password combination did not work. Please try again.'
      }, status: 401
    end
  end
end