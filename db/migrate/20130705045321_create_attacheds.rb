class CreateAttacheds < ActiveRecord::Migration
  def change
    create_table :attacheds do |t|
      t.string :name, :limit => 50
      t.string :att, :limit => 100
      t.boolean :is_verify
      t.string :att_file_name, :limit => 50
      t.string :att_content_type, :limit => 20
      t.integer :att_file_size
      t.timestamp :att_updated_at

      t.timestamps
    end
  end
end
