class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :category_id
      t.string :title, :limit => 200
      t.integer :subject_id, :limit => 2
      t.string :tags, :limit => 100
      t.string :intro
      t.string :address
      t.text :content
      t.integer :club_id
      t.integer :user_id
      t.string :title_color, :limit => 10
      t.datetime :sign_start_at
      t.datetime :sign_finish_at
      t.datetime :start_at
      t.datetime :finish_at
      t.integer :sign_limit
      t.string :icon_path, :limit => 200
      t.string :img_path, :limit => 200
      t.boolean :is_fixed
      t.boolean :is_comment
      t.boolean :is_recommend
      t.boolean :is_closed
      t.boolean :is_suspend
      t.boolean :is_stop_sign
      t.boolean :is_allow_everyone
      t.integer :signed_num
      t.integer :hits_num
      t.integer :comments_num
      t.integer :interested_num

      t.timestamps
    end
  end
end
