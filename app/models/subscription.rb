class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates :title, presence: true
  validates :price, presence: true
  validates :frequency, presence: true

  enum status: %w[active canceled]
  enum frequency: %w[daily weekly monthly]
end
