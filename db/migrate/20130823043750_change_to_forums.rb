class ChangeToForums < ActiveRecord::Migration
  def change
    change_table :forums do |t|
      t.change_default(:topics_num,0)
      t.change_default(:order_num,999)
      t.change_default(:ico_path,'/images/forum/default.png')
      t.change_default(:is_systemic,false)
      t.index(:city_id,:name=>'city_idx')
      t.index(:club_id,:name=>'club_idx')
      t.index([:category_id],:name => 'category_idx')
    end
  end
end
