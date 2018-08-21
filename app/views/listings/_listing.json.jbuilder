json.extract! listing, :id, :user_id, :home_type, :room_type, :max_guest, :room, :bathroom, :price, :active, :listing_name, :summary, :street, :city, :state, :country, :latitude, :longitude, :created_at, :updated_at
json.url listing_url(listing, format: :json)
