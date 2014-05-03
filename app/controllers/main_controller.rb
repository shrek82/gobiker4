class MainController < ApplicationController
  def index
    #总数
    @places_count=Place.getCount
    @topics_count=Topic.count
    @asks_count=Asks.getCount
    #目的地点评
    @reviews_places=Comment.reviewsPlaces(10)
    @focus=Recommend.focus.cat('home').limit(5)
    @hot_place=Place.hot.limit(3)
    #骑行攻略
    @guides=Topic.guides(5)
    #热门板块
    @hot_forums=Forum.hot_forums(5)
    #热门话题
    @hots_topics=Topic.hot(5)
    #render :template => 'main/index_v1'
  end
end
