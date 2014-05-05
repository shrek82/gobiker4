#conding:utf-8
class Admin::MainController < AdminController
  #相关统计
  def index
    @users=User.count
    @places=Place.count
    @comments=Comment.count
  end
end
