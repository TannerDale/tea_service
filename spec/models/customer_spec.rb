require 'rails_helper'

describe Customer do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :address }

    it 'validates email against REGEXP' do
      valid_user = Customer.new(
        first_name: 'Hello',
        last_name: 'World',
        email: 'hello@yahoogmail.com',
        address: '12345 Road St.'
      )
      invalid_user = Customer.new(
        first_name: 'Hello',
        last_name: 'World',
        email: 'hello.com',
        address: '12345 Road St.'
      )

      expect(valid_user.valid?).to be true
      expect(invalid_user.valid?).to be false
    end
  end

  describe 'relationships' do
    it { should have_many :subscriptions }
  end

  describe 'methods' do
    describe '#subscriptions_by_status' do
      let!(:customer) { create :customer }
      let!(:tea) { create :tea }
      let!(:active_subs) do
        create_list :subscription, 2, customer_id: customer.id, tea_id: tea.id, status: 0
      end
      let!(:cancelled_subs) do
        create_list :subscription, 3, customer_id: customer.id, tea_id: tea.id, status: 1
      end

      it 'has the subscriptions grouped by status' do
        expected = {
          'cancelled' => cancelled_subs,
          'active' => active_subs
        }

        expect(customer.subscriptions_by_status).to eq(expected)
      end
    end
  end
end
