class AddFieldoneToProvince < ActiveRecord::Migration
  def change
    add_column :provinces, :province_id, :integer
  end
end
