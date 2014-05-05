class BeenToPlace < ActiveRecord::Base
  #attr_accessible :place_id, :user_id
  belongs_to :place
  belongs_to :user

  validates_presence_of :place_id
  validates_presence_of :user_id

  default_scope {order('`been_to_places`.id DESC')}

end
