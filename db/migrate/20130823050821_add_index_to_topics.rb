class AddIndexToTopics < ActiveRecord::Migration
  def change
    change_table :topics do |t|
      t.change(:title_color,:string,:limit=>10)
      t.index(:forum_id,:name=>'forum_idx')
      t.index(:user_id,:name=>'user_idx')
      t.index(:is_good,:name=>'is_goodx')
      t.index(:subject_id,:name => 'subject_idx')
    end
  end
end
