# coding: utf-8
class Rforum::Cpanel::PostsController < Rforum::Cpanel::ApplicationController

  def index
    @posts = Rforum::Post.unscoped.desc(:_id).includes(:user).paginate :page => params[:page], :per_page => 30
  end

  def show
    @post = Rforum::Post.unscoped.find(params[:id])

    drop_breadcrumb("文章",:use_route => :rforum)

  end

  def new
    @post = Rforum::Post.new
    drop_breadcrumb("文章",:use_route => :rforum)
    drop_breadcrumb("创建",:use_route => :rforum)
  end

  def edit
    @post = Rforum::Post.unscoped.find(params[:id])
    @post.tag_list = @post.tags.join(", ")

  end

  def create
    @post = Rforum::Post.new(params[:post])
    if @post.save
      redirect_to(cpanel_posts_path, :notice => 'Post was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @post = Rforum::Post.unscoped.find(params[:id])
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    @post.tag_list = params[:post][:tag_list]
    @post.user_id = params[:post][:user_id]
    @post.state = params[:post][:state]

    if @post.update_attributes(params[:post])
      redirect_to(cpanel_posts_path, :notice => 'Post was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @post = Rforum::Post.unscoped.find(params[:id])
    @post.destroy

    redirect_to(cpanel_posts_path)
  end
end
