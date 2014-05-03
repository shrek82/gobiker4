#coding: utf-8
#rake db:migrate VERSION=20130823032537_change_column_default.rb
class ChangeColumnDefault < ActiveRecord::Migration

  def change

    change_table :topics do |t|
      t.change_default(:is_fixed,false)
      t.change_default(:is_comment,false)
      t.change_default(:is_good,false)
      t.change_default(:is_recommend,false)
      t.change_default(:hits_num,0)
      t.change_default(:comments_num,0)
      #t.change(:is_comment, :string, :limit => 8,:default=>true)
    end

    #or
    change_column_default(:topics,:comments_num,0)

  end
end
