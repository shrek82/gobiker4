class AddFieldtwoToPlace < ActiveRecord::Migration
  def change
    add_column :places, :province_id, :integer
  end
end
