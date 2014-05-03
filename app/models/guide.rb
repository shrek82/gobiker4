class Guide < ActiveRecord::Base
  #attr_accessible :category_id, :comments_num, :content, :hits_num, :img_ids, :img_path, :intro, :is_fixed, :is_recommended, :source, :tags, :title, :useful_num, :user_id
  belongs_to :guide_category
  belongs_to :user

  after_initialize do
    self.comments_num ||= 0
    self.hits_num ||= 0
    self.useful_num ||= 0
    self.is_fixed ||= 0
    self.is_recommended ||= 0
  end


end
