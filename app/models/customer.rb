class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :address, presence: true

  has_many :subscriptions, dependent: :destroy

  def subscriptions_by_status
    subscriptions.grouped_by_status
  end
end
