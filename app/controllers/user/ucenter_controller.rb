#coding: utf-8
class User::UcenterController < ApplicationController
  before_filter :logged_in?
  #skip_before_action :require_login, only: [:new, :create]
  private
  def logged_in?
     #@current_user=User.find_by_id(session[:uid])
     @current_user=User.find_by_id(2)
     if @current_user.blank?
       redirect_to login_path
     end
  end

end