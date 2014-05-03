class GuideCategory < ActiveRecord::Base
  #attr_accessible :img_path, :name, :order_num
  has_many :guides
end
