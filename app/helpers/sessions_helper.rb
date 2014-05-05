#coding:utf-8
module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  #是否登录
  def logged_in?
    cookies[:uid] && !cookies[:uid].blank? && cookies[:username]
  end

  #当前用户id
  def current_uid
    cookies[:uid]
  end

  #设置当前用户
  def current_user=(user)
    @current_user = user
  end

  #获取当前用户
  def current_user
    @current_user ||= User.find_by_id(cookies[:uid])
  end

  #是否为当前用户
  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !current_user.nil?
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "请先登录"
    end
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end
end