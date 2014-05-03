class Together < ActiveRecord::Base
  #attr_accessible :content, :finish_at, :is_closed, :sign_finish_at, :sign_limit, :sign_start_at, :start_at, :topic_id,:address
  belongs_to :topic
end
