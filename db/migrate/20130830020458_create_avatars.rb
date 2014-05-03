class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.integer :user_id
      t.string :img, :limit => 150
      t.string :img_path, :limit => 150
      t.string :img_file_name, :limit => 100
      t.string :img_content_type, :limit => 50
      t.string :img_file_size, :limit => 20
      t.datetime :img_updated_at

      t.timestamps
    end
    add_index :avatars, :user_id
  end
end
