#coding: utf-8

class UserMailer < ActionMailer::Base

  default from: "hmilyo2008@163.com"

  def welcome_email(data={})
    @data=data
    mail(:to => @data[:email],:subject =>@data[:subject])
  end

  def activation_mail(data={})
    @data=data
    mail(:to => @data[:email],:subject =>@data[:subject])
  end
end
