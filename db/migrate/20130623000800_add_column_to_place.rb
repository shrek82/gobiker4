class AddColumnToPlace < ActiveRecord::Migration
  def change
    add_column :places, :area_id, :integer
  end
end
