class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :name, :limit => 100
      t.string :intro
      t.integer :province_id
      t.integer :city_id
      t.integer :club_id
      t.integer :threads_num
      t.integer :order_num
      t.boolean :is_systemic

      t.timestamps
    end
  end
end
