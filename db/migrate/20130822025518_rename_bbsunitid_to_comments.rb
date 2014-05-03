class RenameBbsunitidToComments < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.rename :bbs_unit_id, :topic_id
    end
  end
end
