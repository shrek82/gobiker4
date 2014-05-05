#coding: utf-8
class Admin::RecommendsController < AdminController

  #目的地列表
  def index
    conditions=Array.new
    if params[:q]
      conditions << "name LIKE ?"
      conditions << "%#{params[:q]}%"
    end
    @recommends=Recommend.paginate(:page => params[:page], :per_page => 10, :conditions => conditions)

  end

  #添加记录
  def new
    @recommend = Recommend.new
  end

  #编辑记录
  def edit
    @recommend = Recommend.find(params[:id])
    @pics=(@recommend.img_ids.blank?)?[]:Attached.where(:id=>@recommend.img_ids.split(','))
  end

  #提交新建
  def create
    @recommend = Recommend.new(params[:recommend])
    if @recommend.save
      respond :redirect_to => admin_recommends_path, :success =>I18n.t('activerecord.models.recommend')+'添加成功'
    else
      #render :text => @place.errors.full_messages
      respond :action => 'new', :error => @recommend.errors.full_messages
    end
  end

  #保存修改
  def update
    @recommend = Recommend.find(params[:id])
    if @recommend.update_attributes(params[:recommend])
      respond :redirect_to => admin_recommends_path, :success => '资料修改成功'
    else
      respond :action => 'edit', :error => @recommend.errors.full_messages
    end
  end

  #删除
  def destroy
    @recommend = Recommend.find(params[:id])
    @recommend.destroy
    respond :redirect_to => admin_recommends_path, :success => '资料删除成功'
  end

end