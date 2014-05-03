#coding: utf-8
class Attached < ActiveRecord::Base
  #attr_accessible :name, :is_verify,
  #                :img, :img_path, :img_content_type, :img_file_name, :img_file_size, :img_updated_at,
  #                :att, :att_content_type, :att_file_name, :att_file_size, :att_updated_at

  has_attached_file :img,
                    :styles => {:square => "80x80#", :mini => "100x100>", :thumb => "150x150>", :medium => "300x300>", :large => "600x600>", :original => "800x800>"},
                    :default_url => "/images/:style/missing.png",
                    :url => "/uploads/pics/:year/:month:day/:id_:style.:extension",
                    :path => ":rails_root/public/uploads/pics/:year/:month:day/:id_:style.:extension"
  validates_attachment_content_type :img, :content_type => ['image/gif', 'image/png', 'image/x-png', 'image/jpeg', 'image/pjpeg', 'image/jpg', 'application/octet-stream']

  has_attached_file :att,
                    :url => "/uploads/attacheds/:id/:id_:style.:extension",
                    :path => ":rails_root/public/uploads/attacheds/:id/:id_:style.:extension"

  #skip_before_filter :verify_authenticity_token

  after_create :set_img_path

  #私有方法
  private

  #添加后修改图片路径
  def set_img_path

    if self.img_file_name
      file_extension=self.img_file_name[/\.[a-z]{3,4}$/]
      img_path='/uploads/pics/'+self.img_updated_at.strftime('%Y')+'/'+self.img_updated_at.strftime('%m%d')+'/'+self.id.to_s+'_thumb'+file_extension
      update_attr={:img_path => img_path}
      self.update_attributes(update_attr)
    end

  end

end