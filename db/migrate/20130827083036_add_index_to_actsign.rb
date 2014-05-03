class AddIndexToActsign < ActiveRecord::Migration
  def change

    add_index :activities, :category_id

    change_column_default :activities,:is_suspend,false
    change_column_default :activities,:is_suspend,false
    change_column_default :activities,:is_allow_everyone,false


    add_index :activity_signs, :activity_id
    add_index :activity_signs, :user_id
    change_column_default :activity_signs,:is_anonymous,false

    change_column_default :ads,:is_close,false

    add_index :articles, :category_id
    add_index :articles, :user_id
    change_column_default :articles,:is_recommended,false
    change_column_default :articles,:is_fixed,false

    rename_column :asks, :city_integer,:city_id
    add_index :asks, :user_id
    change_column_default :asks,:is_resolved,false
    change_column_default :asks,:is_recommended,false
    change_column_default :asks,:is_fixed,false

    add_index :been_to_places, :user_id
    add_index :been_to_places, :place_id

    add_index :areas, :city_id
    add_index :cities,:province_id

    add_index :guides,:category_id
    add_index :guides,:user_id
    change_column_default :guides,:is_recommended,false
    change_column_default :guides,:is_fixed,false
    change_column_default :guides,:hits_num,0
    change_column_default :guides,:useful_num,0








  end
end
