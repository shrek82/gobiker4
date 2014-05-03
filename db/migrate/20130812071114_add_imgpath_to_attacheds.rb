class AddImgpathToAttacheds < ActiveRecord::Migration
  def change
    add_column :attacheds, :img_path, :string
  end
end
