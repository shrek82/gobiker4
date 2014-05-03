class RenameEventSignsToActivitySigns < ActiveRecord::Migration
  def change
    rename_table :activity_sign, :activity_signs
  end
end
