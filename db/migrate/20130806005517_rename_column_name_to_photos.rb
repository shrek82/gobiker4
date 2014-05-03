class RenameColumnNameToPhotos < ActiveRecord::Migration
  def change
    change_table :photos do |t|
      t.rename :img_path_file_name, :img_file_name
      t.rename :img_path_content_type, :img_content_type
      t.rename :img_path_file_size, :img_file_size
      t.rename :img_path_updated_at, :img_updated_at
    end
  end
end
