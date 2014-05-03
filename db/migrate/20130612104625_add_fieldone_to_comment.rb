class AddFieldoneToComment < ActiveRecord::Migration
  def change
    add_column :comments, :place_id, :integer
    add_column :comments, :route_id, :integer
    add_column :comments, :bbs_unit_id, :integer
  end
end
