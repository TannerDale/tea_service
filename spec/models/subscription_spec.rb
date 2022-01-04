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
end
