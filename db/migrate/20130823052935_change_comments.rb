class ChangeComments < ActiveRecord::Migration
  def change
    change_table :comments do |t|

      t.index(:place_id)
      t.index(:user_id)
      t.index(:route_id)
      t.index(:topic_id)
      t.index(:event_id)
      t.index(:article_id)
      t.index(:album_id)
    end
  end
end
