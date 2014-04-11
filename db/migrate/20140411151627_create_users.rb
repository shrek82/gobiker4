class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, limit: 50
      t.string :password, limit: 70
      t.string :email, limit: 80
      t.string :avatar_path, limit: 150
      t.string :memo
      t.string :signatures
      t.integer :point
      t.datetime :reg_date
      t.datetime :login_date

      t.timestamps
    end
  end
end
