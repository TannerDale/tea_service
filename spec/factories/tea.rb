FactoryBot.define do
  factory :tea do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    temperature { 99 }
    brew_time { 60 }
  end
end
