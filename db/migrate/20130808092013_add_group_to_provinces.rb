class AddGroupToProvinces < ActiveRecord::Migration
  def change
    add_column :provinces, :group, :integer
    add_column :provinces, :pinyin, :string
  end
end
