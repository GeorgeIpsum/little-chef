FactoryBot.define do
  factory :instruction do
    text { Faker::StarWars.character }
    done { false }
    recipe_id nil
  end
end