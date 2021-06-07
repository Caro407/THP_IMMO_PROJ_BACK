User.destroy_all
Post.destroy_all

30.times do
  User.create!(email: Faker::Internet.email,
               password: "azerty",
               first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name)
end
