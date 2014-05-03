class AddCommentnumToPlace < ActiveRecord::Migration
  def change
    add_column :places, :comments_num, :integer
  end
end
