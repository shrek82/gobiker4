#coding: utf-8
class Recommend < ActiveRecord::Base
  #attr_accessible :hits, :img_path,:img_ids, :intro, :is_close, :is_fixed, :name, :order_num, :redirect, :category
  validates_presence_of :name
  validates_presence_of :redirect
  validates_presence_of :category
  #validates_format_of :redirect,:with =>/(^$)|(^(http|https)://[a-z0-9] ([-.]{1}[a-z0-9] )*.[a-z]{2,5}(([0-9]{1,5})?/.*)?$)/ix
  #validates_format_of  :email, :message => "邮箱格式不正确!", :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  #在rails的model中，生产环境中是缓存类的，比如一个Country模型中定义一个常量表示所有的国家（当model加载的时候将会做Country.all查询）
  ALL_CATEGORY={:home => '首页', :place => '目的地', :route => '路线'}

  #幻灯片
  scope :focus,-> {select("id,name,img_path,redirect,category").order('is_fixed DESC,order_num ASC,id DESC')}
  #scope :focus,select("id,name,img_path,redirect,category").where("is_close=?",false).order('is_fixed DESC,order_num ASC,id DESC')
  #rails3写法
  #scope :cat,lambda { |category| where("category=?",category)}
  #rails4写法
  scope :cat, ->(category) { where(:category => category) }

  before_save :set_boolean

  private
  def set_boolean
  end

end
