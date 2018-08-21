class AddListingColumn < ActiveRecord::Migration[5.2]
  def change
  	add_column :listings, :listings_photo, :string
  end
end
