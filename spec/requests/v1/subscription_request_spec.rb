require 'rails_helper'

describe 'Subscription Requests' do
  let(:headers) { { 'CONTENT_TYPE': 'application/json' } }

  context 'GET v1/customers/:customer_id/subscriptions' do
    let!(:customer) { create :customer }
    let!(:teas) { create_list :tea, 2 }
    let!(:subs_1_active) do
      create_list :subscription, 3, tea_id: teas.first.id, customer_id: customer.id, status: 0
    end
    let!(:subs_2_active) do
      create_list :subscription, 3, tea_id: teas.last.id, customer_id: customer.id, status: 0
    end
    let!(:subs_1_canceled) do
      create_list :subscription, 2, tea_id: teas.first.id, customer_id: customer.id, status: 1
    end
    let!(:subs_2_canceled) do
      create_list :subscription, 2, tea_id: teas.last.id, customer_id: customer.id, status: 1
    end
    let(:json) { JSON.parse(response.body, symbolize_names: true) }
    let(:subscriptions) { json[:subscriptions] }

    describe 'with valid customer id' do
      before { get api_v1_customer_subscriptions_path(customer), headers: headers }

      it 'has all of the customers subscriptions grouped by active and inactive' do
        expect(json[:subscriptions]).not_to be_empty
        expect(subscriptions.keys).to eq(%i[active canceled])
        expect(subscriptions[:active].count).to eq(6)
        expect(subscriptions[:canceled].count).to eq(4)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end
    end

    describe 'with invalid customer id' do
      before { get api_v1_customer_subscriptions_path(customer.id + 1), headers: headers }

      it 'returns an error message' do
        expect(json).to have_key :error
        expect(json[:error][:details]).to include("Couldn't find Customer")
      end

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end
    end
  end

  context 'POST v1/customers/:customer_id/subscriptions' do
    let!(:customer) { create :customer }
    let!(:tea) { create :tea }
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
        expect(response).to have_http_status 201
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
        before { post api_v1_customer_subscriptions_path(customer), headers: headers, params: invalid_tea }

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

  context 'PATCH v1/customers/:customer_id/subscriptions/:id' do
    let!(:customer) { create :customer }
    let!(:tea) { create :tea }
    let!(:subscription) { create :subscription, customer_id: customer.id, tea_id: tea.id, status: 0 }

    context 'with valid params' do
      before { patch api_v1_customer_subscription_path(customer, subscription), headers: headers }

      it 'updates the subscription' do
        subscription.reload

        expect(subscription.status).to eq('canceled')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status 204
      end
    end

    context 'with invalid params' do
      let(:parsed) { JSON.parse(response.body, symbolize_names: true) }

      context 'with invalid subscription id' do
        before { patch api_v1_customer_subscription_path(customer, subscription.id + 1), headers: headers }

        it 'does not update the subscription' do
          expect(subscription.status).to eq('active')
        end

        it 'returns 404' do
          expect(response).to have_http_status 404
        end
      end

      context 'when the subscription is already canceled' do
        before :each do
         patch api_v1_customer_subscription_path(customer, subscription.id ), headers: headers
         patch api_v1_customer_subscription_path(customer, subscription.id), headers: headers
        end

        it 'returns an error message' do
          expect(parsed[:error]).to eq('Subscription has already been canceled')
        end

        it 'returns status code 400' do
          expect(response).to have_http_status 400
        end
      end
    end
  end
end
