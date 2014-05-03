class AddImgPathToCities < ActiveRecord::Migration
  def change
    add_column :cities, :img_path, :string
  end
end
