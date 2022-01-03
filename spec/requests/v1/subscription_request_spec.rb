require 'rails_helper'

describe 'Subscription Requests' do
  context 'POST v1/customers/:customer_id/subscriptions' do
    context 'with valid params' do
      let!(:customer) { create :customer }
      let!(:tea) { create :tea }
      # let(:valid_params)
    end

    context 'with invalid params' do
    end
  end
end
