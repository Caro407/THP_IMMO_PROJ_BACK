User.destroy_all
Post.destroy_all
City.destroy_all

30.times do
  User.create!(email: Faker::Internet.email,
               password: "azerty",
               first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name)
end

  City.create!(name: "Paris", zip_code: "75000")
  City.create!(name: "Lyon",zip_code: "69000")
  City.create!(name: "Marseille",zip_code: "13000")
 
User.all.each do |user|

  housing_types = [" house", " appartment", " villa", " flat"]
  locations = [" right next to ", " in the center of ", " far away from ", " in a random neighbourhood of "]
  Post.create!(title: Faker::Adjective.positive + housing_types.sample + locations.sample + Faker::Address.city,
               content: Faker::Lorem.paragraph_by_chars(number: rand(80..150)),
               price: Faker::Number.within(range: 150..1000),
               owner: user,
               city_id: City.all.sample.id
              )
end
