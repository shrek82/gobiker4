class CreateThreads < ActiveRecord::Migration
  def change
    create_table :threads do |t|
      t.string :title, :limit => 150
      t.integer :forum_id
      t.integer :subject_id, :limit => 2
      t.integer :club_id
      t.integer :user_id
      t.string :title_color, :limit => 10
      t.boolean :is_fixed
      t.boolean :is_comment
      t.boolean :is_good
      t.boolean :is_recommend
      t.integer :hits_num
      t.integer :comments_num
      t.integer :last_comment_user_id
      t.string :last_comment_user_name, :limit => 50
      t.datetime :last_comment_time

      t.timestamps
    end
  end
end
