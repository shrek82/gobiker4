#coding: utf-8
class Admin::OptionsController < ApplicationController
  # GET /admin/options
  # GET /admin/options.json
  def index
    @admin_options = Admin::Option.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_options }
   end
end

  # GET /admin/options/1
  # GET /admin/options/1.json
def show
  @admin_option = Admin::Option.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_option }
end
end

  # GET /admin/options/new
  # GET /admin/options/new.json
def new
  @admin_option = Admin::Option.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_option }
end
end

  # GET /admin/options/1/edit
def edit
  @admin_option = Admin::Option.find(params[:id])
  end

  # POST /admin/options
      # POST /admin/options.json
      def create
        @admin_option = Admin::Option.new(params[:admin_option])

    respond_to do |format|
      if @admin_option.save
        format.html { redirect_to @admin_option, notice: 'Option was successfully created.' }
        format.json { render json: @admin_option, status: :created, location: @admin_option }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/options/1
  # PUT /admin/options/1.json
        def update
          @admin_option = Admin::Option.find(params[:id])

    respond_to do |format|
      if @admin_option.update_attributes(params[:admin_option])
              format.html { redirect_to @admin_option, notice: 'Option was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
        format.json { render json: @admin_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/options/1
  # DELETE /admin/options/1.json
          def destroy
            @admin_option = Admin::Option.find(params[:id])
    @admin_option.destroy

    respond_to do |format|
      format.html { redirect_to admin_options_url }
            format.json { head :no_content }
          end
          end
          end
          