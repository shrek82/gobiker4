class RenameColumnNameToTopics < ActiveRecord::Migration
  def change
    #rename_column :forums, :threads_num, :topics_num
    #rename_column :table_name, :old_column, :new_column
    change_table :forums do |t|
      t.rename :threads_num, :topics_num
    end
  end
end
