# coding: utf-8
class Rforum::Cpanel::PagesController < Rforum::Cpanel::ApplicationController

  def index
    @pages = Rforum::Page.unscoped.desc(:_id).paginate :page => params[:page], :per_page => 30

  end

  def show
    @page = Rforum::Page.unscoped.find(params[:id])

  end

  def new
    @page = Rforum::Page.new

  end

  def edit
    @page = Rforum::Page.unscoped.find(params[:id])
  end

  def create
    @page = Rforum::Page.new(params[:page])

    if @page.save
      redirect_to(cpanel_pages_path, :notice => 'Page was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @page = Rforum::Page.unscoped.find(params[:id])
    @page.title = params[:page][:title]
    @page.body = params[:page][:body]
    @page.slug = params[:page][:slug]
    @page.locked = params[:page][:locked]
    @page.user_id = current_user.id

    if @page.save
      redirect_to(cpanel_pages_path, :notice => 'Page was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @page = Rforum::Page.unscoped.find(params[:id])
    @page.destroy

    redirect_to(cpanel_pages_path)
  end
end
