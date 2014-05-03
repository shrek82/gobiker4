#coding: utf-8
#rails g  migration  add_fieldone_to_place tags:string category_id:integer img_path:string banner_path:string
class Place < ActiveRecord::Base
  #有这个字段的不管什么时候都有用id排序,很讨厌
  #default_scope :order => 'id'
  #字段白名单，可以通过parrt[:place]
  #会影响rake db:seed数据导入
  #attr_accessible相当于是白名单，定义哪些属性可以被mass assignment（大量赋值）
  #attr_accessible :name, :content, :tags, :category_id, :img_path, :img_ids, :province_id, :city_id, :area_id, :address, :is_recommended,:is_fixed, :interested_num, :favorites_num, :hits_num, :good_num, :intro, :content, :user_id,:wantgoto_num,:beengo_num

  #黑名单
  #
  #attr_protected :is_recommended, :interested_num, :favorites_num, :hits_num, :good_num

  #不允许为空
  validates_presence_of :content, :message => '不能为空'
  validates_presence_of :address,:text => '地址'
  validates_presence_of :intro,:text => '简介'
  validates_length_of :name,:in => (2..30), :message => '不能少于2个字符'
  validates_length_of :intro,:maximum => 250
  validates_presence_of :province_id,:text => '省份'
  validates_presence_of :city_id,:text => '所在地区'


  #validates_format_of :name, :with => /^[\w\.]+$/,
  #一般查询预览字段
  scope :base_field, select("places.id,places.name,places.img_path,places.rating")
  #范围快捷设置
  scope :recommended, where(:is_recommended => true)
  #用户信息
  scope :join_user, select("users.username").joins("LEFT JOIN users ON users.id=places.user_id")
  #地址位置信息
  scope :join_city, select("provinces.name,cities.name").joins("LEFT JOIN provinces ON provinces.id=places.province_id LEFT JOIN cities ON cities.id=places.city_id")
  #查询
  scope :search, lambda { |k, a| where('places.name like ? OR places.name like ?', "%#{k}%", "%#{a}%") }
  #热门目的地
  scope :hot, order('hits_num DESC')

  #自动创建一个相册
  after_create :create_album
  after_update :update_album

  default_scope :order => '`places`.id DESC'

  #还可以这样追加model的方法
  def self.fixed
    where(:is_fixed => true)
  end

  #学习笔记
  #不验证
  #Place.save(:validate => false)

  belongs_to :user
  belongs_to :province
  belongs_to :city
  has_many :comments
  has_many :been_to_places
  has_many :want_to_places
  has_many :albums

  #获取目的地总数
  def self.getCount()
    Place.count()
  end

  #获取记录
  def self.get(*args)
    options = args.extract_options!
    puts "Arguments:  #{args.inspect}"
    puts "Options:    #{options.inspect}"
    get(1, 2)
    get(1, 2, :a => :b)
  end

  #推荐目的地
  def self.get_recommended(limit=6, options={})
    def_opt={:select => 'id,name,img_path,beengo_num,province_id,city_id', :where => ["is_recommended=?", true], :order => 'id DESC'}
    opt=def_opt.merge! options
    Place.select(opt[:select]).where(opt[:where]).includes(:province,:city).limit(limit).order(opt[:order])
  end

  private

  #创建新相册并保存图片
  def create_album
    album=Album.new
    album.name=self.name+'相册'
    album.place_id=self.id
    album.order_num=1
    album.cover_path=self.img_path if self.img_path
    if album.save && self.img_ids
      Photo.where(:id => img_ids.split(/,/)).update_all(:album_id => album.id)
    end
  end

  def update_album
    if self.img_ids && self.img_ids
      album=Album.find_or_create_by_place_id(self.id, :place_id => self.id, :name => self.name+'相册', :order_num => 1, :cover_path => self.img_path)
      album.update_attributes(:cover_path=>self.img_path)
      if self.img_ids
        Photo.where(:id => img_ids.split(/,/)).update_all(:album_id => album.id)
      end
    end
  end


end
