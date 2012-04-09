# coding: UTF-8
class Rforum::Cpanel::LocationsController < Rforum::Cpanel::ApplicationController

  def index
    @locations = Ruser::Location.hot.paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end

  def show
    @location = Ruser::Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json
    end
  end

  def new
    @location = Ruser::Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.json
    end
  end

  def edit
    @location = Ruser::Location.find(params[:id])
  end

  def create
    @location = Ruser::Location.new(params[:location])

    respond_to do |format|
      if @location.save
        format.html { redirect_to(cpanel_locations_path, :notice => 'Location 创建成功。') }
        format.json
      else
        format.html { render :action => "new" }
        format.json
      end
    end
  end

  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to(cpanel_locations_path, :notice => 'Location 更新成功。') }
        format.json
      else
        format.html { render :action => "edit" }
        format.json
      end
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to(cpanel_locations_path,:notice => "删除成功。") }
      format.json
    end
  end
end
