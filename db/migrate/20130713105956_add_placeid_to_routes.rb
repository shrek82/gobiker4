class AddPlaceidToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :place_id, :integer
  end
end
