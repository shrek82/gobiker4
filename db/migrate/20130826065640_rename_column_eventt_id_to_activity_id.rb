class RenameColumnEventtIdToActivityId < ActiveRecord::Migration
  rename_column :activity_signs, :event_id, :activity_id
end
