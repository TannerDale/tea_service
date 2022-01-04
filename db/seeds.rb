# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Customer.destroy_all
Tea.destroy_all
Subscription.destroy_all

customer = Customer.create!(
  first_name: 'Bob',
  last_name: 'Ross',
  email: 'bob_ross@painting.com',
  address: '1234 Painting St.'
)

teas = [1, 2].map do |num|
  Tea.create!(
    title: "Tea #{num}",
    description: "Amazing tea #{num}",
    temperature: 70,
    brew_time: 120
  )
end

(1..20).each do |num|
  Subscription.create!(
    title: "subscription #{num}",
    price: 1250,
    status: [0, 1].sample,
    frequency: Subscription.statuses.values.sample,
    customer_id: customer.id,
    tea_id: num.even? ? teas.first.id : teas.last.id
  )
end
