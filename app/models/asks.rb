class Asks < ActiveRecord::Base
  #attr_accessible :answers_num, :base_answer_id, :city_integer, :hits_num, :intro, :is_fixed, :is_recommended, :is_resolved, :province_id, :tags, :title, :useful_num, :user_id
  def self.getCount
    Asks.count()
  end
end
