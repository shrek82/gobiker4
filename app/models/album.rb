class Album < ActiveRecord::Base
  #attr_accessible :club_id, :cover_path, :activity_id, :hits_num, :is_close, :is_recommended, :name, :order_num, :pics_num, :place_id, :tags, :user_id
  belongs_to :place
  belongs_to :user
  belongs_to :club
  belongs_to :activity

  has_many :photos

  after_initialize do
    self.club_id||=0
    self.activity_id||=0
    self.place_id||=0
    self.hits_num||=0
    self.user_id||=0
    self.is_close||=false
    self.is_recommended||=false
  end
end
