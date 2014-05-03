class CreateGuideCategories < ActiveRecord::Migration
  def change
    create_table :guide_categories do |t|
      t.string :name
      t.integer :order_num
      t.string :img_path

      t.timestamps
    end
  end
end
