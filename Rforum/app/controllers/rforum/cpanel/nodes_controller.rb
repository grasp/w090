# coding: utf-8
class Rforum::Cpanel::NodesController < Rforum::Cpanel::ApplicationController

  def index
    @nodes = Rforum::Node.sorted
  end

  def show
    @node = Rforum::Node.find(params[:id])
  end

  def new
    @node = Rforum::Node.new
  end

  def edit
    @node = Rforum::Node.find(params[:id])
  end

  def create
    @node = Rforum::Node.new(params[:node])

    if @node.save
      redirect_to(cpanel_nodes_path, :notice => 'Node was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @node = Rforum::Node.find(params[:id])

    if @node.update_attributes(params[:node])
      redirect_to(cpanel_nodes_path, :notice => 'Node was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @node = Rforum::Node.find(params[:id])
    @node.destroy

    redirect_to(cpanel_nodes_url)
  end
end
