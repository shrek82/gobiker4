#coding: utf-8
module ApplicationHelper

  #hidden_field表单隐藏字段
  #options评论功能选项
  #query_param载入查询选项
  def comment_list(data={})
    @hidden_field=data[:hidden_field]
    @options=data[:options]||{}
    @query_param=data[:query_param]||{}
    #@request_param=request.query_parameters||{}
    if @query_param[:topic]
      template_path="comments/topics/listform"
    elsif @query_param[:review]
      template_path="comments/review/listform"
    else
      template_path="comments/listform"
    end
    return render template_path
  end

  def star_span(num=1, limit=5, default=4)
    num=default if num.nil?
    html='<span>'
    for i in 1..num
      html+='<img src="/images/poi_star.png">'
    end

    for i in 1..(limit-num)
      html+='<img src="/images/poi_star_null.png">'
    end

    raw html+'</span>'
  end

  def server_ip
    location = request.env["SERVER_ADDR"]
    render :text => "This server hosted at #{location}"
  end

  def title(_title)
    content_for :title do
      _title
    end
  end

  def metadesc(_metadesc)
    content_for :metadesc do
      _metadesc.gsub(/\r\n/, ' ').gsub(/['"]/, " ")
    end
  end

  def summary(_summary)
    content_for :summary do
      _summary.gsub(/\r\n/, ' ').gsub(/['"]/, " ")
    end
  end

  def h(_title)
    content_for :h do
      _title
    end
  end


  def render_stars(value)
    output = ''
    if (1..5).include?(value)
      value.times { output += '*' }
    end
    output
  end

  def to_pretty(time)
    a = Time.now.to_i-time.to_i
    case a
      when 0 then
        '刚刚'
      when 1 then
        '1秒前'
      when 2..59 then
        a.to_s+' 秒前'
      when 60..119 then
        '1分钟前' #120 = 2 minutes
      when 120..3540 then
        (a/60).to_i.to_s+'分钟前'
      when 3541..7100 then
        '1小时前' # 3600 = 1 hour
      when 7101..82800 then
        ((a+99)/3600).to_i.to_s+'小时前'
      when 82801..172000 then
        '1天前' # 86400 = 1 day
      when 172001..518400 then
        ((a+800)/(60*60*24)).to_i.to_s+'天前'
      when 518400..1036800 then
        '1星期前'
      else
        ((a+180000)/(60*60*24*7)).to_i.to_s+'星期前'
    end
  end

  #:class - CSS class name for the generated DIV (default: "pagination")
  #:previous_label - default: "« Previous"
  #:next_label - default: "Next »"
  #:page_links - when false, only previous/next links are rendered (default: true)
  #:inner_window - how many links are shown around the current page (default: 4)
  #:outer_window - how many links are around the first and the last page (default: 1)
  #:link_separator - string separator for page HTML elements (default: single space)
  #:param_name - parameter name for page number in URLs (default: :page)
  #:params - additional parameters when generating pagination links (eg. :controller => "foo", :action => nil)
  #:renderer - class name, class or instance of a link renderer (default in Rails: WillPaginate::ActionView::LinkRenderer)
  #:container - toggles rendering of the DIV container for pagination links, set to false only when you are rendering your own pagination markup (default: true)
  #All options not recognized by will_paginate will become HTML attributes on the container element for pagination links (the DIV). For example:

  def go_pager(record)
    will_paginate record, :page_links => true, :id => 'ui_page', :class => 'ui_page'
  end

  def cmt_pager(record)
    html=will_paginate record, :page_links => true, :id => 'ui_page', :class => 'ui_page'
    raw html.gsub(/href/, 'href="javascript:;" url') if html
  end

  #信息提示
  #有error错误优先显示，避免多次显示
  def block_alert(record=nil)
    js='<script type="text/javascript">closeFlashMsg();</script>'
    if record && record.errors.any?
      str='<div class="alert alert-block" id="flash_msg"> <button type="button" class="close" data-dismiss="alert">×</button><ul>'
      record.errors.full_messages.each do |msg|
        str+='<li>'+msg+'</li>'
      end
      str+='<ul></div>'
      str+=js
      flash[:success]=nil
      flash[:error]=nil
      flash[:notice]=nil
      return raw str
    elsif flash[:error]
      return raw '<div class="alert alert-block" id="flash_msg"> <button type="button" class="close" data-dismiss="alert">×</button> <strong></strong>'+flash[:error].to_s+'</div>'+js
    elsif flash[:success]
      return raw '<div class="alert alert-success" id="flash_msg"><button type="button" class="close" data-dismiss="alert">×</button> <strong></strong>'+flash[:success].to_s+'</div>'+js
    elsif flash[:notice]
      return raw '<div class="alert alert-block" id="flash_msg"> <button type="button" class="close" data-dismiss="alert">×</button>'+flash[:notice].to_s+'</div>'+js
    end
  end

  #自动显示省市区下拉菜单并选择
  def province_city_area_select(object, pid=nil, cid=nil, aid=nil)
    provinces=Province.all
    object_name="'"+object.to_s+"'"
    html='<select name="'+object.to_s+'[province_id]" id="provinces" onchange="get_cities(this.value,'+object_name+')" class="span2">'
    html+='<option>选择省份</option>'
    provinces.each do |p|
      selected=''
      selected='selected' if p.id==pid
      html+='<option value="'+p.id.to_s+'"'+selected+'>'+p.name+'</option>'
    end
    html+='</select>'

    #显示市
    html+='&nbsp;<span id="city_select">'
    if pid
      cities=City.where(:province_id => pid)
      html+='<select name="'+object.to_s+'[city_id]" id="cities" onchange="get_areas(this.value,'+object_name+')" class="span2">'
      html+='<option>选择县市</option>'
      cities.each do |c|
        selected=''
        selected='selected' if cid&&c.id==cid
        html+='<option value="'+c.id.to_s+'"'+selected+'>'+c.name+'</option>'
      end
      html+='</select>'
    end
    html+='</span>'

    #区
    html+='&nbsp;<span id="area_select">'
    if cid
      areas=Area.where(:city_id => cid)
      html+='<select name="'+object.to_s+'[area_id]" id="areas" class="span2">'
      html+='<option>选择区</option>'
      areas.each do |a|
        selected=''
        selected='selected' if aid&&a.id==aid
        html+='<option value="'+a.id.to_s+'"'+selected+'>'+a.name+'</option>'
      end
      html+='</select>'
    end
    html+='</span>'

    raw(html)
  end


  #显示省份下拉菜单
  def province_select(selected_id=0)
    provinces=Province.all
    html='<select name="province_id" id="provinces" onchange="get_cities(this.value)" class="span2">'
    html+='<option>选择省份</option>'
    provinces.each do |p|
      selected=''
      selected='selected' if p.id==selected_id
      html+='<option value="'+p.id.to_s+'"'+selected+'>'+p.name+'</option>'
    end
    raw(html+='</select>')
  end


  def img_style(path=nil, style='large')
    if path
      path.gsub(/_[\w]+\./, '_'+style+'.')
    else
      '/images/default_img_'+style+'.png'
    end
  end

  #显示附件照片
  def img_path(p={}, size='thumb')
    return '/uploads/photos/'+p[:created_at].strftime('%Y')+'/'+p[:created_at].strftime('%m%d')+'/'+p[:id].to_s+'_'+size+'.jpg'
  end

  def photo_path(p={}, size='thumb')
    return '/uploads/photos/'+p[:created_at].strftime('%Y')+'/'+p[:created_at].strftime('%m%d')+'/'+p[:id].to_s+'_'+size+'.jpg'
  end

end
