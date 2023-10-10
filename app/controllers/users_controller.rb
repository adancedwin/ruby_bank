class UsersController < ApplicationController
  def show
    return unless ensure_user_authenticated

    # build a new account object for the user if they don't have one
    current_user.build_account unless current_user.accounts.any?
  end
end