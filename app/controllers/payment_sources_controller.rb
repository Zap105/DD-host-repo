# frozen_string_literal: true

class PaymentSourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account

  def index
    @payment_sources = @account.payment_sources
  end

  def new
    @payment_source = PaymentSource.new
  end

  def edit
    @payment_source = @account.payment_sources.find(params[:id])
  end

  def create
    @payment_source = @account.payment_sources.build(payment_source_params)

    if @payment_source.save
      flash[:notice] = 'Payment method added'
      redirect_to account_payments_path
    else
      flash.now[:alert] = 'Invalid submission, please try again'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @payment_source = @account.payment_sources.find(params[:id])
    if @payment_source.update(payment_source_params)
      flash[:notice] = 'Payment method updated'
      redirect_to account_payments_path
    else
      flash.now[:alert] = 'Update failed. Please check the form.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @payment_source = @account.payment_sources.find(params[:id])
    if @payment_source.destroy
      flash[:notice] = 'Payment Method removed'
    else
      flash[:alert] = 'Unable to remove payment method'
    end
    redirect_to account_payments_path
  end

  private

  def set_account
    @account = current_user.account
  end

  def payment_source_params
    params.require(:payment_source).permit(
      :payment_type, :cardholder_name, :card_number, :expiration_month,
      :expiration_year, :cvv
    )
  end
end
