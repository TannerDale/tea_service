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
      customer.subscriptions_by_status.transform_values do |sub|
        format(sub)
      end
    end

    def format(subscriptions)
      V1::SubscriptionSerializer.serialize(subscriptions)
    end
  end
end
