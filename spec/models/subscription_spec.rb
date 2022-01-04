require 'rails_helper'

describe Subscription do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
    it { should validate_presence_of :frequency }
  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :tea }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values %w[active canceled] }
    it { should define_enum_for(:frequency).with_values %w[daily weekly monthly] }
  end

  describe 'methods' do
    describe '#cancel_subscription!' do
      let!(:customer) { create :customer }
      let!(:tea) { create :tea }
      let!(:subscription) { create :subscription, tea_id: tea.id, customer_id: customer.id }

      it 'can unsubscribe a customer from a tea' do
        subscription.cancel_subscription!

        expect(subscription.status).to eq('canceled')
      end

      it 'returns nil if the status is already canceled' do
        subscription.cancel_subscription!

        expect(subscription.cancel_subscription!).to be nil
      end
    end

    describe '#grouped_by_status' do
      let!(:customer) { create :customer }
      let!(:tea) { create :tea }
      let!(:active_subs) do
        create_list :subscription, 2, customer_id: customer.id, tea_id: tea.id, status: 0
      end
      let!(:canceled_subs) do
        create_list :subscription, 3, customer_id: customer.id, tea_id: tea.id, status: 1
      end

      it 'has the subscriptions grouped by status' do
        expected = {
          'canceled' => canceled_subs,
          'active' => active_subs
        }

        expect(customer.subscriptions.grouped_by_status).to eq(expected)
      end
    end
  end
end
