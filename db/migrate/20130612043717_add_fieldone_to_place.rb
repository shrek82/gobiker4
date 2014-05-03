class AddFieldoneToPlace < ActiveRecord::Migration
  def change
    add_column :places, :tags, :string
    add_column :places, :category_id, :integer
    add_column :places, :img_path, :string
    add_column :places, :banner_path, :string
  end
end
