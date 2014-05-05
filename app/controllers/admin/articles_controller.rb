#coding: utf-8
class Admin::ArticlesController < AdminController

  #目的地列表
  def index
    conditions=Array.new
    if params[:q]
      conditions << "name LIKE ?"
      conditions << "%#{params[:q]}%"
    end
    @articles=Article.paginate(:page => params[:page], :per_page => 10, :conditions => conditions, :include => :user)
  end

  #添加记录
  def new
    @article = Article.new
  end

  #编辑记录
  def edit
    @article = Article.find(params[:id])
    @pics=(@article.img_ids.blank?) ? [] : Photo.where(:id => @article.img_ids.split(','))
  end

  #提交新建

  def create

    @article = Article.new(params[:article])
    if @article.save
      respond :redirect_to => admin_articles_path, :success => '目的地添加成功'
    else
      respond :action => 'new',:error => @article.errors.full_messages
    end
  end

  #显示
  def show
  end

  #保存修改
  def update

    @article = Article.find(params[:id])
    @article.is_fixed=params[:is_fixed]
    @article.is_recommended=params[:is_recommended]
    if @article.update_attributes(params[:article])
      respond :redirect_to => admin_articles_path, :success => '资料修改成功'
    else
      respond :action => 'edit', :error => @article.errors.full_messages
    end
  end

  #删除
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond :redirect_to => admin_articles_path, :success => '资料删除成功'
  end

end


