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
    let!(:customer) { create :customer }
    let!(:tea) { create :tea }
    let!(:subscription) { create :subscription, tea_id: tea.id, customer_id: customer.id }

    describe '#cancel_subscription!' do
      it 'can unsubscribe a customer from a tea' do
        subscription.cancel_subscription!

        expect(subscription.status).to eq('canceled')
      end

      it 'returns nil if the status is already canceled' do
        subscription.cancel_subscription!

        expect(subscription.cancel_subscription!).to be nil
      end
    end
  end
end
