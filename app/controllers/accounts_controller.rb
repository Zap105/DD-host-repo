# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    # render account details
  end

  def show
    @account = current_user.account
    @owned_products = @account.products
    @purchased_products = current_user.purchased_products
  end

  def edit
    @account = current_user.account
  end

  def update
    @account = current_user.account
    if @account.update(account_params)
      flash[:notice] = 'Account Info Updated'
      redirect_to account_path
    else
      flash[:alert] = "Update failed: #{@account.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  private

  def account_params
    params.require(:account).permit(:user_name, :first_name, :last_name, :phone)
  end
end
