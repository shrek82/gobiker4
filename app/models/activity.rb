#coding: utf-8
class Activity < ActiveRecord::Base
  #attr_accessible :address,:topic_id,:category_id,:content, :finish_at,:is_allow_everyone,:is_stop_sign, :is_suspend, :sign_finish_at, :sign_limit, :sign_start_at, :signed_num, :start_at

  after_create :create_album
  belongs_to :topic


  private

  def create_album
    Album.create(:name=>'活动相册',:activity_id=>self.id)
  end
end
