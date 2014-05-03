class AddSignaturesToUser < ActiveRecord::Migration
  def change
    add_column :users, :signatures, :string
  end
end
