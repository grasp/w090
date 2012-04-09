# coding: utf-8
class Rforum::Cpanel::PhotosController < Rforum::Cpanel::ApplicationController

  def index
    @photos = Rforum::Photo.recent.paginate :page => params[:page], :per_page => 20
  end

  def show
    @photo = Rforum::Photo.find(params[:id])
  end

  def new
    @photo = Rforum::Photo.new
  end

  def edit
    @photo = Rforum::Photo.find(params[:id])
  end

  def create
    @photo = Rforum::Photo.new(params[:photo])
    @photo.user_id = current_user.id
    if @photo.save
      redirect_to(cpanel_photo_path(@photo), :notice => 'Photo was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @photo = Rforum::Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      redirect_to(cpanel_photo_path(@photo), :notice => 'Photo was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @photo = Rforum::Photo.find(params[:id])
    @photo.destroy

    redirect_to(cpanel_photos_url)
  end
end
