#coding: utf-8
#1. 多个部分统一运行：
#rake test
#rake test:units
#rake test:funtionals

#2. 单独测试某个文件
#rake test:units TEST=test/unit/some_test.rb

class UsersController < ApplicationController

  include UsersHelper

  layout "login_register", :only => [:register, :login]

  #注册
  def register
    #验证并继续注册过程
    if request.method=='GET' && params[:act] && params[:code]
      @act=params[:act]
      @code=params[:code]
      if @code!=generate_activecode(@act)
        flash[:error]='很抱歉，激活失败，请检查验证码!'
      else
        flash[:success]='恭喜您，您的邮箱已经验证通过'
      end
    #正式注册
    elsif request.method=='POST' && params[:user]
      @user =User.new(params[:user])
      if @user.save
        cookies[:uid]=@user[:uid]
        cookies[:email]=@user[:email]
        cookies[:username]=@user[:username]
        respond :redirect_to => main_path, :success => '恭喜您注册成功!'
      else
        respond :action => 'register', :error => @user.errors.full_messages
      end
    end
  end

  #获取当前用户信息
  def check_user
    if cookies[:uid] && cookies[:email] && cookies[:username]
      @user=User.find_by_id(cookies[:uid])
      if @user.blank?
        cookies[:uid]=nil
        cookies[:email]=nil
        cookies[:username]=nil
      end
    else
      @user=nil
    end
    render :layout => false
  end

  #登录
  def login

    if request.method=='POST'
      u=User.login params[:login]
      if u[:error]
        cookies[:uid]=nil
        cookies[:email]=nil
        cookies[:username]=nil
        respond :error => u[:error]
      elsif u[:uid]
        cookies[:uid]=u[:uid]
        cookies[:email]=u[:user][:email]
        cookies[:username]=u[:user][:username]
        respond :uid => u[:uid],:username=>u[:user][:username],:success => '登录成功!'
      end
    end
  end

  def logout
    cookies[:uid]=nil
    cookies[:email]=nil
    cookies[:username]=nil
    respond :redirect_to => '/'
  end

  #注册验证
  def ajax
    @email=params[:email]
    @act=params[:act]
    @username=params[:username]

    #验证帐号是否被注册
    if @email && @act=='checkemail'
      user=User.exists?(:email=>@email)
      if user
        respond :error => '该帐号已经被注册了!', :_format => 'json'
      else
        respond :success => '帐号可以使用!', :_format => 'json'
      end
      #发送激活邮件，返回提示窗口
    elsif @email && (@act=='sendmail'||@act=='resentcode')
      mail_data={:email => @email,
                 :subject => "骑趣网———注册激活邮件",
                 :url => "http://"+request.host_with_port+"/register?act="+@email+"&code="+generate_activecode(@email)
      }
      UserMailer.activation_mail(mail_data).deliver
      @mail_domain=@email.split("@")[1]
      @mail_domain=@mail_domain=='gmail.com'?'www.gmail.com':"mail."+@mail_domain
      respond :action => 'reg_active_mail', :layout => false
      #检查用户名是否被注册
    elsif @act=='checkusername' && @username
      user=User.find_by_username(@username)
      if user
        respond :error => '该用户名已经被使用了!', :_format => 'json'
      else
        respond :success => '用户名可以使用!', :_format => 'json'
      end
    else
      respond :_format => 'json', :error => '非法请求', :status => 403
    end

  end

  def minilogin
    render :template => 'users/mini_login', :layout => false
  end


  #管理员授权并
  #获得authorize_url并引到至授权页面
  def new_binding
    client = WeiboOAuth2::Client.new
    authorize_url = client.authorize_url
    redirect_to authorize_url
  end

  #返回授权结果
  #当用户拒绝授权时，浏览器会重定向到redirect_uri，并附加错误信息
  #当用户同意授权时，浏览器会重定向到redirect_uri，并附加autorization_code
  #注意：此请求必须是HTTP POST方式 例如：
  def callback
    client = WeiboOAuth2::Client.new
    #使用未授权的Request token获取Access token
    access_token = client.auth_code.get_token(params[:code].to_s)
    #授权用户id
    session[:uid] = access_token.params["uid"]
    #用户令牌
    session[:access_token] = access_token.token
    #周期
    session[:expires_at] = access_token.expires_at

    #使用授权的Access token获取用户信息
    @user = client.users.show_by_uid(session[:uid].to_i)
    redirect '/'
  end

  def authenticate
  end


end
