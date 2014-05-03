class RenameThreadsToTopics < ActiveRecord::Migration
  def change
    rename_table :threads, :topics
  end
end