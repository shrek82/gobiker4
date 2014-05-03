class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :name, :limit => 50
      t.string :key_name
      t.string :value

      t.timestamps
    end
  end
end
