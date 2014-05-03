class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.integer :city_id
      t.integer :area_id

      t.timestamps
    end
  end
end
