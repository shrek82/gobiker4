class CreateStudies < ActiveRecord::Migration
  def change
    create_table :studies do |t|
      t.string :name
      t.string :intro
      t.boolean :is_close
      t.datetime :login_at
      t.text :content

      t.timestamps
    end
  end
end
