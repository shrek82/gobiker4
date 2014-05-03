class CreateWantToPlaces < ActiveRecord::Migration
  def change
    create_table :want_to_places do |t|
      t.integer :place_id
      t.integer :user_id

      t.timestamps
    end
  end
end
