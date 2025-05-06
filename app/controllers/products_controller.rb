# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product_unscoped, only: %i[buy_now confirm_purchase cancel_purchase download]

  before_action :authenticate_user!, only: %i[buy_now confirm_purchase cancel_purchase download]

  before_action :authorize_seller, only: %i[edit update destroy]

  before_action :ensure_not_owner, only: %i[buy_now download]

  before_action :ensure_payment_method, only: %i[buy_now download]

  def product_params
    params.require(:product).permit(:name, :price, :description, photos: [], templates: [])
  end

  # prevent other users from modifying or deleting products
  def authorize_seller
    @product = Product.find(params[:id])

    return if current_user.account == @product.account

    flash[:error] = 'You are not authorized to modify this product.'
    redirect_to products_path
  end

  def index
    @products = Product.all

    # Apply search filter
    if params[:search].present?
      @products = @products.where("name ILIKE ? OR description ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end
  
    if params[:sort].present?
      case params[:sort]
      when "name_asc"
        @products = @products.order(name: :asc)
      when "name_desc"
        @products = @products.order(name: :desc)
      when "price_low"
        @products = @products.order(price: :asc)
      when "price_high"
        @products = @products.order(price: :desc)
      end
    end
  
    render :index
  end

  def show
    @product = Product.find(params[:id])
    render :show
  end

  # Scenario 08‑1a
  def new
    @product = Product.new
    render :new
  end

  def edit
    @product = Product.find(params[:id])
    render :edit
  end

  def create
    account = current_user.account
    @product = account.products.new(product_params)

    if @product.save
      flash[:success] = 'Product successfully created!'
      redirect_to product_path(@product)
    else
      flash.now[:error] = 'Failed to create the product.'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find(params[:id])

    # Remove selected photos
    if params[:remove_photos]
      params[:remove_photos].each do |photo_id|
        @product.photos.find(photo_id).purge
      end
    end

    # Remove selected files
    if params[:remove_templates]
      params[:remove_templates].each do |file_id|
        @product.templates.find(file_id).purge
      end
    end

    # Append new photos instead of replacing
    @product.photos.attach(params[:product][:photos]) if params[:product][:photos].present?

    # Append new templates instead of replacing
    @product.templates.attach(params[:product][:templates]) if params[:product][:templates].present?

    # Update product details
    if @product.update(params.require(:product).permit(:name, :price, :description))
      flash[:success] = 'Product successfully updated!'
      redirect_to product_path(@product)
    else
      flash.now[:error] = 'Failed to update the product.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:success] = 'Product successfully removed!'
      redirect_to products_path
    else
      flash[:error] = 'Failed to remove the product.'
      redirect_to product_path(@product), status: :unprocessable_entity
    end
  end

  def buy_now
    unless user_signed_in?
      flash[:alert] = 'You must first log in to purchase.'
      return redirect_to new_user_session_path
    end

    unless current_user.account.payment_sources.exists?
      flash[:alert] = 'You need to add a Payment Method!'
      return redirect_to account_payments_path
    end

    flash[:purchase_confirmation] = "Are you sure you want to buy “#{@product.name}”?"
    redirect_to product_path(@product)
  end

  def confirm_purchase
    @product = Product.find(params[:id])
    unless Purchase.exists?(user: current_user, product: @product)
      Purchase.create!(user: current_user, product: @product)
    end

    redirect_to download_product_path(@product)
  end

  def cancel_purchase
    @product = Product.find(params[:id])
    flash[:notice] = 'Purchase Cancelled'
    redirect_to product_path(@product)
  end

  def download
    @templates = @product.templates
  end

  private

  def set_product_unscoped
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Product not found.'
    redirect_to products_path
  end

  def ensure_not_owner
    return unless @product.account == current_user.account

    flash[:alert] = 'You cannot purchase your own product.'
    redirect_to products_path
  end

  def ensure_payment_method
    return if current_user.account.payment_sources.present?

    flash[:alert] = 'You need to add a Payment Method!'
    redirect_to account_payments_path and return
  end
end
