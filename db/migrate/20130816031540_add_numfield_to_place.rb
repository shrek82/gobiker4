class AddNumfieldToPlace < ActiveRecord::Migration
  def change
    add_column :places, :wantgoto_num, :integer
    add_column :places, :beengo_num, :integer
  end
end
