class AddUserfulToComments < ActiveRecord::Migration
  def change
    add_column :comments, :userful_num, :integer
  end
end
