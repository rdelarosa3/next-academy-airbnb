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

# ActiveRecord::Base.transaction do
  40.times do 
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
# end

# See taggings
tagging = {}
tids = []
Tag.all.each { |t| tids << t.id }

# ActiveRecord::Base.transaction do
Listing.all.each do |l|
  rand(2..4).times do
    tagging['listing_id'] = l.id
    tagging['tag_id'] = tids.sample
    Tagging.create(tagging)
  end
end

# end

# end