FactoryBot.define do
  factory :instruction do
    text { Faker::Lorem.unique }
    done { false }
    recipe_id { nil }
  end
end