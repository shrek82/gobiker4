#coding: utf-8
#常用的查询
class CommonController < ApplicationController
  #省份菜单
  def provinces_select
    @provinces=Province.select("id,name").all
    @object=params[:object]
    respond_to do |format|
      format.html { render :layout => false }
      format.json { render json: @provinces }
      format.xml { render xml: @provinces }
    end
  end

  #县市下拉菜单
  def cities_select
    @object=params[:object]
    @cities=City.select("id,name").where(:province_id => params[:province_id]).all
    respond_to do |format|
      format.html { render :layout => false }
      format.json { render json: @cities }
    end
  end

  #区下拉菜单
  def areas_select
    @object=params[:object]
    @areas=Area.select("id,name").where(:city_id => params[:city_id]).all
    respond_to do |format|
      format.html { render :layout => false }
      format.json { render json: @areas }
    end
  end

end
