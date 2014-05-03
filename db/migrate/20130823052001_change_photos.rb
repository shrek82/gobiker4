class ChangePhotos < ActiveRecord::Migration

  def change
    change_table :photos do |t|
      t.change_default(:is_verify,true)
      t.index(:user_id)
      t.index(:album_id)
    end
  end

end
