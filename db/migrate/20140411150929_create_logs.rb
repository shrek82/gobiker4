class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :title, limit: 150
      t.string :controller, limit: 50
      t.string :action, limit: 50
      t.integer :user_id

      t.timestamps
    end
  end
end
