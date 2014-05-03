class RenameColumnEventIdToActivityId < ActiveRecord::Migration
  rename_column :albums, :event_id, :activity_id
  rename_column :comments, :event_id, :activity_id
end
