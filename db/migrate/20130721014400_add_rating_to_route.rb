class AddRatingToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :rating, :integer
  end
end
