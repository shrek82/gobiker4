#coding: utf-8
class Province < ActiveRecord::Base
  #attr_accessible :name,:pinyin,:group
  has_many :places
  has_many :routes
  has_many :cities

  #地域分布
  def self.group
    addrss_group=Array.new()
    addrss_group[1]="华北"
    addrss_group[2]="华东"
    addrss_group[3]="华中"
    addrss_group[4]="华南"
    addrss_group[5]="东北"
    addrss_group[6]="西南"
    addrss_group[7]="西北"
    return addrss_group
  end

  def to_s
    name
  end

end
