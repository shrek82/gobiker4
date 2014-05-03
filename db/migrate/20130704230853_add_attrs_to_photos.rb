class AddAttrsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :img_path_file_name, :string, :limit => 50
    add_column :photos, :img_path_content_type, :string, :limit => 50
    add_column :photos, :img_path_file_size, :string, :limit => 50
    add_column :photos, :img_path_updated_at, :timestamp
  end
end
