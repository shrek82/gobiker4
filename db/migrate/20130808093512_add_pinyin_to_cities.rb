class AddPinyinToCities < ActiveRecord::Migration
  def change
    add_column :cities, :pinyin, :string
  end
end
