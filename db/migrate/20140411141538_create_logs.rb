class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.varchar{150} :title
      t.varchar{50} :controller
      t.varchar{50} :action
      t.integer :user_id

      t.timestamps
    end
  end
end
