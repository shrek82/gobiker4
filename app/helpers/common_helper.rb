#encoding:utf-8
module CommonHelper

  #查找记录,不存在返回错误页面
  def find_record(&block)
  end

  #上一页地址
  def previous_url
    link=(request.env["HTTP_REFERER"].blank?)?"/":request.env["HTTP_REFERER"]
  end

#是否为ajax请求
  def is_ajax?
    request.xhr?
  end

#结束输出到客户端
  def respond(options={})

    #合并渲染参数
    data={:layout => (is_ajax?) ? false : true,
          :status => 200,
          :notice=>nil,
    }.merge options

    #约定：
    #非ajax请求除非指定，否则均返回html格式
    #ajax格式除非指定，否则均返回json格式

    #自定获取请求方式
    if !is_ajax?
      flash[:success]=data[:success] if data[:success]
      flash[:error]=data[:error] if data[:error]
    end

    #指定其他格式
    if data[:_format]
      format=data[:_format]
    elsif params[:_format]
      format=params[:_format]
    elsif data[:text]
      format='text'
    elsif data[:json]
      format='json'
    elsif is_ajax?
      format='json'
    else
      format='html'
    end


    #普通方式请求且指定运行结束后跳转，优先进行跳转
    if format=='html'
      render_opt={:action => data[:action]} if data[:action]
      render_opt={:template => data[:template]} if data[:template]
      render_opt={:html => true} if (data[:action].nil? && data[:template].nil?)
      #输出json格式结果
    elsif format=='json'
      render_opt={:json => data}
      #输出xml格式代码
    elsif format=='xml'
      render_opt={:xml => data.to_xml}
      #输出纯文本格式格式
    elsif format=='text'
      render_opt={:text => data[:text]}
      #不输出任何内容
    else
      render_opt={:nothing => true}
    end

    if data[:redirect_to] && !is_ajax?
      redirect_to data[:redirect_to],:notice => data[:notice]
    else
      render render_opt.merge({layout: data[:layout], status: data[:status]})
    end

  end

#自动转换链接
  def auto_link(mystr)
    require 'uri'
    x = URI.extract(mystr, ['http', 'https', 'ftp'])
    x.each do |e|
      #Because parenthesis will be treated as url ,but no one use it.So it gsub all ().If I do not do it, this method will exception:unmatched close parenthesis
      m = mystr.match(/( [^ \n]*)#{e.gsub(/[()]/, '')}/)
      e_pic = e.match(/.*.(png|jpg|jpeg|gif)/i)
      unless e_pic
        if !m.nil? and m[1].to_s.strip != ""
          g = "<a href='#{e}' target='_blank'>#{m[1]}</a>"
          mystr = mystr.sub(m[0], g)
        else
          g = " <a href='#{e}' target='_blank'>#{e}</a>"
          mystr = mystr.sub(e, g)
        end
      end
    end
    mystr
  end

  def auto_img(mystr)
    require 'uri'
    x = URI.extract(mystr, ['http'])
    x.each do |e|
      m = e.match(/.*.(png|jpg|jpeg|gif)/i)
      if m
        g = "<div style='text-align:center'><img src='#{m}'/></div>"
        mystr = mystr.sub(m[0], g)
      end
    end
    mystr
  end

  def auto_emotion(mystr)
    emotions = emotions_hash
    reg_str = ""
    emotions.each_with_index do |(id), i|
      reg_str += t("emotions.t#{id}")
      reg_str += "|" if i < emotions.size - 1
    end
    m = mystr.scan(/\/(#{reg_str})/m)
    m.uniq.each do |e|
      mystr = mystr.gsub("/#{e[0]}", "<img src=\"http://mystory.b0.upaiyun.com/images/emotions/#{emotions.invert[e[0]]}.gif\" alt=\"/#{e[0]}\" title=\"/#{e[0]}\">")
    end
    mystr
  end

  def ignore_emotions(mystr)
    emotions = emotions_hash
    reg_str = ""
    emotions.each_with_index do |(id), i|
      reg_str += t("emotions.t#{id}")
      reg_str += "|" if i < emotions.size - 1
    end
    m = mystr.scan(/\/(#{reg_str})/m)
    m.uniq.each do |e|
      mystr = mystr.gsub("/#{e[0]}", "(#{e[0]})")
    end
    mystr
  end

  def photos_count(mystr)
    m = mystr.scan(/(\+photo(\d{2,})\+)/m)
    m.size
  end

end
