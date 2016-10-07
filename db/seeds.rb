50.times do
  Project.create(
    title: Faker::Company.name, 
    image: Faker::Company.logo,
    headquarters: Faker::Address.city,
    founded_at: Faker::Date.between(10.years.ago, 1.year.ago),
    founders: Faker::StarWars.character,
    category: Faker::Book.genre
  )
end
