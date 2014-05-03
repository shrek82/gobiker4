class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :intro
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
