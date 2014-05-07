#coding: utf-8
class CommentsController < ApplicationController

  before_filter :check_logged,:only => [:new,:create,:update,:edit]

  def index
    @comments = Comment.all
  end

  #获取一条或多条评论列表
  def list
    #conditions=Array.new
    #conditions << "name LIKE ?"
    #conditions << "%#{params[:q]}%"

    if params[:review]=='true'
      template="comments/review/list"
    elsif params[:topic]=='true'
      template="comments/topics/list"
    else
      template="comments/show"
    end

    conditions=Hash.new
    if params[:q]
      conditions.store 'content',params[:q]
    end

    if params[:place_id]
      conditions.store 'place_id',params[:place_id]
    end

    if params[:topic_id]
      conditions.store 'topic_id',params[:topic_id]
    end

    @comments=Comment.where(conditions).includes(:user).paginate(:page => params[:page], :per_page =>10)

    respond :template=>template,:comments => @comments, :layout => false

  end

  #获取一条评论内容
  def getone
    if params[:review]=='true'
      template="comments/review/list"
    elsif params[:topic]=='true'
      template="comments/topics/list"
    else
      template="comments/show"
    end
    @comment=Comment.find_by_id(params[:id])
    respond :template=>template,:comments => @comment, :layout => false
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  #发布评论
  def create
    @comment = Comment.new(comment_params)
    @comment[:user_id]=cookies[:uid]
    if @comment.save
      respond :success => '发表成功',:comment => @comment
    else
      respond :error => @comment.errors.full_messages
    end
  end

  #修改评论
  def update
    @comment = Comment.find(comment_params)

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:place_id,:topic_id,:route_id,:activity_id,:article_id,:album_id,:content,:userful_num)
  end

end
