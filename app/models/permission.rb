class Permission < ActiveRecord::Base
  #attr_accessible :action, :description, :subject

  has_and_belongs_to_many :users
end
