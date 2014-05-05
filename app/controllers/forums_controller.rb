#coding: utf-8
class ForumsController < ApplicationController
  def index

    #公共版块
    #@public=Rails.cache.fetch('forums_index_public', :expires_in => 30.minutes) do
    @public=Forum.where(:category_id => 1).order(:order_num=>:asc,:id=>:asc)
    @public.each do |f|
      f[:topics_num]=f.topics.count
    end
    #end

    #热门城市
    @hot_cities=Forum.select('forums.*,(select count(topics.id) from topics where topics.forum_id=forums.id) as topics_count').where(:category_id => 2).order('topics_count DESC').limit(12)
    @hot_cities.each do |f|
      f[:topics_num]=f.topics.count
    end

    @hot_cities2=Topic.select('topics.id,topics.forum_id,(select count()')

  end

  #显示某一个板块
  def show
    @forum= Forum.find(params[:id])

    #bug:开发环境下缓存文件需要先载入
    SubjectCategory
    #读取缓存
    @subject_categories=Rails.cache.fetch('topic_categories', :expires_in => 1.hours) do
      SubjectCategory.order('order_num ASC')
    end

    conditions=Array.new
    conditions << 'forum_id=?'
    conditions << params[:id]

    if params[:cid]
      conditions[0]+=' AND subject_id=?'
      conditions << params[:cid]
    end

    if params[:is_good]
      conditions[0]+=' AND is_good=?'
      conditions << true
    end
    @topics = Topic.base_field.where(conditions).includes([:user,:reply_user,:subject_category]).order('topics.is_fixed DESC,case when topics.last_comment_time IS NOT NULL then topics.last_comment_time when topics.last_comment_time IS NULL then topics.created_at end DESC').paginate(:page => params[:page], :per_page =>12)
    #@topics = Topic.base_field.where(:forum_id => params[:id]).includes(:user,:reply_user).kpage(params[:page]).per(1)

    #一周热帖
    @week_hots=Rails.cache.fetch('week_hots_forums'+params['id'].to_s, :expires_in => 3.hours) do
      Topic.base_field.where(:created_at =>Time.now-7.days..Time.now,:forum_id=>params[:id]).order('hits_num DESC').limit(5)
    end


  end

  def new
  end

  def create
  end

  def topic

  end

  def thread

  end

  #选择论坛发布板块
  def select_forums
    @last=Topic.select(:forum_id).group(:forum_id).includes(:forum).where(:user_id=>1).order("topics.id DESC")
    @public_forums=Forum.where(:category_id => 1).order("forums.order_num ASC,id ASC")
    @hot_cities=Forum.select('forums.*,(select count(topics.id) from topics where topics.forum_id=forums.id) as topics_count').where(:category_id => 2).order('topics_count DESC').limit(12)

    render :template => 'forums/select_forums', :layout => false
  end


end
