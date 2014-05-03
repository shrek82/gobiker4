class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :title
      t.string :short_title
      t.string :tags
      t.integer :category_id
      t.integer :user_id
      t.string :img_path
      t.string :banner_path
      t.integer :province_id
      t.integer :city_id
      t.integer :duration
      t.integer :distance
      t.string :starting
      t.string :destination
      t.string :intro
      t.text :content
      t.string :source
      t.integer :been_num
      t.integer :interested_num
      t.integer :favorites_num
      t.integer :hits_num
      t.integer :good_num
      t.string :along_the_scenic
      t.boolean :is_recommended
      t.boolean :is_fixed
      t.integer :recommendation_index
      t.integer :landscape_index
      t.integer :road_index
      t.string :map

      t.timestamps
    end
  end
end
