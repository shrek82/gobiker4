class Delcolumn < ActiveRecord::Migration
  def change
    remove_column :activities, :title
    remove_column :activities, :intro
    remove_column :activities, :subject_id
    remove_column :activities, :tags
    remove_column :activities, :club_id
    remove_column :activities, :user_id
    remove_column :activities, :title_color
    remove_column :activities, :is_fixed
    remove_column :activities, :is_comment
    remove_column :activities, :is_recommend
    remove_column :activities, :is_closed
    remove_column :activities, :hits_num
    remove_column :activities, :comments_num
    remove_column :activities, :interested_num
    remove_column :activities, :icon_path
    remove_column :activities, :img_path
    add_index :activities,:topic_id
  end
end
