class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :num
      t.timestamps
    end
   
    create_table :places_tags,:id=>false do |t|
      t.integer :place_id
      t.integer :tag_id
    end
  end
end
