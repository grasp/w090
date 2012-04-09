# coding: utf-8
class Rforum::Cpanel::SectionsController < Rforum::Cpanel::ApplicationController

  def index
    @sections = Rforum::Section.all

  end

  def show
    @section = Rforum::Section.find(params[:id])

  end

  def new
    @section = Rforum::Section.new
  end

  def edit
    @section = Rforum::Section.find(params[:id])
  end

  def create
    @section = Rforum::Section.new(params[:section])

    if @section.save
      redirect_to(cpanel_sections_path, :notice => 'Section was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @section = Rforum::Section.find(params[:id])

    if @section.update_attributes(params[:section])
      redirect_to(cpanel_sections_path, :notice => 'Section was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @section = Rforum::Section.find(params[:id])
    @section.destroy

    redirect_to(cpanel_sections_url)
  end


end
