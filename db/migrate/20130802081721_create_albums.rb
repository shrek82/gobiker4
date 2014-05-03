class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.integer :user_id
      t.integer :place_id
      t.integer :event_id
      t.integer :club_id
      t.integer :pics_num
      t.integer :hits_num
      t.string :tags
      t.string :cover_path
      t.integer :order_num
      t.boolean :is_close
      t.boolean :is_recommended

      t.timestamps
    end
  end
end
