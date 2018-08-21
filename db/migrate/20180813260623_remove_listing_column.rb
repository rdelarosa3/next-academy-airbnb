class RemoveListingColumn < ActiveRecord::Migration[5.2]
  def change
  	remove_column :listings, :listings_photo, :string
  end
end
