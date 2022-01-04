require 'rails_helper'

describe 'Customer Requests' do
  headers = { 'CONTENT_TYPE': 'application/json' }

  context 'POST v1/customers' do
    context 'with valid params' do
      let(:valid_params) do
        {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.email,
          address: '123 Street Dr.'
        }
      end

      before { post api_v1_customers_path, headers: headers, params: valid_params.to_json }

      it 'creates the user' do
        expect(Customer.count).to eq(1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status 201
      end
    end

    context 'with invalid params' do
      let(:params) do
        { first_name: 'hello', email: Faker::Internet.email, address: '123 street rd.' }
      end
      let(:parsed) { JSON.parse(response.body, symbolize_names: true) }

      before { post api_v1_customers_path, headers: headers, params: params.to_json }

      it 'returns an error message' do
        expect(parsed[:error][:details]).to include('Validation failed:')
      end

      it 'does not create the user' do
        expect(Customer.count).to eq(0)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status 400
      end
    end
  end
end
