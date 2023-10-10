# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :ensure_user_authenticated
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def ensure_user_authenticated
    unless logged_in?
      flash[:alert] = 'You must be logged in to access this page'
      redirect_to session_path

      return false # Return false to indicate authentication failure
    end
    true # Return true to indicate authentication success
  end
end
