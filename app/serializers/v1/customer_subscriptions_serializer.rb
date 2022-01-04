module V1::CustomerSubscriptionsSerializer
  class << self
    def serialize(customer)
      {
        id: customer.id,
        subscriptions: formatted_subscriptions(customer)
      }
    end

    private

    def formatted_subscriptions(customer)
      {
        active: format(customer.active_subscriptions),
        canceled: format(customer.canceled_subscriptions)
      }
    end

    def format(subscriptions)
      V1::SubscriptionSerializer.serialize(subscriptions)
    end
  end
end
