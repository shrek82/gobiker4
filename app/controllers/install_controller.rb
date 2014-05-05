#coding: utf-8
#添加一些固定数据

class InstallController < ApplicationController

  include UsersHelper

  #初始化项目基本信息，如已经设置，则不会生效
  def setting
    Setting[:site_name] = '骑趣网' # 站点名称，如: Rabel
    Setting[:welcome_tip] = '欢迎访问<strong>Rabel</strong>' # 网站欢迎语, 支持html标签
    Setting[:splash] = '<div class="hero-unit"><h1>Rabel</h1><p>新一代简洁社区软件</p></div>'
    Setting[:ga_id] = '' # Google Analytics ID
    Setting[:default_search_engine] = 'google' # 默认搜索引擎，可从下面的搜索引擎列表中选择
    Setting[:seo_description] = 'Rabel - 新一代简洁社区软件' # SEO 描述
    Setting[:short_intro] = '新一代简洁社区软件' # 网站简短介绍, 显示在右侧边栏
    Setting[:footer] = '<p>&copy; 2012 Rabel</p>'
    Setting[:mobile_footer] = '&copy; 2012 Rabel'
    Setting[:custom_css] = '' # 全局自定义CSS
    Setting[:custom_js] = '' # 全局自定义JavaScript
    Setting[:custom_head_tags] = '' # 自定义Head标签
    Setting[:marketing] = ['Rails', 'PostgreSQL', 'BDD'] # 市场宣传关键字
    Setting[:pagination_topics] = "25"
    Setting[:pagination_comments] = "100"
    Setting[:nav_position] = 'bottom'
    Setting[:show_captcha] = 'off'
    Setting[:custom_logo] = ''
    Setting[:global_banner] = ''
    Setting[:theme] = 'rabel'
    Setting[:global_sidebar_block] = ''
    Setting[:show_community_stats] = 'on'
    Setting[:allow_markdown_in_topics] = 'off'
    Setting[:allow_markdown_in_comments] = 'off'
    Setting[:allow_markdown_in_pages] = 'on'
    Setting[:topic_editable_period_str] = '5'
    Setting[:reward_title] = '银币'
    Setting[:sticky_topics_heading] = '置顶话题'
    Setting[:latest_topics_heading] = '最新讨论'
    Setting[:topic_list_style] = 'complex'

    #推荐信息
    rec=Recommend.all
    if rec.blank?
      Recommend.create(:name => 'temp', :img_path => '/images/f6b7381ea54496ea1c667308c0d09048.jpg', :category => 'home', :redirect => '/places', :is_close => false)
      Recommend.create(:name => 'temp', :img_path => '/images/07834ff6939d50dc303cfbb3404d6c9a.jpg', :category => 'place', :redirect => '/places', :is_close => false)
      Recommend.create(:name => 'temp', :img_path => '/images/d8547d182c6e6460d7f9eb4c5ce84d54.jpg', :category => 'home', :redirect => '/places', :is_close => false)
      Recommend.create(:name => 'temp', :img_path => '/images/c74db7ecae909c9dd24c4b0168de5175.jpg', :category => 'place', :redirect => '/places', :is_close => false)
      Recommend.create(:name => 'temp', :img_path => '/images/fb4dcc4f8d5cc03502dfe2b29d23dbf9.jpg', :category => 'home', :redirect => '/places', :is_close => false)
    end

    #话题类型
    subject=SubjectCategory.all
    if subject.blank?
      SubjectCategory.create(:name => '话题', :order_num => 1)
      SubjectCategory.create(:name => '约伴', :order_num => 2)
      SubjectCategory.create(:name => '活动', :order_num => 3)
      SubjectCategory.create(:name => '游记', :order_num => 4)
      SubjectCategory.create(:name => '比赛', :order_num => 5)
    end

    #攻略类型
    guide_categorys=GuideCategory.all
    if guide_categorys.blank?
      categorys=[['分类一', 1], ['分类二', 2], ['分类三', 3]]
      categorys.each do |name, order_num|
        GuideCategory.create(name: name, order_num: order_num) do |c|
          c.created_at=Date.current.to_default_s
        end
      end
    end

    #模拟用户
    user=User.all
    if user.blank?
      %w[seeyoup hmily dongbeige zhaojg wanghao meis huahua tiantian xiang dong pei sheng fage lily yaoyao alan donghua xishi qiuyue guifei xiaoqiao].each do |key|
        email=key+'test@qq.com'
        code=generate_activecode(email)
        User.create(:username => key, :email => email, :password => '123456', :avatar_path => '/avatar/up.jpeg', :code => code)
      end
    end

    #话题板块
    forums=Forum.all
    if forums.blank?
      (1..15).each do |i|
        Forum.create(:name => '公共版块'+i.to_s, :intro => '公共交流区', :order_num => i, :category_id => 1, :ico_path => '/images/forum/default.jpg')
      end

      %w[杭州 无锡 苏州 上海 北京].each do |key|
        Forum.create(:name => key, :intro => key+'交流园地', :province_id => '330000', :city_id => '330100', :order_num => 1, :category_id => 2, :ico_path => '/images/forum/ljhk.jpg')
      end

      (1..3).each do |i|
        Forum.create(:name => '俱乐部'+i.to_s, :club_id => 1, :order_num => 1, :category_id => 3, :ico_path => '/images/forum/zj.jpg')
      end

      Forum.where(:id => 2).update_all(:ico_path => '/images/forum/fg.jpg')
      Forum.where(:id => 3).update_all(:ico_path => '/images/forum/jwyl.jpg')
      Forum.where(:id => 4).update_all(:ico_path => '/images/forum/jyt.jpg')
      Forum.where(:id => 5).update_all(:ico_path => '/images/forum/ljhk.jpg')
      Forum.where(:id => 6).update_all(:ico_path => '/images/forum/lxsy.jpg')
      Forum.where(:id => 7).update_all(:ico_path => '/images/forum/ozdg.jpg')
      Forum.where(:id => 8).update_all(:ico_path => '/images/forum/ozjt.jpg')
      Forum.where(:id => 9).update_all(:ico_path => '/images/forum/qyer.jpg')
      Forum.where(:id => 10).update_all(:ico_path => '/images/forum/jnd.jpg')
      Forum.where(:id => 12).update_all(:ico_path => '/images/forum/ldmz.jpg')
      Forum.where(:id => 14).update_all(:ico_path => '/images/forum/mg.jpg')
      Forum.where(:id => 15).update_all(:ico_path => '/images/forum/nbe.jpg')
      Forum.where(:id => 16).update_all(:ico_path => '/images/forum/xxl.jpg')
      Forum.where(:id => 17).update_all(:ico_path => '/images/forum/xy.jpg')
      Forum.where(:id => 18).update_all(:ico_path => '/images/forum/ydnxy.jpg')
      Forum.where(:id => 19).update_all(:ico_path => '/images/forum/zgnd.jpg')
      Forum.where(:id => 20).update_all(:ico_path => '/images/forum/zy.jpg')

    end

    #管理员
    manager=Manager.all
    if manager.blank?
      Manager.create(email: 'seeyoup@qq.com', name: 'admin', password: '1234567', role: 'admin')
    end

    #华北
    Province.where("name like '%辽宁%' OR name like '%吉林%' OR name like '%黑龙江%'").update_all(:group => 1)
    #华东
    Province.where("name like '%山东%' OR name like '%江苏%' OR name like '%安徽%' OR name like '%浙江%' OR name like '%台湾%' OR name like '%福建%' OR name like '%江西%' OR name like '%上海%'").update_all(:group => 2)
    #华中
    Province.where("name like '%河南%' OR name like '%湖北%' OR name like '%湖南%'").update_all(:group => 3)
    #华南
    Province.where("name like '%广东%' OR name like '%广西%' OR name like '%海南%' OR name like '%香港%' OR name like '%澳门%'").update_all(:group => 4)
    #东北
    Province.where("name like '%河北%' OR name like '%山西%' OR name like '%内蒙古%' OR name like '%北京%' OR name like '%天津%'").update_all(:group => 5)
    #西南
    Province.where("name like '%云南%' OR name like '%贵州%' OR name like '%四川%' OR name like '%西藏%'").update_all(:group => 6)
    #西北
    Province.where("name like '%新疆%' OR name like '%陕西%' OR name like '%宁夏%' OR name like '%青海%' OR name like '%甘肃%'").update_all(:group => 7)

  end


end
