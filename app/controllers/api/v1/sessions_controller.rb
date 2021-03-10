class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if user
      session[:user_id] = user.id
      render json: UsersSerializer.new(user)
    else
      render json: {
        status: 401,
        errors: 'Email or password combination did not work. Please try again.'
      }
    end
  end
end