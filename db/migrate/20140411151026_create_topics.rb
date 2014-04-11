class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :forum_id
      t.integer :subject_id
      t.string :title, limit: 150
      t.string :title_color, limit: 10
      t.integer :user_id
      t.boolean :is_fixed
      t.boolean :is_good
      t.boolean :is_recommend
      t.integer :hits_num
      t.integer :comments_num
      t.integer :last_comment_user_id
      t.datetime :last_comment_time

      t.timestamps
    end
    add_index :topics, :forum_id
    add_index :topics, :subject_id
    add_index :topics, :user_id
  end
end
