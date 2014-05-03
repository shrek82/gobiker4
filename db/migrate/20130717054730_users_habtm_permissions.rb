#class UsersHabtmPermissions < ActiveRecord::Migration
#  def up
#  end
#
#  def down
#  end
#end

class UsersHabtmPermissions < ActiveRecord::Migration
  def up
    create_table :permissions_users, :id => false do |t|
      t.references :permission
      t.references :user
    end
    add_index :permissions_users, [:user_id, :permission_id]
    add_index :permissions_users, [:permission_id, :user_id]
  end

  def down
    drop_table :permissions_users
  end
end