class Api::V1::CustomersController < ApplicationController
  def create
    render json: Customer.create!(customer_params)
  end

  private

  def customer_params
    params.permit(:first_name, :last_name, :email, :address)
  end
end
