#coding: utf-8
class Admin::GuidesController < AdminController

  #目的地列表
  def index
    conditions=Array.new
    if params[:q]
      conditions << "name LIKE ?"
      conditions << "%#{params[:q]}%"
    end
    @guides=Guide.paginate(:page => params[:page], :per_page => 10, :conditions => conditions, :include => :user)
  end

  #添加记录
  def new
    @guide = Guide.new
  end

  #编辑记录
  def edit
    @guide = Guide.find(params[:id])
    @pics=(@guide.img_ids.blank?) ? [] : Photo.where(:id => @guide.img_ids.split(','))
  end

  #提交新建

  def create

    @guide = Guide.new(params[:guide])
    @guide.is_fixed=params[:is_fixed]
    @guide.is_recommended=params[:is_recommended]
    if @guide.save
      respond :redirect_to => admin_guides_path, :success => '目的地添加成功'
    else
      respond :action => 'new', :error => @guide.errors.full_messages
    end
  end

  #显示
  def show
  end

  #保存修改
  def update

    @guide = Guide.find(params[:id])
    @guide.is_fixed=params[:is_fixed]
    @guide.is_recommended=params[:is_recommended]
    if @guide.update_attributes(params[:guide])
      respond :redirect_to => admin_guides_path, :success => '资料修改成功'
    else
      respond :action => 'edit', :error => @guide.errors.full_messages
    end
  end

  #删除
  def destroy
    @guide = Guide.find(params[:id])
    @guide.destroy
    respond :redirect_to => admin_guides_path, :success => '资料删除成功'
  end

end