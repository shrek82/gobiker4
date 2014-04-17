class Forum < ActiveRecord::Base
  include RailsSettings::Extend
  has_many :topics
end
