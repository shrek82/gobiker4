#coding: utf-8
class ApplicationController < ActionController::Base

  #利用保存在cookie中的_csrf_token字段来生成自动添加在form中的隐藏字段_authenticity_token，然后利用_authenticity_token来实现CSRF的功能。
  protect_from_forgery

  #引入授权助手
  #cancan中的can?方法会调用current_user方法获取用户信息
  include SessionsHelper, CommonHelper

  #根据get参数自动设置多语言版
  before_filter :set_locale

  def not_found(&block)
    record=yield
    if record.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404
    else
      return yield
    end
  end

  #cancan认证方式三，认证整个项目
  #check_authorization

  def set_locale
    # 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
    if params[:locale] && I18n.available_locales.include?(params[:locale].to_sym)
      session[:locale] = params[:locale]
    end
    I18n.locale = session[:locale] || I18n.default_locale
  end

  #自动捕获所有错误(并提示友好提示)
  #CanCan::AccessDenied异常需要使用Cancan gem
  #rescue_from Exception do |exception|
  #  Rails.logger.info '----------------------------------------------'
  #  Rails.logger.info exception.message
  #  #ExceptionMailer.send_message(exception).deliver
  #  Rails.logger.info '----------------------------------------------'
  #
  #  case exception
  #    when ActiveRecord::RecordNotFound
  #      render :file => "#{Rails.root}/public/404.html", :status =>404
  #    when CanCan::AccessDenied
  #      render :file => "#{Rails.root}/public/403.html", :status =>403
  #    else
  #      render :file => "#{Rails.root}/public/500.html", :status => 500, :layout => false
  #  end
  #end

  #判断是否登录，并自动跳转登录页面或提示
  def check_logged

    unless logged_in?
      respond :redirect_to=>'/login',:error=>'很抱歉，您还没有登录！'
    end
  end


end
