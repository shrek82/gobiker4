class AddFieldtfurToPlace < ActiveRecord::Migration
  def change
    add_column :places, :source, :string
    add_column :places, :been_num, :integer
    add_column :places, :interested_num, :integer
    add_column :places, :favorites_num, :integer
    add_column :places, :hits_num, :integer
    add_column :places, :good_num, :integer
    add_column :places, :is_recommended, :boolean
    add_column :places, :is_fixed, :boolean
    add_column :places, :map, :string
  end
end
