class Avatar < ActiveRecord::Base
  #attr_accessible :img, :img_content_type, :img_file_name, :img_file_size, :img_path, :img_updated_at, :user_id
  has_attached_file :img,
                    :styles => {:small=>"50x50#",:thumb => "120x120#",:original => "200x200#"},
                    :default_url => "/images/:style/face.png",
                    :url => "/avatar/:year/:month:day/:id_:style.:extension",
                    :path => ":rails_root/avatar/:year/:month:day/:id_:style.:extension"
  validates_attachment_content_type :img, :content_type => ['image/gif', 'image/png', 'image/x-png', 'image/jpeg', 'image/pjpeg', 'image/jpg','application/octet-stream']
  belongs_to :user

  after_create :set_img_path

  private

  #添加后修改图片路径
  def set_img_path
    file_extension=self.img_file_name[/\.[a-z]{3,4}$/]
    img_path='/avatar/'+self.img_updated_at.strftime('%Y')+'/'+self.img_updated_at.strftime('%m%d')+'/'+self.id.to_s+'_thumb'+file_extension
    update_attr={:img_path=>img_path}
    update_attr.store('title',self.img_file_name.sub(/\.[a-z]{3,4}$/,'')) if self.title.nil?
    self.update_attributes(update_attr)
  end

end
