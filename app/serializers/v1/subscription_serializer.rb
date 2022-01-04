module V1::SubscriptionSerializer
  class << self
    def serialize(subscriptions)
      subscriptions.map do |subscription|
        format(subscription)
      end
    end

    private

    def format(subscription)
      {
        id: subscription.id,
        title: subscription.title,
        price: subscription.price,
        status: subscription.status,
        frequency: subscription.frequency
      }
    end
  end
end
