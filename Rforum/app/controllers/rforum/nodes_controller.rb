# coding: utf-8
class Rforum::NodesController < Rforum::RforumController

  def index
    @nodes = Rforum::Node.all
    render :json => @nodes, :only => [:name], :methods => [:id]
  end
end
