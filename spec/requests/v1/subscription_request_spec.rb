require 'rails_helper'

describe 'Subscription Requests' do
  context 'POST v1/customers/:customer_id/subscriptions' do
    let!(:customer) { create :customer }
    let!(:tea) { create :tea }
    let(:headers) { { 'CONTENT_TYPE': 'application/json' } }
    let(:valid_params) do
      {
        title: 'My fav tea',
        price: 1111,
        status: 0,
        frequency: 1,
        tea_id: tea.id
      }.to_json
    end

    context 'with valid params' do
      before { post api_v1_customer_subscriptions_path(customer.id), headers: headers, params: valid_params }

      it 'creates the subscription' do
        expect(Subscription.count).to eq(1)
        expect(Customer.first.subscriptions.count).to eq(1)
        expect(Tea.first.subscriptions.count).to eq(1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'with invalid params' do
      let(:invalid_tea) do
        {
          title: 'My fav tea',
          price: 1111,
          frequency: 1,
          tea_id: tea.id + 1
        }.to_json
      end

      context 'invalid tea_id' do
        before { post api_v1_customer_subscriptions_path(customer.id), headers: headers, params: invalid_tea }

        it 'does not create the subscription' do
          expect(Subscription.count).to eq(0)
          expect(Customer.first.subscriptions.count).to eq(0)
          expect(Tea.first.subscriptions.count).to eq(0)
        end

        it 'returns status code 404' do
          expect(response).to have_http_status 400
        end
      end

      context 'invalid customer id' do
        before { post api_v1_customer_subscriptions_path(customer.id + 1), headers: headers, params: valid_params }

        it 'does not create the subscription' do
          expect(Subscription.count).to eq(0)
          expect(Customer.first.subscriptions.count).to eq(0)
          expect(Tea.first.subscriptions.count).to eq(0)
        end

        it 'returns status code 404' do
          expect(response).to have_http_status 404
        end
      end
    end
  end
end
