class Api::V1::SubscriptionsController < ApplicationController
  def index; end

  def create
    render json: current_customer.subscriptions.create!(subscription_params)
  end

  def destroy; end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :tea_id)
  end

  def current_customer
    Customer.find(params[:customer_id])
  end
end
