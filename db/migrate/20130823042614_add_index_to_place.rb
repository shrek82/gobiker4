class AddIndexToPlace < ActiveRecord::Migration
  def change

    change_table :places do |t|
      t.index(:user_id)
      t.index(:category_id)
      t.index([:province_id, :city_id],:name => 'by_province_city')
      t.index(:is_recommended)
    end
  end
end
