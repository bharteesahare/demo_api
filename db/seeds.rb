# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
  u3 = User.create(auth_token: "123456789", email: "bhartee@gmail.com", password: "123456")
# 5.times do
#   user = User.new(
#     auth_token:     Faker::Name.name,
#     email:    Faker::Internet.email,
#     password: Faker::Lorem.characters(10)
#   )
#   user.skip_confirmation!
#   user.save!
# end
# users = User.all

u1 = User.create(email: 'user@example.com', password: 'password')
u2 = User.create(email: 'user2@example.com', password: 'password')

p1 = u1.posts.create(title: 'First Post', body: 'An Airplane')
p2 = u1.posts.create(title: 'Second Post', body: 'A Train')

p3 = u2.posts.create(title: 'Third Post', body: 'A Truck')
p4 = u2.posts.create(title: 'Fourth Post', body: 'A Boat')

p3.comments.create(body: "This post was terrible", user: u1)
p4.comments.create(body: "This post was the best thing in the whole world", user: u1)
