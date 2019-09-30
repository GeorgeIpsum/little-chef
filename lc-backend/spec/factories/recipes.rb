FactoryBot.define do
  factory :recipe do
    title { Faker::Lorem.word }
    created_by { Faker::Number.number(digits: 10) }
  end
end