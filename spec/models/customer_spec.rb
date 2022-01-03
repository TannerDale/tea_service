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
end
