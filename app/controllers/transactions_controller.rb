# frozen_string_literal: true

class TransactionsController < ApplicationController
  include TransactionsHelper

  before_action :ensure_user_authenticated

  def index
    @transactions = user_transactions
  end

  def new; end

  def transfer
    result = Transactions::TransferService.new(current_user, transfer_params.dup).call

    if result.success?
      flash[:notice] = result.message
      redirect_to transactions_path
    else
      flash[:alert] = result.message
      render :new
    end
  end

  private

  def transfer_params
    params.require(:transfer).permit(:sender_account_number, :receiver_account_number, :amount)
  end
end
