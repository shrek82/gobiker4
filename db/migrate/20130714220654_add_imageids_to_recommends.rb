class AddImageidsToRecommends < ActiveRecord::Migration
  def change
    add_column :recommends, :img_ids, :string
  end
end
