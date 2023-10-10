# frozen_string_literal: true

class SessionController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'You have successfully logged in'

      redirect_to user_path(user)
    else
      flash[:alert] = 'There was a problem logging in'

      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    cookies.delete(:user_id)

    redirect_to root_path
  end
end
