class AddImgToForums < ActiveRecord::Migration
  def change
    add_column :forums, :ico_path, :string, :limit => 250
  end
end
