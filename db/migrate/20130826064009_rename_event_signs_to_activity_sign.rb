class RenameEventSignsToActivitySign < ActiveRecord::Migration
  def change
    rename_table :event_signs, :activity_sign
  end
end
