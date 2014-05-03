class AddPinyinToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :pinyin, :string
    add_column :areas, :order_num, :integer
  end
end
