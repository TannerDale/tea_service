FactoryBot.define do
  factory :subscription do
    association :customer
    association :tea
    title { Faker::Lorem.word }
    price { 1250 }
    status { [0, 1].sample }
    frequency { [0, 1, 2].sample }
  end
end
