class Listing < ApplicationRecord
  
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :reservations
  enum home_type: ["apartment","house", "bed and breakfast","unique space"]
  enum room_type: ["entire place","private room", "shared room"]

  # scope :recent, ->{ order("created_at DESC")}
  # scope h:price_range, (price_min, price_max) -> { where("price >= ? AND price <= ?",price_min, price_max)}


  
  # gecode required to set latitude and logitude
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  # paginate required to set amount of listings per page
  paginates_per 12

  # required by uploader to allow upload of more than 1 picture
  mount_uploaders :images, ImageUploader


  # method to find all tags 
  def all_tags=(names)
    self.tags = name.split(',').map do |name|
      Tag.where(name: name).first_or_create!
    end
  end

  # method to gather all tags from listing and return string
  def all_tags
    tags.map(&:name).join(", ")
  end

  # method to find listings tagged with ...
  def self.tagged_with(name)
    Tag.find_by(name: name).listings
  end

  # create string from form inputs to use with geocode
  def address
    [street, city, state, country].compact.join(', ')
  end

  # if address changed update geocode
  def address_changed?
    street_changed? || city_changed? || state_changed? || country_changed?
  end

  # create array of all currently booked dates
  def booked_dates
    @booked_dates = []

    self.reservations.each do |reserved|
    reserved.start_date.upto(reserved.end_date) do |date|
    @booked_dates << date.strftime("%m-%d-%Y") end
    end
    @booked_dates
  end

  def self.price_range(price_min,price_max)
    Listing.where("price >= ? AND price <= ?",price_min, price_max)
  end

  
  def self.search(term)
    if term
      where('lower(city) LIKE ? OR lower(state) LIKE? OR lower(listing_name) LIKE ? OR lower(summary) LIKE ? OR lower(country) LIKE ?', "%#{term.downcase}%","%#{term.downcase}%","%#{term.downcase}%","%#{term.downcase}%","%#{term.downcase}%")
    else
      all
    end
  end


  def self.free_on(date_start,date_end)
    reserved_listing_ids = Reservation.on_dates(date_start,date_end).pluck('DISTINCT listing_id')
    Listing.where('id NOT IN (?)', reserved_listing_ids)
  end

  def self.reserved_on(date_start,date_end)
    reserved_listing_ids = Reservation.on_dates(date_start,date_end).pluck('DISTINCT listing_id')
    Listing.where(:id => reserved_listing_ids)
  end


end