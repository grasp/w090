# coding: UTF-8
class Rforum::Cpanel::SitesController < Rforum::Cpanel::ApplicationController

  def index
    @sites = Rforum::Site.unscoped.recent.paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end

  def show
    @site = Rforum::Site.unscoped.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json
    end
  end

  def new
    @site = Rforum::Site.new

    respond_to do |format|
      format.html # new.html.erb
      format.json
    end
  end

  def edit
    @site = Rforum::Site.unscoped.find(params[:id])
  end

  def create
    @site = Rforum::Site.new(params[:site])

    respond_to do |format|
      if @site.save
        format.html { redirect_to(cpanel_sites_path, :notice => 'Site 创建成功。') }
        format.json
      else
        format.html { render :action => "new" }
        format.json
      end
    end
  end

  def update
    @site = Rforum::Site.unscoped.find(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to(cpanel_sites_path, :notice => 'Site 更新成功。') }
        format.json
      else
        format.html { render :action => "edit" }
        format.json
      end
    end
  end

  def destroy
    @site = Rforum::Site.unscoped.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to(cpanel_sites_path,:notice => "删除成功。") }
      format.json
    end
  end
end
