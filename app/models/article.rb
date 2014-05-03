class Article < ActiveRecord::Base
  #attr_accessible :category_id, :comments_num, :content, :hits_num, :img_ids, :img_path, :intro, :is_fixed, :is_recommended, :source, :tags, :title, :useful_num, :user_id
  belongs_to :article_category
  belongs_to :user

  after_initialize do
    self.comments_num ||= 0
    self.hits_num ||= 0
    self.useful_num ||= 0
    self.is_fixed ||= false
    self.is_recommended ||= false
  end

end
