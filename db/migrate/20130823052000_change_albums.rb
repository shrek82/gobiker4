class ChangeAlbums < ActiveRecord::Migration

  def change
    change_table :albums do |t|
      t.change(:name,:string,:limit=>100)
      t.change(:tags,:string,:limit=>100)

      t.change_default(:pics_num,0)
      t.change_default(:hits_num,0)
      t.change_default(:cover_path,'/images/album_over.png')

      t.change_default(:is_close,false)
      t.change_default(:is_recommended,false)

      t.index(:user_id)
      t.index(:event_id)
      t.index(:place_id)
      t.index(:club_id)
    end
  end

end
