json.extract! reservation, :id, :start_date, :end_date, :status, :user_id, :listing_id, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
