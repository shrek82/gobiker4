class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.string :title
      t.integer :category_id
      t.integer :user_id
      t.string :tags
      t.string :intro
      t.text :content
      t.string :source
      t.string :img_path
      t.string :img_ids
      t.integer :hits_num
      t.integer :useful_num
      t.integer :comments_num
      t.boolean :is_recommended
      t.boolean :is_fixed

      t.timestamps
    end
  end
end
