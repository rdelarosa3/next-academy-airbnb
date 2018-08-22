# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seed Users

user = {}
user['password'] = 'asdf'

ActiveRecord::Base.transaction do
  20.times do 
    user['first_name'] = Faker::Name.first_name 
    user['last_name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.email
    user['role'] = [0,1,2].sample
    user['birthdate'] = Faker::Date.between(50.years.ago, Date.today)

    User.create(user)
  end
end 



Tag.create(name: 'Pool')
Tag.create(name: 'Wifi')
Tag.create(name: 'Desk/workspace')
Tag.create(name: 'Pets in the house')
Tag.create(name: 'Gym')
Tag.create(name: 'Air conditioning')
Tag.create(name: 'Private entrance')
Tag.create(name: 'Ensuite Bathroom')
Tag.create(name: 'Lock on bedroom door')


# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }


  20.times do 
    listing['listing_name'] = Faker::App.name
    listing['country'] = Faker::Address.country
    listing['city'] = Faker::Address.city
    listing['state'] = Faker::Address.state
    listing['home_type'] = rand(0..3)
    listing['room_type'] = rand(0..2)
    listing['street'] = Faker::Address.street_address
    listing['price'] = rand(80..500)
    listing['max_guest'] = rand(1..8)
    listing['room'] = rand(1..10)
    listing['bathroom'] = rand(1..8)
    listing['summary'] = Faker::Hipster.sentence
    listing['user_id'] = uids.sample
    Listing.create(listing)
  end


# See taggings
tagging = {}
tids = []
Tag.all.each { |t| tids << t.id }


Listing.all.each do |l|
  rand(2..4).times do
    tagging['listing_id'] = l.id
    tagging['tag_id'] = tids.sample
    Tagging.create(tagging)
  end
end

avatar_array = ["https://randomuser.me/api/portraits/men/31.jpg","https://randomuser.me/api/portraits/men/64.jpg","https://randomuser.me/api/portraits/women/90.jpg","https://randomuser.me/api/portraits/women/62.jpg","https://randomuser.me/api/portraits/women/49.jpg"]
User.all.each do |person|
  person.remote_avatar_url = avatar_array.shuffle.sample
  person.save
end


temp_array = ["https://images.unsplash.com/photo-1518481852452-9415b262eba4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=682a7e2a70ae366b3610b014f5bb5a97&auto=format&fit=crop&w=1950&q=80","https://images.unsplash.com/photo-1513694203232-719a280e022f?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=ee7b83f80f90879486ced1b45501ce21&auto=format&fit=crop&w=1949&q=80","https://images.unsplash.com/photo-1499955085172-a104c9463ece?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=1c30274d56662166fdafd604140d2df4&auto=format&fit=crop&w=1950&q=80","https://images.unsplash.com/photo-1484154218962-a197022b5858?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ba2b9dcc1af593a7d93ed9b4ed952ac&auto=format&fit=crop&w=1953&q=80","https://images.unsplash.com/photo-1488805990569-3c9e1d76d51c?ixlib=rb-0.3.5&s=2b1e8a77c89e531d8a93db3995a54bc8&auto=format&fit=crop&w=1950&q=80","https://images.unsplash.com/photo-1472504929007-6d7cd0ef7d50?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a08e9460cac871fd84d91b27214d5e35&auto=format&fit=crop&w=1950&q=80"]
images_array = []

2.times do
  Listing.all.each do |place|
  images_array << temp_array.shuffle.sample
  images_array << temp_array.shuffle.sample
  place.remote_images_urls = images_array
  place.save
  images_array = []
  end
end
