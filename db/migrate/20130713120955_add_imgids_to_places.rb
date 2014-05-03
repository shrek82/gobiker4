class AddImgidsToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :img_ids, :string
  end
end
