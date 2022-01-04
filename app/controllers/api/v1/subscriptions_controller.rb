class Api::V1::SubscriptionsController < ApplicationController
  def index; end

  def create
    render json: current_customer.subscriptions.create!(subscription_params), status: 201
  end

  def update
    if Subscription.find(params[:id]).cancel_subscription!
      render status: 204
    else
      render json: { error: 'Subscription has already been canceled' }, status: 400
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :tea_id)
  end

  def current_customer
    Customer.find(params[:customer_id])
  end
end
