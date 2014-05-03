#coding: utf-8
class PhotosController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:upload]
  
  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @place_id=
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  #上传图片
  def upload
    @photo = Photo.new(params[:photo])
    @photo.user_id=1
    if @photo.save
      file_extension=@photo.img_file_name[/\.[a-z]{3,4}$/]
      file_path="/uploads/photos/"+@photo[:created_at].strftime('%Y').to_s+'/'+@photo[:created_at].strftime('%m%d').to_s+'/'+@photo[:id].to_s+"_thumb"+file_extension
      respond :state=>'SUCCESS',:url=>file_path,:file_id => @photo[:id], :fileName => @photo[:img_file_name],:fileType=>@photo[:img_content_type],:fileSize => @photo[:img_file_size], :success => '资料修改成功'
    else
      respond :error=>@photo.errors.full_messages, :status=>500
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = Photo.find(photo_params)

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end

  private

# Use strong_parameters for attribute whitelisting
# Be sure to update your create() and update() controller methods.

  def photo_params
    params.require(:photo).permit(:img)
  end


end
          