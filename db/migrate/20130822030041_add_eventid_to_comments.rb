class AddEventidToComments < ActiveRecord::Migration
  def change
    add_column :comments, :event_id, :integer
    add_column :comments, :article_id, :integer
    add_column :comments, :album_id, :integer
  end
end
