class RenameColumnNameToRecommends < ActiveRecord::Migration
  def change
    #rename_column :forums, :threads_num, :topics_num
    #rename_column :table_name, :old_column, :new_column
    change_table :recommends do |t|
      t.rename :type, :category
    end
  end
end