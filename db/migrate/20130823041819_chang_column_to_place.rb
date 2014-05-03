class ChangColumnToPlace < ActiveRecord::Migration
  def change

    change_table :places do |t|
      t.change_default(:been_num,0)
      t.change_default(:interested_num,0)
      t.change_default(:favorites_num,0)
      t.change_default(:hits_num,0)
      t.change_default(:good_num,0)
      t.change_default(:wantgoto_num,0)
      t.change_default(:beengo_num,0)
      t.change_default(:is_recommended,false)
      t.change_default(:is_fixed,false)


    end

  end
end
