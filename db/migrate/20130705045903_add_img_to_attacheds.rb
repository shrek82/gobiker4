class AddImgToAttacheds < ActiveRecord::Migration
  def change
    add_column :attacheds, :img, :string, :limit => 100
    add_column :attacheds, :img_file_name, :string, :limit => 50
    add_column :attacheds, :img_content_type, :string, :limit => 20
    add_column :attacheds, :img_file_size, :integer
    add_column :attacheds, :img_updated_at, :timestamp
  end
end
