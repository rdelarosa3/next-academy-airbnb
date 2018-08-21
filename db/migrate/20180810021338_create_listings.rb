class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.references :user, foreign_key: true
      t.integer :home_type
      t.integer :room_type
      t.integer :max_guest
      t.integer :room
      t.integer :bathroom
      t.integer :price
      t.boolean :verified
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :listing_name
      t.text :summary
      t.float :latitude
      t.float :longitude


      t.timestamps
    end
  end
end
