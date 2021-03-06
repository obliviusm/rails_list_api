FactoryGirl.define do
  factory :project do
    title { Faker::Company.name }
    image { Faker::Company.logo }
    headquarters { Faker::Address.city }
    founded_at { Faker::Date.between(10.years.ago, 1.year.ago) }
    founders { Faker::StarWars.character }
    category { Faker::Book.genre }
    user { FactoryGirl.create(:user) }
  end

  factory :user do
    email { Faker::Internet.email }
    password "secret123"
  end
end
