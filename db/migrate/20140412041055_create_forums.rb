class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.integer :category_id
      t.string :name, limit: 30
      t.string :intro, limit: 250
      t.integer :province_id
      t.integer :city_id
      t.integer :club_id
      t.integer :topics_num
      t.integer :order_num
      t.boolean :is_systemic
      t.string :icon_path, limit: 200

      t.timestamps
    end
    add_index :forums, :category_id
    add_index :forums, :province_id
    add_index :forums, :city_id
    add_index :forums, :club_id
  end
end
