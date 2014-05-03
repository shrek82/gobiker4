class CreateRecommends < ActiveRecord::Migration
  def change
    create_table :recommends do |t|
      t.string :name
      t.string :type
      t.string :img_path
      t.integer :order_num
      t.string :redirect
      t.string :intro
      t.boolean :is_close
      t.boolean :is_fixed
      t.integer :hits

      t.timestamps
    end
  end
end
