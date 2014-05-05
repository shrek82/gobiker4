#coding: utf-8
class PlacesController < ApplicationController

  def index

    @recommended=Rails.cache.fetch('place_home_recommendeds', :expires_in => 30.minutes) do
      Place.get_recommended(6)
    end

    @places = Place.order(:id=>:asc).includes(:province,:city,:comments).paginate(:page => params[:page], :per_page => 12)

    @provinces=Array.new
    Province.group.each_with_index do |p,key|
      @provinces[key]=Province.where(:group => key).includes(:cities)
    end

    respond_to do |format|
      format.html
      format.json { render json: @places }
    end
  end

  #按省份查看
  def area
    @name=params[:name]
    @province=not_found do
      Province.find_by_pinyin(@name)
    end
    @hot_city=City.select("cities.id,cities.name,cities.pinyin,(select count(places.id) from places where places.city_id=cities.id) as places_count").where("cities.province_id=?",@province.id).order("places_count DESC").limit(10)
  end

  #按城市查看
  def city
    @name=params[:name]
    @city=not_found do
      City.find_by_pinyin(@name)
    end
    @hot_place=Place.base_field.hot.limit(6)
  end

  #显示目的地
  def show
    @place=Place.find(params[:id])
    @place.hits_num=@place.hits_num+1
    @place.save()
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
      format.xml { render xml: @place }
    end
  end


  #相册
  def photos
    @place=Place.find(params[:id])
    @album=Album.find_or_create_by(:place_id => @place.id, :name => @place.name+'相册')
    @photos=Photo.where(:album_id=>@album.id).paginate(:page => params[:page], :per_page =>20, :order => "photos.id DESC",:include => :user)
  end

  #添加记录
  def new
    @place = Place.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/1/edit
  def edit
    @place = Place.find(params[:id])
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(params[:place])

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render json: @place, status: :created, location: @place }
      else
        format.html { render action: "new" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /places/1
  # PUT /places/1.json
  def update
    @place = Place.find(params[:id])

    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place = Place.find(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end

    Mail.new({:to => 'mikel@test.lindsaar.net',
              'from' => 'bob@test.lindsaar.net',
              :subject => 'This is an email',
              :body => 'This is the body'})

  end

  #增加去过人数
  def wantgoto

    if logged_in?
      @want=WantToPlace.where(:place_id => params[:id], :user_id => current_uid)
      if @want.blank?
        WantToPlace.create(:place_id => params[:id], :user_id => current_uid)
      end
    end

    @place = Place.find(params[:id])
    if @place.update_attributes(:wantgoto_num => @place.wantgoto_num.to_i+1)
      respond :_format => 'json', :wantgoto_num => @place.wantgoto_num, :beengo_num => @place.beengo_num
    end
  end

  #增加去过人数
  def beento

    if logged_in?
      @been=BeenToPlace.where(:place_id => params[:id], :user_id => current_uid)
      if @been.blank?
        BeenToPlace.create(:place_id => params[:id], :user_id => current_uid)
      end
    end
    @place = Place.find(params[:id])
    if @place.update_attributes(:beengo_num => @place[:beengo_num].to_i+1)
      respond :_format => 'json', :wantgoto_num => @place.wantgoto_num, :beengo_num => @place.beengo_num
    end
  end

end